DECLARE @SchemaName SYSNAME = 'cdc';
DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL += '
SELECT ''' + name + ''' AS DatabaseName, name AS SchemaName 
FROM [' + name + '].sys.schemas 
WHERE name = ''' + @SchemaName + '''
UNION ALL
'
FROM sys.databases
WHERE state_desc = 'ONLINE'
  AND name NOT IN ('master', 'tempdb', 'model', 'msdb', 'DBA', 'DMR', 'AGconfig');
-- Remove trailing UNION ALL
SET @SQL = LEFT(@SQL, LEN(@SQL) - 11);
--PRINT @SQL

EXEC sp_executesql @SQL;