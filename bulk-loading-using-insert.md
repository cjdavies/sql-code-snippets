Short answer: **Yes—one set-based insert is typically more efficient than many single-row insert statements.**  
In SQL Server, doing:

```sql
INSERT INTO dbo.Target(col1, col2, ...)
SELECT v.col1, v.col2, ...
FROM (VALUES
    (1, 'A', ...),
    (2, 'B', ...),
    ...
) AS v(col1, col2, ...);
```

(or `INSERT ... VALUES (...), (...), ...`) generally outperforms issuing many individual `INSERT` statements.

***

## Why it’s more efficient

1.  **Fewer round-trips & compilations**
    *   One statement means one parse/compile/optimize cycle and one network round-trip, versus N cycles for N separate inserts.
    *   Even with plan caching, repeated single-row statements incur more overhead.

2.  **Set-based execution**
    *   SQL Server’s engine is optimized for set-based operations. A single insert of multiple rows can be handled more efficiently internally than a loop of single-row inserts.

3.  **Logging & locking behavior**
    *   Although each row is still logged, a single statement often results in more efficient log records and lock usage (lock escalation can move to a table lock rather than holding many individual row locks for long).
    *   Multiple separate statements extend the transaction log with more individual commit records (unless you batch them in a single explicit transaction), and can create more lock churn.

4.  **Better interaction with indexes & constraints**
    *   With a set-based insert, index maintenance can be optimized over the batch; per-row insert forces index updates many times.
    *   Foreign key checks and constraints are evaluated per statement. One statement can be cheaper than thousands of individual checks.

***

## When the difference is small—or when it isn’t

*   **Small row counts (e.g., < 50–100 rows):** the difference may be negligible.
*   **Large volumes (thousands to millions):** batching is critical. Even a giant single statement can become unwieldy (very large T-SQL payload, long compile times, large transaction and potential blocking).
*   **Very large data loads:** prefer *bulk* methods (e.g., `BULK INSERT`, `bcp`, `OPENROWSET(BULK)`) or *Table-Valued Parameters (TVPs)*. These are designed for throughput and often enable minimal logging under the right conditions.

***

## Practical guidance (SQL Server best practices)

1.  **Use set-based inserts**
    *   Prefer `INSERT … SELECT FROM (VALUES …)` or `INSERT … SELECT …` from a staging/temp table over many single-row inserts.

2.  **Batch size**
    *   For large loads, send rows in batches (e.g., 500–5,000 rows per batch). Tune based on:
        *   Transaction log growth
        *   Lock escalation
        *   Index update cost
        *   Network payload size

3.  **Transactions**
    *   Wrap each batch in an explicit transaction to reduce commit overhead but keep transactions short to limit blocking and log impact:
        ```sql
        BEGIN TRAN;

        INSERT INTO dbo.Target(...) 
        SELECT ...
        FROM (VALUES (...), (...), ...) AS v(...);

        COMMIT;
        ```

4.  **Minimal logging**
    *   If you need higher throughput, consider:
        *   Recovery model `SIMPLE` or `BULK_LOGGED`
        *   Bulk operations (`BULK INSERT`, `bcp`, `OPENROWSET(BULK)`)
        *   In-rowstore inserts, SQL Server can apply minimal logging in certain scenarios for bulk operations; for indexed tables this is more limited, so measure.

5.  **Indexes & constraints**
    *   Heavy indexing slows inserts. For very large loads:
        *   Load into a heap (no clustered index) or staging table
        *   Build/enable indexes after loading (or disable and re-enable)
        *   Check foreign keys and triggers—these can dominate cost.

6.  **Alternatives for app-side inserts**
    *   **Table-Valued Parameters (TVPs):** pass a set of rows from the client in one call.
    *   **`SqlBulkCopy` (ADO.NET):** very fast for larger batches.
    *   Avoid per-row ORM patterns; use batch APIs.

7.  **Measure**
    *   Use:
        ```sql
        SET STATISTICS IO, TIME ON;
        ```
        and Extended Events (or Query Store) to compare:
        *   CPU time
        *   Duration
        *   Logical reads
        *   Log write bytes
        *   Rows/sec

***

## Example comparisons

**Multiple single-row inserts (slower for larger counts):**

