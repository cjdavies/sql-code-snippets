/* GitHub Copilot version */
DECLARE @SearchText NVARCHAR(MAX) = '%h_ded%';
SELECT
    qt.query_sql_text,
    CASE rs.execution_type 
        WHEN 0 THEN 'Regular' 
        WHEN 1 THEN 'Aborted' 
        WHEN 2 THEN 'Exception' 
        WHEN 3 THEN 'Debug' 
    END AS execution_type_desc,
    rs.count_executions,
    rs.avg_duration,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads,
    rs.avg_logical_io_writes,
    rs.avg_query_max_used_memory,
    rs.last_execution_time,
    qp.plan_id,
    qp.query_plan
FROM sys.query_store_query_text qt
JOIN sys.query_store_query qq
    ON qt.query_text_id = qq.query_text_id
JOIN sys.query_store_plan qp
    ON qq.query_id = qp.query_id
JOIN sys.query_store_runtime_stats rs
    ON qp.plan_id = rs.plan_id
JOIN sys.query_store_runtime_stats_interval rsi
    ON rs.runtime_stats_interval_id = rsi.runtime_stats_interval_id
WHERE qt.query_sql_text LIKE @SearchText
ORDER BY rs.last_execution_time DESC;

/* M365 Copilot version */
DECLARE @SearchText NVARCHAR(MAX) = '%h_ded%';
SELECT
    qt.query_sql_text,
    qp.plan_id,
    rs.count_executions,
    rs.avg_duration,
    rs.avg_cpu_time,
    rs.avg_logical_io_reads,
    rs.avg_logical_io_writes,
    rs.last_execution_time,
    qp.query_plan
FROM sys.query_store_query_text qt
JOIN sys.query_store_query q
    ON qt.query_text_id = q.query_text_id
JOIN sys.query_store_plan qp
    ON q.query_id = qp.query_id
JOIN sys.query_store_runtime_stats rs
    ON qp.plan_id = rs.plan_id
WHERE qt.query_sql_text LIKE @SearchText
ORDER BY rs.last_execution_time DESC;
