USE QAAuto_Bdm;
--USE QAAuto_Bdm_Mod;
GO

DECLARE @TableName NVARCHAR(150);
DECLARE @SQL       NVARCHAR(150);

DECLARE TableCursor CURSOR FOR
 SELECT SCHEMA_NAME(schema_id) + '.' + name AS TableName
   FROM sys.tables
  WHERE is_ms_shipped = 0; -- Exclude system tables

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'UPDATE STATISTICS ' + @TableName + ' WITH FULLSCAN;';

    EXEC sp_executesql @SQL;

    FETCH NEXT FROM TableCursor INTO @TableName;
END;

CLOSE      TableCursor;
DEALLOCATE TableCursor;

PRINT 'Statistics updated with FULLSCAN for all tables.';
