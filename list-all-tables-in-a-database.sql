/* List all tables in a database */
USE SLIS;
GO

SELECT s.name AS SchemaName, t.name AS TableName
  FROM sys.tables t
  JOIN sys.schemas s ON t.schema_id = s.schema_id
 WHERE s.name != 'cdc'
 ORDER BY SchemaName, TableName;