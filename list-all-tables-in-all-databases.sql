/* List all tables in all databases */

DECLARE @command varchar(1000);
SELECT @command = '
USE ?
SELECT DB_NAME() AS db_name, s.name as schema_name, t.name as table_name
FROM sys.schemas s
JOIN sys.tables t ON t.schema_id = s.schema_id
WHERE DB_ID() > 4
ORDER BY db_name, schema_name, table_name
';
EXEC sp_MSforeachdb @command;
