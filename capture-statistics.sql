ALTER DATABASE [QAAuto_Bdm]
  SET QUERY_STORE = ON
    (
       OPERATION_MODE = READ_WRITE,
       DATA_FLUSH_INTERVAL_SECONDS = 600,
       MAX_STORAGE_SIZE_MB = 2048,
       INTERVAL_LENGTH_MINUTES = 15,
       SIZE_BASED_CLEANUP_MODE = AUTO,
       https://blog.sqlauthority.com/2017/10/20/sql-server-turn-optimize-ad-hoc-workloads/= ALL,
       MAX_PLANS_PER_QUERY = 500,
       WAIT_STATS_CAPTURE_MODE = ON
    );
GO


ALTER DATABASE [QAAuto_Bdm_Mod]
  SET QUERY_STORE = ON
    (
       OPERATION_MODE = READ_WRITE,
       DATA_FLUSH_INTERVAL_SECONDS = 600,
       MAX_STORAGE_SIZE_MB = 2048,
       INTERVAL_LENGTH_MINUTES = 15,
       SIZE_BASED_CLEANUP_MODE = AUTO,
       QUERY_CAPTURE_MODE = ALL,
       MAX_PLANS_PER_QUERY = 500,
       WAIT_STATS_CAPTURE_MODE = ON
    );
GO

ALTER DATABASE [QAAuto_Bdm] SET QUERY_STORE CLEAR ALL;
GO
ALTER DATABASE [QAAuto_Bdm_Mod] SET QUERY_STORE CLEAR ALL;
GO


/* To capture total statistics for a query in SQL Server, you can use SET STATISTICS commands or Query Store. Here are the most common approaches: */

-- 1. Using SET STATISTICS Commands

SQL Server provides commands to capture detailed statistics for query execution:

SET STATISTICS TIME ON: Captures the time taken for query execution (CPU time and elapsed time).
SET STATISTICS IO ON: Captures I/O statistics, such as logical reads, physical reads, and writes.

-- Example:

SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- Your query
SELECT * FROM YourTable WHERE Column = 'Value';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;


/* The results will appear in the Messages tab in SQL Server Management Studio (SSMS). */

-- 2. Using Execution Plans

/* Execution plans provide detailed insights into query performance, including estimated and actual statistics:

Estimated Execution Plan: Shows the estimated cost and statistics before running the query.
Actual Execution Plan: Captures the actual runtime statistics after query execution.

Steps:

In SSMS, click Query > Include Actual Execution Plan (or press Ctrl + M).
Run your query. Review the execution plan in the Execution Plan tab. */

-- 3. Using Query Store

/* Query Store tracks query performance over time, including execution statistics like CPU usage, I/O, and duration.

Steps:

Enable Query Store (if not already enabled): */

ALTER DATABASE YourDatabase SET QUERY_STORE = ON;

-- Query the Query Store views for statistics:

SELECT
    qs.query_id,
    qs.execution_type_desc,
    rs.avg_duration,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads
FROM sys.query_store_query qs
JOIN sys.query_store_runtime_stats rs
    ON qs.query_id = rs.query_id
WHERE qs.query_text_id = (
    SELECT query_text_id
    FROM sys.query_store_query_text
    WHERE query_sql_text LIKE '%YourQuery%'
);
