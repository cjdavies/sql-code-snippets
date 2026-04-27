/* Excludes system databases. */
EXEC sys.sp_MSforeachdb  
'IF ''?'' NOT IN (
     ''Admin'',
     ''AdventureWorks2012'',
     ''DBA'',
     ''DEID'',
     ''DMR'',
     ''master'',
     ''model'',
     ''msdb'',
     ''plumtree5_esc3'',
     ''smtp'',
     ''Temp_Object_Repository'',
     ''tempdb''
     ) 
BEGIN     
    SELECT 
        ''?'' AS DatabaseName, 
        s.name AS SchemaName, 
        t.name AS TableName
    FROM [?].sys.tables t
    JOIN [?].sys.schemas s ON t.schema_id = s.schema_id
    ORDER BY DatabaseName, SchemaName, TableName
END';