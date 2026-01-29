Here is a clean, **ready‑to‑run SQL Server 2022 demo** that shows exactly how **system‑versioned temporal tables** behave — including INSERT, UPDATE, DELETE, and how history rows are generated.

This demo is **temporal only** (no CDC).

***

# 🧪 **Full Temporal Table Demo (SQL Server 2016–2022)**

Just copy/paste and run in SSMS or Azure Data Studio.

***

# 1️⃣ **Create a Demo Database (optional)**

```sql
CREATE DATABASE TemporalDemo;
GO
USE TemporalDemo;
GO
```

***

# 2️⃣ **Create a System-Versioned Temporal Table**

```sql
CREATE TABLE dbo.Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    PositionTitle NVARCHAR(50) NOT NULL,

    -- Required for temporal tables:
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START,
    ValidTo   DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON 
      (HISTORY_TABLE = dbo.EmployeeHistory));
GO
```

This automatically creates the history table `EmployeeHistory` with matching schema + system period columns. It also automatically creates a clustered index on the history table using ValidFrom and ValidTo.

***

# 3️⃣ **Insert Initial Rows**

```sql
INSERT INTO Employee (FullName, PositionTitle)
VALUES ('Alice Johnson', 'Engineer'),
       ('Bob Smith', 'Analyst');
GO
```

### ✅ What happens here?

*   Rows go into **Employee** (the *current* table)
*   **No history rows are created yet**, because no prior version exists

***

# 4️⃣ **Check Current Table & History Table**

```sql
SELECT * FROM Employee;
SELECT * FROM EmployeeHistory;
```

### Expected:

*   `Employee` → 2 rows
*   `EmployeeHistory` → **0 rows**

***

# 5️⃣ **Update a Row (Creates First History Record)**

```sql
UPDATE Employee
SET PositionTitle = 'Senior Engineer'
WHERE FullName = 'Alice Johnson';
GO
```

### Now check again:

```sql
SELECT * FROM Employee;
SELECT * FROM EmployeeHistory;
```

### Expected:

*   `Employee` → Alice now shows **Senior Engineer**
*   `EmployeeHistory` → contains **Alice’s previous version**

This is when the history table first gets used.

***

# 6️⃣ **Delete a Row (Creates History Version)**

```sql
DELETE FROM Employee
WHERE FullName = 'Bob Smith';
GO
```

Check again:

```sql
SELECT * FROM Employee;
SELECT * FROM EmployeeHistory;
```

### Expected:

*   `Employee` → Bob is gone
*   `EmployeeHistory` → contains Bob’s final version

***

# 7️⃣ **Query with FOR SYSTEM\_TIME**

Temporal tables allow point‑in‑time analysis.

## Query records as of 10 minutes ago:

```sql
SELECT *
FROM Employee
FOR SYSTEM_TIME AS OF DATEADD(MINUTE, -10, SYSUTCDATETIME());
```

## Query full version history:

```sql
SELECT *
FROM Employee
FOR SYSTEM_TIME ALL
ORDER BY EmployeeID, ValidFrom;
```

***

# 8️⃣ **Turn Off System Versioning (Optional Cleanup)**

If you want to modify or drop the tables later:

```sql
ALTER TABLE Employee
SET (SYSTEM_VERSIONING = OFF);
```

Then:

```sql
DROP TABLE Employee;
DROP TABLE EmployeeHistory;
```

***

# 🧭 Summary of What the Demo Shows

### ✔ INSERT

Stored only in **current table**, no history entry created.

### ✔ UPDATE

Creates **history record** with previous version.

### ✔ DELETE

Creates a **final history record** and removes row from current table.

### ✔ SYSTEM\_TIME queries

Show full temporal behavior.

***

If you want, I can also generate:

*   A **CDC-only** demo
*   A **Temporal + CDC combined** demo
*   A side‑by‑side comparison script
*   A recommended indexing pattern for temporal tables

Just tell me what you want next!

# Rollback 

Great—thanks for sharing your exact schema. Since your table is:

```sql
CREATE TABLE dbo.Employee (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    PositionTitle NVARCHAR(50) NOT NULL,

    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START,
    ValidTo   DATETIME2 GENERATED ALWAYS AS ROW END,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeHistory));
```

Here are **ready-to-run scripts** for the most common scenarios, tailored to `dbo.Employee` and `dbo.EmployeeHistory`.

***

## A) Drop the temporal table completely (current + history)

> Required sequence: turn off versioning → drop history → drop current table.

```sql
-- 1) Turn off system versioning
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = OFF);

-- 2) Drop the history table
DROP TABLE dbo.EmployeeHistory;

-- 3) Drop the current table
DROP TABLE dbo.Employee;
```