```sql
BEGIN TRAN;
INSERT INTO dbo.Target(col1, col2) VALUES (1, 'A');
INSERT INTO dbo.Target(col1, col2) VALUES (2, 'B');
-- repeat...
COMMIT;
```

**Single set-based insert (faster and cleaner):**

```sql
INSERT INTO dbo.Target(col1, col2)
SELECT v.col1, v.col2
FROM (VALUES
    (1, 'A'),
    (2, 'B')
    -- ...
) AS v(col1, col2);
```

**TVP approach (recommended from app tiers):**

```sql
-- Define a table type once:
CREATE TYPE dbo.MyRows AS TABLE (col1 int, col2 nvarchar(50));

-- Procedure:
CREATE PROCEDURE dbo.InsertMyRows
    @Rows dbo.MyRows READONLY
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Target(col1, col2)
    SELECT col1, col2
    FROM @Rows;
END
```

***

## Bottom line

*   For more than a handful of rows, **prefer a single set-based insert** (including `INSERT … SELECT FROM (VALUES …)`).
*   For thousands+ rows, **batch the inserts** or use **TVPs / bulk load** methods.
*   Always **measure in your environment**—indexes, triggers, recovery model, and concurrency all influence the actual performance.

If you share roughly how many rows you’re inserting and whether the target has heavy indexing, I can help you pick an optimal batch size and a loading strategy tailored to your table design.

Great question, Colin. There isn’t a single universal “rows per batch” cap in SQL Server—you can load very large batches—but there **are some hard limits in specific scenarios** and plenty of **practical ceilings** you’ll hit before any formal limit. Here’s the breakdown:

***

## Hard limits (actual caps)

1.  **`INSERT ... VALUES (...) , (...) , ...` (table constructor)**
    *   The `VALUES` clause has a **hard limit of 1,000 rows** per statement.
    *   If you need more than 1,000, switch to `INSERT ... SELECT ... FROM (VALUES ...) AS v(...)` in multiple chunks or load from a temp/staging table, TVP, or bulk method.

2.  **Parameters per batch/procedure**
    *   Max **2,100 parameters** in a single batch or stored procedure call.
    *   This matters if you use **Table-Valued Parameters (TVPs)** only in the sense that **each TVP counts as a single parameter**, not that the TVP’s row count is capped. TVP **row count has no explicit limit**—it’s constrained by memory/tempdb and client-side limits.

3.  **Row and column limits**
    *   Per-row size and per-table column limits still apply (e.g., row > 8,060 bytes in in-row storage has special handling, large row overflow, etc.), but these don’t constrain “rows per batch” directly—just what can be inserted.

***

## No fixed “rows per batch” limit (but practical ceilings)

For **`INSERT ... SELECT`**, **TVPs**, **`BULK INSERT`**, or **`SqlBulkCopy`**, SQL Server doesn’t set a hard “rows in one batch” limit. Instead, you’ll be gated by:

*   **Transaction log capacity & growth**
    *   Large single-batch inserts generate a lot of log; in `FULL` recovery, this can become a bottleneck. Batching (e.g., 1k–10k rows per batch) helps keep transactions manageable.

*   **Locking & lock escalation**
    *   Big batches can escalate to table locks; that’s fine for offline loads but can block concurrent OLTP workloads.

*   **Memory pressure**
    *   Large batches, especially with many indexes or triggers, can consume memory for row versions, constraint checks, etc.

*   **Compile time & payload size**
    *   Extremely large statements (especially huge `VALUES` payloads or complex `INSERT ... SELECT` with joins) can increase parse/compile time and plan cache pressure.

*   **Client API limits**
    *   For example, `SqlBulkCopy.BatchSize` is an `int`; functionally you can set very large values, but you’ll typically tune between **5,000–100,000 rows** depending on your environment. Setting `BatchSize=0` processes all rows in one batch.

***

## Practical recommendations

*   **Prefer set-based inserts** (`INSERT ... SELECT`) or **bulk methods** (TVP, `SqlBulkCopy`, `BULK INSERT`) over many single-row statements.

*   **Batch thoughtfully**:
    *   Start with **1,000–10,000 rows per batch** for OLTP-sized tables.
    *   For pure bulk loads (nightly loads, low concurrency), **50,000–100,000** rows per batch may be fine.
    *   Measure with `SET STATISTICS IO, TIME ON;` and monitor log write bytes, lock waits, and duration.

