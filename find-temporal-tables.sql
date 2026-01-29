/* Find temporal tables
 
 Temporal_type column:
 0 = NON_TEMPORAL_TABLE
 1 = HISTORY_TABLE (associated with a temporal table)
 2 = SYSTEM_VERSIONED_TEMPORAL_TABLE
 */

SELECT
    s.name               AS SchemaName,
    t.name               AS TableName,
    t.temporal_type      AS TemporalType,
    t.temporal_type_desc AS TemporalTypeDesc
FROM
    sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE
    t.temporal_type = 2 /* AND t.name = 'YourTableName' */
ORDER BY
    SchemaName,
    TableName;


/* Find temporal tables across all databases */
IF OBJECT_ID('tempdb..#MyResults') IS NOT NULL DROP TABLE #MyResults;
CREATE TABLE #MyResults (DatabaseName SYSNAME, SchemaName SYSNAME, TableName SYSNAME, TemporalType SYSNAME, TemporalTypeDesc SYSNAME);

EXEC sp_MSforeachdb N'
USE [?];
INSERT INTO #MyResults
SELECT
    DB_NAME(),
    s.name AS SchemaName,
    t.name AS TableName,
    t.temporal_type      AS TemporalType,
    t.temporal_type_desc AS TemporalTypeDesc
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.temporal_type = 2; 
';

SELECT * FROM #MyResults ORDER BY DatabaseName, SchemaName, TableName;

DROP TABLE #MyResults;