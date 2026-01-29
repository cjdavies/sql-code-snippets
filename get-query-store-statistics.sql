-- Base query from        https://learn.microsoft.com/en-us/sql/relational-databases/performance/monitoring-performance-by-using-the-query-store?view=sql-server-ver16
--using tables
--sys.query_store_plan    https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-plan-transact-sql?view=sql-server-ver16
--sys.query_store_query   https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-query-transact-sql?view=sql-server-ver16
--sys.query_store_runtime_stats  https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-runtime-stats-transact-sql?view=sql-server-ver16
--sys.query_store_query_text https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-query-store-query-text-transact-sql?view=sql-server-ver16

--Query Store Base Query mentioned above
USE [User_db]
GO
SELECT Txt.query_text_id, Txt.query_sql_text, Pln.plan_id, Qry.*, RtSt.*
FROM sys.query_store_plan AS Pln
INNER JOIN sys.query_store_query AS Qry
    ON Pln.query_id = Qry.query_id
INNER JOIN sys.query_store_query_text AS Txt
    ON Qry.query_text_id = Txt.query_text_id
INNER JOIN sys.query_store_runtime_stats RtSt
ON Pln.plan_id = RtSt.plan_id;
GO

--**********************************
--Query below is the base query modified to show those with 
-- Highest Reads (> 500000) sorted by highest 'avg_logical_io_reads"

  DROP TABLE IF EXISTS ##QSR;
  GO
  WITH CTE AS (
  SELECT DISTINCT
      [Pln].[query_id],
      [Txt].[query_text_id],
      [Txt].[query_sql_text],
      OBJECT_NAME([Qry].[object_id]) AS [Query_Object],
      [Qry].[count_compiles],
      ROUND([Qry].[avg_compile_duration]/1000, 0) AS [avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
      ROUND(([Qry].[count_compiles] * [Qry].[avg_compile_duration]/1000), 0) AS [Compile_X_Duration_Weight(ms)], -- the /1000 puts it in milliseconds
      [RtSt].[execution_type_desc],
      ROUND([RtSt].[avg_logical_io_reads], 0) AS [avg_logical_io_reads]
      --ROUND([RtSt].[avg_logical_io_writes], 0) AS [avg_logical_io_writes]
  FROM [sys].[query_store_plan] AS [Pln]
   INNER JOIN [sys].[query_store_query] AS [Qry]
    ON [Pln].[query_id] = [Qry].[query_id]
   INNER JOIN [sys].[query_store_query_text] AS [Txt]
    ON [Qry].[query_text_id] = [Txt].[query_text_id]
   INNER JOIN [sys].[query_store_runtime_stats] [RtSt]
    ON [Pln].[plan_id] = [RtSt].[plan_id]
  WHERE 
   [RtSt].[avg_logical_io_reads] > 500000
   AND OBJECT_NAME([Qry].[object_id]) IS NOT NULL
  --ORDER BY ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) DESC
  )
  SELECT DISTINCT
   CTE.[query_id],
   --CTE.[query_text_id],
   --CTE.[query_sql_text],
   --CTE.[Query_Object],
   --CTE.[count_compiles],
   --CTE.[avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
   CTE.[Compile_X_Duration_Weight(ms)] -- the /1000 puts it in milliseconds
   --CTE.[execution_type_desc]
  INTO ##QSR
  FROM CTE 
  ORDER BY [CTE].[query_id]
  --ORDER BY CTE.[Compile_X_Duration_Weight(ms)] DESC

  SELECT DISTINCT
      [Pln].[query_id],
      [Txt].[query_text_id],
      [Txt].[query_sql_text],
      OBJECT_NAME([Qry].[object_id]) AS [Query_Object],
      [Qry].[count_compiles],
      ROUND([Qry].[avg_compile_duration]/1000, 0) AS [avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
      ROUND(([Qry].[avg_compile_duration]/1000)*[Qry].[count_compiles], 0) AS [Compile_X_Duration_Weight(ms)], -- the /1000 puts it in milliseconds
      [RtSt].[execution_type_desc],
      SUM(ROUND([RtSt].[avg_logical_io_reads], 0)) AS [SUM_of_avg_logical_io_reads]
     -- ROUND([RtSt].[avg_logical_io_writes], 0) AS [avg_logical_io_writes]
  FROM [sys].[query_store_plan] AS [Pln]
   INNER JOIN [sys].[query_store_query] AS [Qry]
    ON [Pln].[query_id] = [Qry].[query_id]
   INNER JOIN [sys].[query_store_query_text] AS [Txt]
    ON [Qry].[query_text_id] = [Txt].[query_text_id]
   INNER JOIN [sys].[query_store_runtime_stats] [RtSt]
    ON [Pln].[plan_id] = [RtSt].[plan_id]
  WHERE Pln.query_id IN (SELECT [query_id] FROM ##QSR)
  GROUP BY 
    [Pln].[query_id],
    [Txt].[query_text_id],
    [Txt].[query_sql_text],
    OBJECT_NAME([Qry].[object_id]),
    [Qry].[count_compiles],
    [Qry].[avg_compile_duration],
    ROUND(([Qry].[avg_compile_duration]/1000)*[Qry].[count_compiles], 0), -- the /1000 puts it in milliseconds
    [RtSt].[execution_type_desc]
    --ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) --AS [Compile_X_Duration_Weight(ms)], -- the /1000 puts it in milliseconds
  ORDER BY SUM(ROUND([RtSt].[avg_logical_io_reads], 0)) DESC
  --ORDER BY [Compile_X_Duration_Weight(ms)] DESC
  ----ORDER BY [Pln].[query_id]

  DROP TABLE IF EXISTS ##QSR

--******************************************
--Query below is the base query modified to show those with 
-- Highest Reads (> 500000) sorted by highest 'Compile to Duration' Weight

  DROP TABLE IF EXISTS ##QSR;
  GO
  WITH CTE AS (
  SELECT DISTINCT
      [Pln].[query_id],
      [Txt].[query_text_id],
      [Txt].[query_sql_text],
      OBJECT_NAME([Qry].[object_id]) AS [Query_Object],
      [Qry].[count_compiles],
      ROUND([Qry].[avg_compile_duration]/1000, 0) AS [avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
      ROUND(([Qry].[count_compiles] * [Qry].[avg_compile_duration]/1000), 0) AS [Compile_X_Duration_Weight(ms)], -- the /1000 puts it in milliseconds
      [RtSt].[execution_type_desc],
      ROUND([RtSt].[avg_logical_io_reads], 0) AS [avg_logical_io_reads]
      --ROUND([RtSt].[avg_logical_io_writes], 0) AS [avg_logical_io_writes]
  FROM [sys].[query_store_plan] AS [Pln]
   INNER JOIN [sys].[query_store_query] AS [Qry]
    ON [Pln].[query_id] = [Qry].[query_id]
   INNER JOIN [sys].[query_store_query_text] AS [Txt]
    ON [Qry].[query_text_id] = [Txt].[query_text_id]
   INNER JOIN [sys].[query_store_runtime_stats] [RtSt]
    ON [Pln].[plan_id] = [RtSt].[plan_id]
  WHERE 
   [RtSt].[avg_logical_io_reads] > 500000
   AND OBJECT_NAME([Qry].[object_id]) IS NOT NULL
  --ORDER BY ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) DESC
  )
  SELECT DISTINCT
   CTE.[query_id],
   --CTE.[query_text_id],
   --CTE.[query_sql_text],
   --CTE.[Query_Object],
   --CTE.[count_compiles],
   --CTE.[avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
   CTE.[Compile_X_Duration_Weight(ms)] -- the /1000 puts it in milliseconds
   --CTE.[execution_type_desc]
  INTO ##QSR
  FROM CTE 
  ORDER BY [CTE].[query_id]
  --ORDER BY CTE.[Compile_X_Duration_Weight(ms)] DESC

  SELECT DISTINCT
      [Pln].[query_id],
      [Txt].[query_text_id],
      [Txt].[query_sql_text],
      OBJECT_NAME([Qry].[object_id]) AS [Query_Object],
      [Qry].[count_compiles],
      ROUND([Qry].[avg_compile_duration]/1000, 0) AS [avg_compile_duration(ms)], -- the /1000 puts it in milliseconds
      ROUND(([Qry].[avg_compile_duration]/1000)*[Qry].[count_compiles], 0) AS [Compile_x_Duration=Weight(ms)], -- the /1000 puts it in milliseconds
      [RtSt].[execution_type_desc],
      SUM(ROUND([RtSt].[avg_logical_io_reads], 0)) AS [SUM_of_avg_logical_io_reads]
     -- ROUND([RtSt].[avg_logical_io_writes], 0) AS [avg_logical_io_writes]
  FROM [sys].[query_store_plan] AS [Pln]
   INNER JOIN [sys].[query_store_query] AS [Qry]
    ON [Pln].[query_id] = [Qry].[query_id]
   INNER JOIN [sys].[query_store_query_text] AS [Txt]
    ON [Qry].[query_text_id] = [Txt].[query_text_id]
   INNER JOIN [sys].[query_store_runtime_stats] [RtSt]
    ON [Pln].[plan_id] = [RtSt].[plan_id]
  WHERE Pln.query_id IN (SELECT [query_id] FROM ##QSR)
  GROUP BY 
    [Pln].[query_id],
    [Txt].[query_text_id],
    [Txt].[query_sql_text],
    OBJECT_NAME([Qry].[object_id]),
    [Qry].[count_compiles],
    [Qry].[avg_compile_duration],
    ROUND(([Qry].[avg_compile_duration]/1000)*[Qry].[count_compiles], 0), -- the /1000 puts it in milliseconds
    [RtSt].[execution_type_desc]
    --ROUND([Qry].[count_compiles] * ROUND([Qry].[avg_compile_duration], 0)/1000, 0) --AS [Compile_x_Duration=Weight(ms)], -- the /1000 puts it in milliseconds
  --ORDER BY SUM(ROUND([RtSt].[avg_logical_io_reads], 0)) DESC
  ORDER BY [Compile_x_Duration=Weight(ms)]DESC
  ----ORDER BY [Pln].[query_id]


  DROP TABLE IF EXISTS ##QSR

 