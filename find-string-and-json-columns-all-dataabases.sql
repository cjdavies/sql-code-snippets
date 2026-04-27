/* Find string columns in all user databases */
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
USE ' + QUOTENAME(name) + ';
SELECT 
    DB_NAME() AS DatabaseName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    c.max_length
FROM sys.tables AS t
JOIN sys.columns AS c ON t.object_id = c.object_id
JOIN sys.types AS ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0
  AND ty.name IN (''nvarchar'', ''varchar'', ''nchar'', ''char'', ''text'', ''ntext'')
ORDER BY t.name, c.name;
'
FROM sys.databases
WHERE database_id > 4  -- exclude system DBs
  AND state_desc = 'ONLINE';

EXEC sp_executesql @sql;

/* Find JSON columns in all user databases */
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
USE ' + QUOTENAME(name) + ';
DECLARE @innerSql NVARCHAR(MAX) = N'''';

SELECT @innerSql += 
    ''SELECT DB_NAME() AS DatabaseName, ''''' + t.name + ''''' AS TableName, ''''' + c.name + ''''' AS ColumnName, COUNT(*) AS JsonRows
      FROM ' + QUOTENAME(t.name) + '
      WHERE ISJSON(' + QUOTENAME(c.name) + ') = 1
      HAVING COUNT(*) > 0
      UNION ALL
    ''
FROM sys.tables AS t
JOIN sys.columns AS c ON t.object_id = c.object_id
JOIN sys.types AS ty ON c.user_type_id = ty.user_type_id
WHERE t.is_ms_shipped = 0
  AND ty.name IN (''nvarchar'', ''varchar'', ''nchar'', ''char'', ''text'', ''ntext'');

-- Remove last UNION ALL if exists
IF LEN(@innerSql) > 10
    SET @innerSql = LEFT(@innerSql, LEN(@innerSql) - 10);

IF LEN(@innerSql) > 0
    EXEC sp_executesql @innerSql;
'
FROM sys.databases
WHERE database_id > 4  -- exclude system DBs
  AND state_desc = 'ONLINE';

EXEC sp_executesql @sql;
