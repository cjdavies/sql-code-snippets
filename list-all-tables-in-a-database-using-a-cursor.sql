/* List all tables in a database using a cursor */
--USE DEMO
--GO

DECLARE @TableSchema    NVARCHAR(128);
DECLARE @TableName      NVARCHAR(128);

DECLARE TableCursor CURSOR FOR
 SELECT TABLE_SCHEMA, TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_TYPE = 'BASE TABLE'
  ORDER BY TABLE_SCHEMA, TABLE_NAME;

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @TableSchema, @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @TableSchema + '.' + @TableName;
    FETCH NEXT FROM TableCursor INTO @TableSchema, @TableName;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;
