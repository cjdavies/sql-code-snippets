/* Find a table by name in all databases in an instance */
EXEC sys.sp_MSforeachdb 
'IF EXISTS (SELECT 1 FROM [?].sys.tables WHERE name LIKE ''d[__]%'' )
BEGIN
    SELECT ''?'' AS DatabaseName, s.name AS SchemaName, t.name AS TableName 
    FROM [?].sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    WHERE t.name LIKE ''d[__]%''
    ORDER BY DatabaseName, SchemaName, TableName
END'; -- Above example looks for tables beginning with d_ (double underscore required) */

/* Alternative */
IF OBJECT_ID('tempdb..#MyResults') IS NOT NULL DROP TABLE #MyResults;
CREATE TABLE #MyResults (DatabaseName SYSNAME, SchemaName SYSNAME, TableName SYSNAME);

EXEC sp_MSforeachdb N'
USE [?];
INSERT INTO #MyResults
SELECT
    DB_NAME(),
    s.name AS SchemaName,
    t.name AS TableName
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.name LIKE ''d[__]%''; 
';

SELECT * FROM #MyResults ORDER BY DatabaseName, SchemaName, TableName;

DROP TABLE #MyResults;