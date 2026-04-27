Here is efficient T-SQL code that checks for data truncation before altering the column:

```sql
-- Check for data that would be truncated
IF EXISTS (
    SELECT 1
    FROM t1
    WHERE LEN(c1) > 65
)
BEGIN
    PRINT 'Warning: Truncation would occur. Aborting column size change.'
END
ELSE
BEGIN
    ALTER TABLE t1
    ALTER COLUMN c1 VARCHAR(65);
    PRINT 'Column successfully reverted to VARCHAR(65).'
END
```

The above script prevents the change if any value exceeds 65 characters. Use `DATALENGTH(c1)` instead of `LEN(c1)` if dealing with trailing spaces.


Here’s the modified code to allow the change but still warn about potential truncation:

```sql
-- Check for data that will be truncated
IF EXISTS (
    SELECT 1
    FROM t1
    WHERE LEN(c1) > 65
)
BEGIN
    PRINT 'Warning: Some data in column c1 exceeds 65 characters and will be truncated.';
END

-- Truncate data explicitly to avoid implicit truncation errors
UPDATE t1
SET c1 = LEFT(c1, 65)
WHERE LEN(c1) > 65;

-- Alter the column
ALTER TABLE t1
ALTER COLUMN c1 VARCHAR(65);

PRINT 'Column c1 successfully altered to VARCHAR(65).';
```

This approach ensures no error is thrown during the `ALTER TABLE`, and it logs a clear warning.


Here’s the stored procedure version with a parameter for the new length:

```sql
CREATE OR ALTER PROCEDURE dbo.TruncateAndAlterColumn
    @NewLength INT
AS
BEGIN
    SET NOCOUNT ON;

    IF @NewLength < 1 OR @NewLength > 8000
    BEGIN
        RAISERROR('Invalid length. Must be between 1 and 8000.', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM t1
        WHERE LEN(c1) > @NewLength
    )
    BEGIN
        PRINT 'Warning: Some data in column c1 exceeds the specified length and will be truncated.';
        
        UPDATE t1
        SET c1 = LEFT(c1, @NewLength)
        WHERE LEN(c1) > @NewLength;
    END

    DECLARE @sql NVARCHAR(MAX) = N'ALTER TABLE t1 ALTER COLUMN c1 VARCHAR(' + CAST(@NewLength AS NVARCHAR) + N');';
    EXEC sp_executesql @sql;

    PRINT 'Column c1 successfully altered.';
END
```

Run it like this:

```sql
EXEC dbo.TruncateAndAlterColumn @NewLength = 65;
```
