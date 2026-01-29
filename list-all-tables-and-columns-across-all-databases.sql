EXEC sys.sp_MSforeachdb  
'IF ''?'' NOT IN (''master'', ''model'', ''msdb'', ''tempdb'') 
BEGIN     
    SELECT 
        ''?'' AS DatabaseName, 
        s.name AS SchemaName, 
        t.name AS TableName, 
        c.name AS ColumnName
    FROM [?].sys.tables t
    JOIN [?].sys.schemas s ON t.schema_id = s.schema_id
    JOIN [?].sys.columns c ON t.object_id = c.object_id
    ORDER BY DatabaseName, SchemaName, TableName, ColumnName
END';

/* Limit search to specific table name. */
EXEC sys.sp_MSforeachdb  
'IF ''?'' NOT IN (''master'', ''model'', ''msdb'', ''tempdb'') 
    AND EXISTS (SELECT 1 FROM [?].sys.tables WHERE name LIKE ''security%'') 
BEGIN     
    SELECT 
        ''?'' AS DatabaseName, 
        s.name AS SchemaName, 
        t.name AS TableName, 
        c.name AS ColumnName
    FROM [?].sys.tables t
    JOIN [?].sys.schemas s ON t.schema_id = s.schema_id
    JOIN [?].sys.columns c ON t.object_id = c.object_id
    WHERE t.name LIKE ''security%''
    ORDER BY DatabaseName, SchemaName, TableName, ColumnName
END';