**Notes**

*   If there are foreign keys, triggers, or dependencies referencing either table, drop or disable those first.
*   You need `ALTER` on `dbo.Employee` and `DROP` on both tables.

***

## B) Keep `Employee` as a regular (non-temporal) table

> This converts the table from temporal to normal. You can keep or drop the period columns.

### Option B1: Convert to regular table and **keep** the columns (as normal `datetime2`)

```sql
-- 1) Turn off system versioning
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = OFF);

-- 2) Drop the PERIOD definition (required before altering/dropping start/end columns)
ALTER TABLE dbo.Employee
DROP PERIOD FOR SYSTEM_TIME;

-- 3) (Optional but common) Remove the generated attributes so they become normal datetime2 columns
ALTER TABLE dbo.Employee
ALTER COLUMN ValidFrom datetime2 NOT NULL;

ALTER TABLE dbo.Employee
ALTER COLUMN ValidTo   datetime2 NOT NULL;
```

> After step 3, `ValidFrom`/`ValidTo` are regular `datetime2` columns you can maintain yourself.

If you also want to **remove the history table** (it’s now just a normal table since versioning is off):

```sql
DROP TABLE dbo.EmployeeHistory;
```

***

### Option B2: Convert to regular table and **drop** the period columns

```sql
-- 1) Turn off system versioning
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = OFF);

-- 2) Drop the PERIOD definition
ALTER TABLE dbo.Employee
DROP PERIOD FOR SYSTEM_TIME;

-- 3) Drop the row start/end columns
ALTER TABLE dbo.Employee
DROP COLUMN ValidFrom, ValidTo;

-- 4) (Optional) If you don’t need historical rows, drop the history table too
DROP TABLE dbo.EmployeeHistory;
```

***

## C) Just detach history but **keep** both tables

> Sometimes you want to preserve history data as a static snapshot.

```sql
-- Turn off versioning; history becomes a regular table
ALTER TABLE dbo.Employee
SET (SYSTEM_VERSIONING = OFF);

-- (Optional) Leave PERIOD and columns in place, or convert/drop them as in B1/B2
-- History remains as dbo.EmployeeHistory and can be archived, backed up, or left as-is.
```

***

## Helpful checks (dependencies, history name, state)

**Find the history table name and versioning state**

```sql
SELECT 
    TemporalSchema    = OBJECT_SCHEMA_NAME(t.object_id),
    TemporalTable     = t.name,
    HistorySchema     = OBJECT_SCHEMA_NAME(t.history_table_id),
    HistoryTable      = OBJECT_NAME(t.history_table_id),
    t.temporal_type   -- 2 = system-versioned, 1 = history, 0 = non-temporal
FROM sys.tables AS t
WHERE t.object_id = OBJECT_ID('dbo.Employee');
```

**Check for foreign keys referencing `dbo.EmployeeHistory`**

```sql
SELECT 
    fk.name AS ForeignKeyName,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS ReferencingSchema,
    OBJECT_NAME(fk.parent_object_id) AS ReferencingTable
FROM sys.foreign_keys AS fk
WHERE fk.referenced_object_id = OBJECT_ID('dbo.EmployeeHistory');
```

If any appear, drop/disable them before dropping the history table:

```sql
ALTER TABLE <schema>.<table> DROP CONSTRAINT <ForeignKeyName>;
```

***

## Common gotchas (and fixes)

*   **Order matters**: You must `SET (SYSTEM_VERSIONING = OFF)` **before** `DROP PERIOD FOR SYSTEM_TIME` and before dropping `ValidFrom/ValidTo`.
*   **Dropping columns**: You cannot drop `ValidFrom/ValidTo` while the period exists—drop the `PERIOD FOR SYSTEM_TIME` first.
*   **Permissions**: Ensure you have `ALTER` on the table and `DROP` on target tables.
*   **Triggers/constraints/indexes**: Any dependency can block a drop; remove them first.

***

If you tell me which option you prefer (A, B1, or B2), I’ll produce a single consolidated script with dependency checks and transaction wrapping to make it rollback-safe.

Perfect—here’s a **rollback-safe** script that:

*   Runs in a single explicit transaction.
*   Handles errors with `TRY…CATCH`, rolls back on failure, and re-throws the error.
*   Checks for existence of both tables.
*   Turns off system versioning **only if it’s currently ON**.
*   Drops the **actual** history table name from metadata (in case it differs).
*   Uses `DROP TABLE IF EXISTS` to be idempotent (SQL Server 2016+).