*   **Consider recovery model & indexing**:
    *   For large loads, `SIMPLE` or `BULK_LOGGED` can reduce log volume (if feasible).
    *   Load into a staging table (few/no indexes), then switch/merge into the target.
    *   Disable/rebuild nonclustered indexes for very large loads if downtime permits.

*   **TVPs for app-side batching**:
    *   TVPs are excellent for sending many rows from the app in one call; no hard row limit, but keep batch sizes reasonable to avoid memory pressure.

***

## Examples

**VALUES (capped at 1,000 rows per statement):**

```sql
INSERT INTO dbo.Target(col1, col2)
VALUES
  (1, 'A'),
  (2, 'B'),
  -- up to 1,000 total rows
  (...);
```

**Set-based from a staging table (no fixed row cap):**

```sql
BEGIN TRAN;

INSERT INTO dbo.Target(col1, col2, ...)
SELECT col1, col2, ...
FROM dbo.Staging
WHERE BatchId = 42;  -- your chosen batch

COMMIT;
```

**Table-Valued Parameter approach (no explicit row cap, constrained by memory/tempdb):**

```sql
-- Define once:
CREATE TYPE dbo.MyRows AS TABLE (
  col1 int,
  col2 nvarchar(50)
);

-- Procedure:
CREATE PROCEDURE dbo.InsertMyRows
  @Rows dbo.MyRows READONLY
AS
BEGIN
  SET NOCOUNT ON;

  INSERT INTO dbo.Target(col1, col2)
  SELECT col1, col2
  FROM @Rows;
END
```

***

## Bottom line

*   **Yes, there’s a hard limit of 1,000 rows in a single `VALUES` clause.**
*   For **`INSERT ... SELECT`**, **TVPs**, and **bulk load tools**, there’s **no fixed “rows per batch” limit**—your practical cap is dictated by transaction log, locking, memory, and client API choices.
*   Start with **moderate batch sizes**, measure, then tune up or down.

If you share roughly how many rows you load and whether your target tables are heavily indexed (and your recovery model), I can recommend an initial batch size and loading pattern tailored to your SQL Server 2022 environment.

For 40,000 rows, you’re well beyond the 1,000-row `VALUES` limit, so you’ll need a batching strategy. Here’s what works best in SQL Server 2022:

***

### ✅ Recommended Approach

*   **Batch size:** Start with **5,000–10,000 rows per batch**. This keeps transaction log growth and lock escalation manageable while still being efficient.
*   **Method:**
    1.  Load rows into a **staging table** (or pass them via a **Table-Valued Parameter** if coming from an app).
    2.  Use `INSERT ... SELECT` in batches:
        ```sql
        BEGIN TRAN;

        INSERT INTO dbo.Target(col1, col2, ...)
        SELECT col1, col2, ...
        FROM dbo.Staging
        WHERE BatchId = 1;  -- or TOP (5000)

        COMMIT;
        ```
    3.  Repeat for each batch until all 40,000 rows are processed.

***

### ✅ Why not one giant batch?

*   **Transaction log:** A single 40k-row insert in `FULL` recovery can balloon the log and slow down commits.
*   **Lock escalation:** Large batches often escalate to table locks, blocking other sessions.
*   **Compile time:** Huge statements (especially if using `VALUES`) can increase parse/compile overhead.

***

### ✅ Alternatives for speed

*   **Table-Valued Parameters (TVPs):** Great for app-side batching; no hard row limit.
*   **`SqlBulkCopy` or `BULK INSERT`:** Fastest for large loads, especially if you can use `SIMPLE` or `BULK_LOGGED` recovery and minimal indexing.
*   **Disable/rebuild nonclustered indexes** if downtime is acceptable.

***

### ✅ Practical tip

For 40,000 rows:

*   **4 batches of 10,000 rows** or **8 batches of 5,000 rows** is a good starting point.
*   Wrap each batch in its own transaction.
*   Monitor log usage and adjust batch size if needed.

***

Do you want me to give you **a ready-to-use T-SQL script** for:

*   **Batching from a staging table**, or
*   **Using a Table-Valued Parameter**, or
*   **A `SqlBulkCopy` example for .NET**?

Which one fits your workflow best?
