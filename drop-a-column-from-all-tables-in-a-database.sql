/* Drop a column from all tables in a database.
   First, drop PK, FK, and default constraints on that column.
   Drop the column.
   Rebuild PK and FK constraints.
*/
--USE DATABASE
--GO

DECLARE @ColumnName NVARCHAR(128) = 'tenant_id';
DECLARE @SQL        NVARCHAR(MAX) = 'ALTER TABLE ';

SELECT @SQL = @SQL + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + 
              ' DROP ' + QUOTENAME(@ColumnName) + ';' + CHAR(13)
  FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_TYPE = 'BASE TABLE'
 ORDER BY TABLE_SCHEMA, TABLE_NAME;

PRINT @SQL;

EXEC sp_executesql @SQL;


/* Alternative simplified version
--USE DATABASE
--GO

DECLARE @SQL NVARCHAR(MAX) = 'ALTER TABLE ';

SELECT @SQL = @SQL + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ' DROP [tenant_id];' + CHAR(13)
  FROM INFORMATION_SCHEMA.TABLES
 WHERE TABLE_TYPE = 'BASE TABLE'
 ORDER BY TABLE_SCHEMA, TABLE_NAME;

PRINT @SQL;

EXEC sp_executesql @SQL;
*/