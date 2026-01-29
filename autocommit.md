Yes, what you’re seeing is expected behavior in SQL Server. Here’s the explanation:

***

### ✅ Is Auto-Commit a Feature?

Yes. **SQL Server uses auto-commit mode by default**. This means:

*   Every individual DML statement (`INSERT`, `UPDATE`, `DELETE`, `MERGE`) runs in its own implicit transaction.
*   When the statement completes successfully, SQL Server automatically issues a `COMMIT` behind the scenes.
*   If the statement fails, SQL Server issues a `ROLLBACK`.

So you don’t need to explicitly write `COMMIT` unless you start an **explicit transaction** with `BEGIN TRAN`.

***

### ✅ How to Determine if Auto-Commit Is Enabled?

Auto-commit is the default unless you explicitly change the transaction mode. You can check the current transaction state using:

```sql
SELECT @@OPTIONS AS CurrentOptions;
```
Great observation! The value `6008` from `SELECT @@OPTIONS` is a **bitmask** representing which SET options are currently enabled for your session. Each option corresponds to a power-of-two value, and the sum of those values gives you the bitmask.

***

### ✅ How to interpret `6008`

`@@OPTIONS` is the sum of all active options. To decode it, you compare against the documented values:

| Option                     | Value |
| -------------------------- | ----- |
| ANSI\_WARNINGS             | 8     |
| ANSI\_PADDING              | 16    |
| ANSI\_NULLS                | 32    |
| QUOTED\_IDENTIFIER         | 256   |
| ARITHABORT                 | 64    |
| CONCAT\_NULL\_YIELDS\_NULL | 4096  |
| IMPLICIT\_TRANSACTIONS     | 2     |
| CURSOR\_CLOSE\_ON\_COMMIT  | 4     |
| ... (many others)          |       |

Now, break down `6008`:

    6008 = 4096 + 256 + 64 + 32 + 16 + 8

So the enabled options are:

*   **CONCAT\_NULL\_YIELDS\_NULL** (4096)
*   **QUOTED\_IDENTIFIER** (256)
*   **ARITHABORT** (64)
*   **ANSI\_NULLS** (32)
*   **ANSI\_PADDING** (16)
*   **ANSI\_WARNINGS** (8)

Notice **IMPLICIT\_TRANSACTIONS (2)** is NOT included → so **auto-commit mode is active**.

***

### ✅ Quick way to see them without math

Run:

```sql
DBCC USEROPTIONS;
```

This lists all active options in plain text (much easier than decoding the bitmask).

***

### ✅ Why does this matter?

*   Since `IMPLICIT_TRANSACTIONS` is OFF, your session is in **auto-commit mode**.
*   Every DML statement commits automatically unless you explicitly start a transaction with `BEGIN TRAN`.

***

Do you want me to give you:

*   **A full table of all @@OPTIONS bit values**, or
*   **A quick script to decode @@OPTIONS into readable option names automatically**?

Look for the **IMPLICIT\_TRANSACTIONS** setting:

*   If **IMPLICIT\_TRANSACTIONS** is **OFF** → Auto-commit mode is active.
*   If **IMPLICIT\_TRANSACTIONS** is **ON** → SQL Server will start a transaction automatically after each statement, but you must explicitly `COMMIT` or `ROLLBACK`.

You can also check with:

```sql
DBCC USEROPTIONS;
```

This returns a list of session-level options. If you see `implicit_transactions` in the list, it’s ON; otherwise, auto-commit is in effect.

***

### ✅ How to Change It?

*   To enable implicit transactions:
    ```sql
    SET IMPLICIT_TRANSACTIONS ON;
    ```
*   To revert to auto-commit:
    ```sql
    SET IMPLICIT_TRANSACTIONS OFF;
    ```

***

### ✅ Quick Summary

*   **Auto-commit = default behavior** in SQL Server.
*   Each standalone DML statement commits automatically.
*   To require explicit commits, turn on `IMPLICIT_TRANSACTIONS` or use `BEGIN TRAN` / `COMMIT`.

***

Do you want me to give you **a quick script that shows your current transaction mode and demonstrates the difference between auto-commit and implicit transactions**?

Awesome—here’s a **ready-to-run demo** you can paste into SSMS to:

1.  **Show your current transaction mode** (auto-commit vs implicit).
2.  **Demonstrate auto-commit** behavior.
3.  **Demonstrate implicit transactions** and the need for explicit `COMMIT`.
4.  Inspect **`@@TRANCOUNT`, `XACT_STATE()`**, and **session options** along the way.

> 🧪 The script uses a temp table, so it’s safe and self-contained.

***

## 1) Check current session settings

