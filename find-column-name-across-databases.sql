/* Find a column by name in all databases in an instance */
IF OBJECT_ID('tempdb..#MyResults') IS NOT NULL DROP TABLE #MyResults;
CREATE TABLE #MyResults (DatabaseName SYSNAME, SchemaName SYSNAME, TableName SYSNAME, ColumnName SYSNAME);

EXEC sp_MSforeachdb N'
USE [?];
INSERT INTO #MyResults
SELECT
    DB_NAME(),
    s.name AS SchemaName,
    t.name AS TableName,
    c.name as ColumnName
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE c.name = ''cpny_name''; 
';  -- Replace column name above

SELECT * FROM #MyResults ORDER BY DatabaseName, SchemaName, TableName, ColumnName;

DROP TABLE #MyResults;


/* Query not using a temporary table (multiple result grids) */
EXEC sp_MSforeachdb N'
USE [?];
SELECT 
    DB_NAME() AS DatabaseName, 
    s.name AS SchemaName, 
    t.name AS TableName,
    c.name as ColumnName
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE c.name = ''cpny_name'';
';  -- Replace column name above