> Tailored for: `dbo.Employee` (temporal) and its history table (configured as `dbo.EmployeeHistory`).

***

### ✅ Rollback-safe drop script

```sql
SET XACT_ABORT ON;
GO

BEGIN TRY
    BEGIN TRAN;

    DECLARE @TemporalTable sysname = N'dbo.Employee';
    DECLARE @TemporalObjId int     = OBJECT_ID(@TemporalTable);

    IF @TemporalObjId IS NULL
    BEGIN
        PRINT 'Temporal table dbo.Employee does not exist. Nothing to do.';
        ROLLBACK;  -- End cleanly; no changes made
        RETURN;
    END

    -- Discover current temporal state & history table from metadata
    DECLARE @TemporalType int;
    DECLARE @HistoryObjId int;
    DECLARE @HistoryName  sysname;
    DECLARE @HistorySchema sysname;

    SELECT 
        @TemporalType = t.temporal_type,           -- 2 = system-versioned
        @HistoryObjId = t.history_table_id,
        @HistoryName  = OBJECT_NAME(t.history_table_id),
        @HistorySchema= OBJECT_SCHEMA_NAME(t.history_table_id)
    FROM sys.tables AS t
    WHERE t.object_id = @TemporalObjId;

    -- If system versioning is ON, turn it OFF first
    IF @TemporalType = 2
    BEGIN
        PRINT 'Turning OFF SYSTEM_VERSIONING on dbo.Employee...';
        ALTER TABLE dbo.Employee
        SET (SYSTEM_VERSIONING = OFF);
        PRINT 'SYSTEM_VERSIONING is OFF.';
    END
    ELSE
    BEGIN
        PRINT 'SYSTEM_VERSIONING already OFF or table not temporal.';
    END

    -- Drop the history table if it exists
    IF @HistoryObjId IS NOT NULL
    BEGIN
        DECLARE @QualifiedHistory nvarchar(514) = QUOTENAME(@HistorySchema) + N'.' + QUOTENAME(@HistoryName);

        IF OBJECT_ID(@QualifiedHistory) IS NOT NULL
        BEGIN
            PRINT 'Dropping history table ' + @QualifiedHistory + ' ...';
            DECLARE @sql nvarchar(max) = N'DROP TABLE IF EXISTS ' + @QualifiedHistory + ';';
            EXEC (@sql);
            PRINT 'History table dropped.';
        END
        ELSE
        BEGIN
            PRINT 'History table metadata present but object not found; skipping drop.';
        END
    END
    ELSE
    BEGIN
        PRINT 'No history table associated (history_table_id is NULL); nothing to drop.';
    END

    -- Drop the temporal (current) table
    PRINT 'Dropping temporal table [dbo].[Employee] ...';
    DROP TABLE IF EXISTS dbo.Employee;
    PRINT 'Temporal table dropped.';

    COMMIT TRAN;
    PRINT 'Transaction committed successfully.';
END TRY
BEGIN CATCH
    DECLARE @ErrMsg nvarchar(4000) = ERROR_MESSAGE();
    DECLARE @ErrSeverity int       = ERROR_SEVERITY();
    DECLARE @ErrState int          = ERROR_STATE();

    IF XACT_STATE() <> 0
        ROLLBACK TRAN;

    -- Re-throw with original details
    THROW 50001, @ErrMsg, 1;
END CATCH;
GO
```

***

### 🔍 What this script does for you

*   **Safety-first**: If anything goes wrong, you get a **full rollback**.
*   **Metadata-driven**: It fetches the **actual** history table name via `sys.tables.history_table_id`, so it works even if someone changed the history table name after creation.
*   **Idempotent**: Uses `DROP TABLE IF EXISTS` to avoid errors if a table was already removed.
*   **Clear logging**: `PRINT` statements show progress in Messages.

***

### Optional hardening (add if needed)

*   **Dependency checks** (foreign keys referencing the history table) before drop:

```sql
SELECT 
    fk.name AS ForeignKeyName,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS ReferencingSchema,
    OBJECT_NAME(fk.parent_object_id) AS ReferencingTable
FROM sys.foreign_keys AS fk
WHERE fk.referenced_object_id = OBJECT_ID(N'dbo.EmployeeHistory');
```

If any exist, drop them first:

```sql
ALTER TABLE <schema>.<table> DROP CONSTRAINT <ForeignKeyName>;
```

*   **Permission note**: You’ll need `ALTER` on `dbo.Employee` and `DROP` on the tables.

***

If you want, I can wrap **dependency detection and automatic FK drops** into the transaction as well (with a report of what was removed).