```sql
-- See session-level options (includes implicit_transactions if ON)
DBCC USEROPTIONS;

-- Bitmask of options; useful to capture for troubleshooting
SELECT @@OPTIONS AS CurrentOptions;

-- Check transaction nesting level (0 means no active explicit transaction)
SELECT @@TRANCOUNT AS TranCount;

-- XACT_STATE returns:
--  1 = active transaction, can be committed
--  0 = no active transaction
-- -1 = active transaction, but in an uncommittable state (requires ROLLBACK)
SELECT XACT_STATE() AS XactState;
```

***

## 2) Demonstrate **Auto-Commit** (default mode)

```sql
-- Ensure auto-commit (implicit transactions OFF)
SET IMPLICIT_TRANSACTIONS OFF;

-- Sanity check the mode
DBCC USEROPTIONS; -- you should NOT see 'implicit_transactions' listed
SELECT @@TRANCOUNT AS TranCount_AutoCommit_Before;

-- Set up a temp table
IF OBJECT_ID('tempdb..#Demo') IS NOT NULL DROP TABLE #Demo;
CREATE TABLE #Demo
(
    id      int NOT NULL PRIMARY KEY,
    payload nvarchar(100) NOT NULL
);

-- Each statement is its own transaction and auto-commits on success
INSERT INTO #Demo(id, payload) VALUES (1, N'auto-commit row 1');
INSERT INTO #Demo(id, payload) VALUES (2, N'auto-commit row 2');

-- Observe data is persisted without explicit COMMIT
SELECT * FROM #Demo;

-- Check that there is no active transaction
SELECT @@TRANCOUNT AS TranCount_AutoCommit_After,
       XACT_STATE() AS XactState_AutoCommit;
```

**What to expect:**

*   No `COMMIT` statements, yet rows are visible—SQL Server committed each statement automatically.
*   `@@TRANCOUNT` remains `0`, `XACT_STATE()` is `0`.

***

## 3) Demonstrate **Implicit Transactions** (requires explicit COMMIT/ROLLBACK)

```sql
-- Turn ON implicit transactions for this session
SET IMPLICIT_TRANSACTIONS ON;

-- Verify: you should see 'implicit_transactions' in USEROPTIONS
DBCC USEROPTIONS;
SELECT @@TRANCOUNT AS TranCount_Implicit_Before;

-- The next DML statement will start a transaction automatically
INSERT INTO #Demo(id, payload) VALUES (3, N'implicit tx row 3');

-- Now a transaction is open (you must COMMIT or ROLLBACK manually)
SELECT @@TRANCOUNT AS TranCount_After_Insert,
       XACT_STATE()   AS XactState_After_Insert;

-- If we do nothing and open a new query window (same session) data is there but not committed to others.
-- Explicitly COMMIT to finalize:
COMMIT;

-- After commit, transaction count goes back to 0
SELECT @@TRANCOUNT AS TranCount_After_Commit,
       XACT_STATE()   AS XactState_After_Commit;

-- Start another implicit transaction and show ROLLBACK
INSERT INTO #Demo(id, payload) VALUES (4, N'implicit tx to be rolled back');

SELECT @@TRANCOUNT AS TranCount_Before_Rollback,
       XACT_STATE()   AS XactState_Before_Rollback;

ROLLBACK;

SELECT @@TRANCOUNT AS TranCount_After_Rollback,
       XACT_STATE()   AS XactState_After_Rollback;

-- Final data view: row 3 committed; row 4 rolled back
SELECT * FROM #Demo;
```

**What to expect:**

*   After the first `INSERT` with `IMPLICIT_TRANSACTIONS ON`, `@@TRANCOUNT` becomes `1` (an open transaction).
*   Only after `COMMIT` do changes become permanent.
*   `ROLLBACK` undoes the second insert.

***

## 4) Explicit Transactions (for comparison)

Even with auto-commit enabled, you can control transactions explicitly:

```sql
SET IMPLICIT_TRANSACTIONS OFF;

BEGIN TRAN;  -- manually start a transaction
INSERT INTO #Demo(id, payload) VALUES (5, N'explicit BEGIN TRAN row 5');

-- Inspect state: an explicit transaction is active
SELECT @@TRANCOUNT AS TranCount_Explicit,
       XACT_STATE()   AS XactState_Explicit;

COMMIT;      -- finalize changes

SELECT * FROM #Demo;
```

***

## Key Takeaways

*   **Auto-commit is the default** in SQL Server: each successful DML statement commits automatically.
*   **`IMPLICIT_TRANSACTIONS ON`** starts a transaction for each statement, but **you must `COMMIT` or `ROLLBACK`** explicitly.
*   Use **`DBCC USEROPTIONS`** to see session options and **`@@TRANCOUNT` / `XACT_STATE()`** to understand transaction state.

***

If you’d like, I can tailor this to your exact workflow (SSMS, Azure Data Studio, or application-side with ADO.NET) and include a snippet to show **visibility from a second session** (demonstrating that uncommitted data isn’t visible under default isolation).
