To remove a **system-versioned temporal table** in SQL Server, you have two common goals:

1.  **Drop the table entirely** (both current and history).
2.  **Keep the table but turn off temporal/system-versioning** (and optionally remove the period columns).

Below are the safe, step-by-step scripts for both.

***

## 1) Drop a temporal table (current + history)

> You must turn off `SYSTEM_VERSIONING` before you can drop the table. Then drop the history table (if you want it gone), and finally drop the current table.

```sql
-- 1) Turn off system versioning
ALTER TABLE dbo.YourTemporalTable
SET (SYSTEM_VERSIONING = OFF);

-- 2) (Optional) If you want to drop the history table too:
--    If you know its name:
DROP TABLE dbo.YourTemporalHistoryTable;

--    If you don't know its name, find it dynamically:
SELECT 
    HistSchema = OBJECT_SCHEMA_NAME(t.history_table_id),
    HistTable  = OBJECT_NAME(t.history_table_id)
FROM sys.tables AS t
WHERE t.object_id = OBJECT_ID('dbo.YourTemporalTable');

-- 3) Drop the current table
DROP TABLE dbo.YourTemporalTable;
```

**Notes & tips**

*   If you skip step 2, the **history table remains** in the database as a normal table after turning off system versioning.
*   Ensure no foreign keys, indexes, or dependencies block the drop. Remove or drop them first if needed.
*   You need appropriate permissions (e.g., `ALTER` on the table and `DROP` on target tables).

***

## 2) Keep the table, but remove temporal/system-versioning

> This “converts” your table from temporal to a regular table. You turn off system versioning, optionally drop the PERIOD, and optionally drop or repurpose the start/end columns.

```sql
-- 1) Turn off temporal (system versioning)
ALTER TABLE dbo.YourTemporalTable
SET (SYSTEM_VERSIONING = OFF);

-- 2) (Optional) Drop the period definition
--    You must drop the PERIOD before you can drop the row start/end columns.
ALTER TABLE dbo.YourTemporalTable
DROP PERIOD FOR SYSTEM_TIME;

-- 3) (Optional) Drop the row start/end columns if you don’t want them anymore
--    Replace SysStartTime / SysEndTime with your actual column names.
ALTER TABLE dbo.YourTemporalTable
DROP COLUMN SysStartTime, SysEndTime;

--    Alternatively, keep them and repurpose as normal datetime2 columns:
--    (You can ALTER COLUMN to remove the “GENERATED ALWAYS AS ROW START/END” attribute)
-- ALTER TABLE dbo.YourTemporalTable
-- ALTER COLUMN SysStartTime datetime2 NOT NULL;
-- ALTER TABLE dbo.YourTemporalTable
-- ALTER COLUMN SysEndTime   datetime2 NOT NULL;
```

**Notes & tips**

*   You **must** drop `PERIOD FOR SYSTEM_TIME` before dropping the start/end columns.
*   If you keep the start/end columns, you can alter them to standard `datetime2` columns (no generated attributes).
*   History table (if auto-created) is **not** automatically dropped by turning off system versioning. Drop it manually if you don’t need it.

***

## How to find the history table programmatically

If you don’t remember the history table name (especially when SQL Server auto-created it):

```sql
SELECT 
    TemporalSchema    = OBJECT_SCHEMA_NAME(t.object_id),
    TemporalTable     = t.name,
    HistorySchema     = OBJECT_SCHEMA_NAME(t.history_table_id),
    HistoryTable      = OBJECT_NAME(t.history_table_id),
    t.temporal_type   -- 2 = system-versioned, 1 = history, 0 = non-temporal
FROM sys.tables AS t
WHERE t.object_id = OBJECT_ID('dbo.YourTemporalTable');
```

***

## Edge cases & gotchas

*   **Foreign keys / constraints / indexes**: Drop or disable anything referencing the history table before dropping it.
*   **Column names**: Replace `SysStartTime` and `SysEndTime` with your actual period column names.
*   **Memory-optimized temporal tables**: The sequence is the same (turn off system versioning first), but ensure you handle memory-optimized-specific constraints if present.
*   **Permissions**: You’ll typically need `ALTER` permission on the table and `CONTROL` or `DROP` permission to remove tables.

***

## References (SQL Server Documentation)

*   Microsoft Docs – *Temporal Tables* overview and management:
    *   Turning off system versioning and dropping period columns: Microsoft Learn, “Temporal tables” → Administration section.
    *   Discovering the history table via `sys.tables`: Microsoft Learn, “Temporal tables: System catalog views (`sys.tables` with `history_table_id`).”

> If you’d like, tell me your table and column names (or paste your current `CREATE TABLE`) and I’ll tailor the exact drop/convert script for your schema.

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
