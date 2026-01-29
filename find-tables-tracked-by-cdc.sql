/* Find tables tracked by CDC */
EXEC sys.sp_MSforeachdb 
'IF EXISTS (SELECT 1 FROM [?].sys.tables WHERE is_tracked_by_cdc = 1)
BEGIN
    SELECT ''?'' AS DatabaseName, s.name AS SchemaName, t.name AS TableName 
      FROM [?].sys.tables t
      JOIN sys.schemas s ON t.schema_id = s.schema_id
     WHERE t.is_tracked_by_cdc = 1
     ORDER BY DatabaseName, SchemaName, TableName
END'; 