SELECT
    DB_NAME()    AS DatabaseName,
    d.[name]     AS SchemaName,
    tbl.[name]   AS TableName,
    c.[name]     AS ColumnName,
    t.[name]     AS DataType,
    c.max_length AS ColumnLength
FROM sys.columns c
    JOIN sys.types t     ON c.user_type_id = t.user_type_id
    JOIN sys.tables tbl  ON c.[object_id]  = tbl.[object_id]
    JOIN sys.[schemas] d ON d.[schema_id]  = tbl.[schema_id]
WHERE tbl.is_ms_shipped = 0
ORDER BY SchemaName, TableName, ColumnName;