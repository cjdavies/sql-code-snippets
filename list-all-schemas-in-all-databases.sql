/* List all schemas in all databases */
DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL += '
SELECT ''' + name + ''' AS DatabaseName, name AS SchemaName 
FROM [' + name + '].sys.schemas 
WHERE schema_id > 5 AND schema_id < 16384
UNION ALL
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
  AND name NOT IN ('master', 'tempdb', 'model', 'msdb', 'DBA', 'DMR', 'AGconfig');
-- Remove trailing UNION ALL
SET @SQL = LEFT(@SQL, LEN(@SQL) - 11);
--PRINT @SQL

EXEC sp_executesql @SQL;


/*
DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += '
USE [' + name + '];
SELECT 
    DB_NAME() AS database_name,
    s.name AS schema_name
FROM 
    sys.schemas s
WHERE 
    s.name NOT IN (''sys'', ''guest'', ''INFORMATION_SCHEMA'')
    AND s.principal_id > 4 and s.principal_id < 16384
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
  AND name NOT IN ('master', 'tempdb', 'model', 'msdb', 'DBA', 'DMR', 'AGconfig');
  
EXEC sp_executesql @sql;
*/