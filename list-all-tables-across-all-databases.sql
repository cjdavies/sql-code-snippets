/* Excludes system databases. */
EXEC sys.sp_MSforeachdb  
'IF ''?'' NOT IN (''master'', ''model'', ''msdb'', ''tempdb'') 
BEGIN     
    SELECT 
        ''?'' AS DatabaseName, 
        s.name AS SchemaName, 
        t.name AS TableName
    FROM [?].sys.tables t
    JOIN [?].sys.schemas s ON t.schema_id = s.schema_id
    ORDER BY DatabaseName, SchemaName, TableName
END';