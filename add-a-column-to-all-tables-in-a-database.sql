/* Add a column to all tables in a database.
   Drop PK and FK constraints.
   Add column to tables.
   Rebuild PK and FK constraints to include the new column.
*/

DECLARE @ColumnName NVARCHAR(128) = 'tenant_id';
DECLARE @DataType   NVARCHAR(128) = 'INT';
DECLARE @Default    NVARCHAR(128) = '1';
DECLARE @SQL        NVARCHAR(MAX) = '';

SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' ADD ' + QUOTENAME(@ColumnName) + ' ' + @DataType + ' DEFAULT ' + @Default + ' NOT NULL;' + CHAR(13)
  FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_TYPE = 'BASE TABLE'
 ORDER BY TABLE_SCHEMA, TABLE_NAME;

PRINT @SQL;

EXEC sp_executesql @SQL;


/* Alternative simplified version
USE 
GO

DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = @SQL + 'ALTER TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ' ADD [tenant_id] INT DEFAULT 1 NOT NULL;' + CHAR(13)
  FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_TYPE = 'BASE TABLE'
 ORDER BY TABLE_SCHEMA, TABLE_NAME;

PRINT @SQL;

EXEC sp_executesql @SQL;
*/