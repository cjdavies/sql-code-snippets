EXEC sys.sp_MSforeachdb 
'USE [?];
SELECT DB_NAME() as DBNAME, actual_state_desc
FROM sys.database_query_store_options;';