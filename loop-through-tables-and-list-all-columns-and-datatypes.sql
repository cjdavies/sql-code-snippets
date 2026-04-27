-- loops through tables and lists all columns and datatypes

SELECT
	DB_NAME() AS [Database],
	tbl.[name] AS [TABLE NAME],
	d.name AS 'Schema_Name',
    c.name 'Column Name',
    t.Name 'Data type',
    c.max_length 'Max Length',
    c.precision ,
    c.scale ,
    c.is_nullable,
    ISNULL(i.is_primary_key, 0) 'Primary Key'
FROM    
    sys.columns c
JOIN 
    sys.types t ON c.user_type_id = t.user_type_id
JOIN 
	sys.tables tbl ON c.[object_id] = tbl.[object_id]
JOIN 
	sys.[schemas] d  ON d.[schema_id] = tbl.[schema_id]
LEFT OUTER JOIN 
    sys.index_columns ic ON ic.object_id = c.object_id AND ic.column_id = c.column_id
LEFT OUTER JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
--WHERE t.Name = 'datetimeoffset'
ORDER BY  [Column Name],[Data type], [c].[max_length]