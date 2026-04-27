/* Find columns that hold character strings */
SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length
FROM sys.tables AS t
JOIN sys.columns AS c ON t.object_id = c.object_id
JOIN sys.types AS ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0 -- user tables only
  AND ty.name IN ('nvarchar', 'varchar', 'nchar', 'char', 'text', 'ntext')
ORDER BY t.name, c.name;


/* Check which columns actually contain JSON */
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 
    'SELECT ''' + t.name + ''' AS TableName, ''' + c.name + ''' AS ColumnName, COUNT(*) AS JsonRows
     FROM ' + QUOTENAME(t.name) + '
     WHERE ISJSON(' + QUOTENAME(c.name) + ') = 1
     GROUP BY ''' + t.name + ''', ''' + c.name + '''
     HAVING COUNT(*) > 0
     UNION ALL
    '
FROM sys.tables AS t
JOIN sys.columns AS c ON t.object_id = c.object_id
JOIN sys.types AS ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0
  AND ty.name IN ('nvarchar', 'varchar', 'nchar', 'char', 'text', 'ntext');

-- Remove trailing UNION ALL
IF LEN(@sql) > 10
    SET @sql = LEFT(@sql, LEN(@sql) - 10);

-- Only execute if we have a query
IF LEN(@sql) > 0
    EXEC sp_executesql @sql;
