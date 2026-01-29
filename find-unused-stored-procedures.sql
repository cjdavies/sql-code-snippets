USE [YourDatabaseName]; -- Replace with your database name
GO

SELECT 
    p.name AS ProcedureName,
    s.execution_count AS ExecutionCount,
    s.last_execution_time AS LastExecutionTime,
    SCHEMA_NAME(p.schema_id) AS SchemaName,
    p.create_date AS CreationDate,
    p.modify_date AS LastModifiedDate
FROM 
    sys.procedures AS p
LEFT JOIN 
    sys.dm_exec_procedure_stats AS s
ON 
    p.object_id = s.object_id
WHERE 
    s.object_id IS NULL -- No execution statistics available
ORDER BY 
    SchemaName, ProcedureName;
GO

/*
Here’s the explanation of the script again:

sys.procedures: Contains metadata for all stored procedures in the database.
sys.dm_exec_procedure_stats: Tracks execution statistics, including execution count and last execution time, for stored procedures that have been executed since the last SQL Server restart or statistics reset.
LEFT JOIN: Ensures procedures without execution statistics (likely unused) are included in the results.
Filter:
s.object_id IS NULL: Filters for stored procedures with no execution statistics available, indicating they have not been executed since the last server restart.
The script also includes additional details like creation date, last modification date, and schema for better insights. Note that procedures created or modified recently might also appear as unused if they haven't been executed yet.
*/