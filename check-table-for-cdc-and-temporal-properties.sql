/* Check table for CDC and temporal properties. */

SELECT
    DB_NAME()            AS DatabaseName,
    s.[name]             AS SchemaName,
    t.[name]             AS TableName,
    t.temporal_type      AS TemporalType,
    t.temporal_type_desc AS TemporalTypeDesc
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE (t.is_tracked_by_cdc = 1 OR t.temporal_type = 2)
AND t.[name] LIKE 'client%'
ORDER BY DatabaseName, SchemaName, TableName;
