-- Find which Dbs on a SQL Instance have Query Store turned on
CREATE TABLE ##Columnstore_DBs (
		DB_NAME SYSNAME,
		desired_state_desc  NVARCHAR(50),
        actual_state_desc   NVARCHAR(50),
        readonly_reason   NVARCHAR(50), 
        current_storage_size_mb  INT, 
        MAX_STORAGE_SIZE_MB INT ,
        max_plans_per_query INT);

DECLARE @tsql NVARCHAR(400)
SET @tsql =
N'USE [?];
INSERT INTO ##Columnstore_DBs 
SELECT  DB_Name() as [DB_Name],
		desired_state_desc ,
        actual_state_desc ,
        readonly_reason, 
        current_storage_size_mb , 
        max_storage_size_mb ,
        max_plans_per_query 
FROM    sys.database_query_store_options ;'

EXEC sp_MSforeachdb @tsql

SELECT * FROM ##Columnstore_DBs WHERE desired_state_desc <> 'OFF'

-- Base query from        https://learn.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver16
--sys.query_store_plan    https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-plan-transact-sql?view=sql-server-ver16
--sys.query_store_query   https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-query-transact-sql?view=sql-server-ver16
--sys.query_store_runtime_stats  https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-runtime-stats-transact-sql?view=sql-server-ver16
--ys.query_store_query_text https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-query-text-transact-sql?view=sql-server-ver16


USE [my_db]
GO
SELECT Txt.query_text_id, Txt.query_sql_text, Pln.plan_id, Qry.*, RtSt.*
FROM sys.query_store_plan AS Pln
INNER JOIN sys.query_store_query AS Qry
    ON Pln.query_id = Qry.query_id
INNER JOIN sys.query_store_query_text AS Txt
    ON Qry.query_text_id = Txt.query_text_id
INNER JOIN sys.query_store_runtime_stats RtSt
ON Pln.plan_id = RtSt.plan_id;

USE [my_db]
GO
SELECT DISTINCT
       [Pln].[query_id],
      --Qry].[query_id],
       [Txt].[query_text_id],
      --Txt].[query_text_id],
      --Pln].[plan_id],
      --RtSt].[plan_id],
      [Txt].[query_sql_text],
       OBJECT_NAME([Qry].[object_id]) AS [Query_Object],
       [Qry].[count_compiles],
       ROUND(ROUND([Qry].[avg_compile_duration], 0)/1000, 0) AS [avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
	   ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) AS [~Compile_X_Duration_Weight(ms)], -- the /1000 puts it in milliseconds
       [RtSt].[execution_type_desc]
       --ROUND([RtSt].[avg_logical_io_reads], 0) AS [avg_logical_io_reads],
       --ROUND([RtSt].[avg_logical_io_writes], 0) AS [avg_logical_io_writes]
FROM [sys].[query_store_plan] AS [Pln]
    INNER JOIN [sys].[query_store_query] AS [Qry]
        ON [Pln].[query_id] = [Qry].[query_id]
    INNER JOIN [sys].[query_store_query_text] AS [Txt]
        ON [Qry].[query_text_id] = [Txt].[query_text_id]
    INNER JOIN [sys].[query_store_runtime_stats] [RtSt]
        ON [Pln].[plan_id] = [RtSt].[plan_id]
WHERE OBJECT_NAME([Qry].[object_id]) IS NOT NULL
AND rtst.[execution_type_desc] = 'Regular'
ORDER BY ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) desc
--ORDER BY OBJECT_NAME([Qry].[object_id])
--ORDER BY [Compile_X_Duration_Weight] desc