SELECT db_name() AS DatabaseName,
      SCHEMA_NAME(o.schema_id) AS SchemaName,
      o.name AS ObjectName,
      o.create_date AS CreateDate,
      o.modify_date AS ModifyDate,
      ps.last_execution_time AS LastExecutionTime
 FROM sys.dm_exec_procedure_stats ps
INNER JOIN sys.objects o
   ON ps.object_id = o.object_id
WHERE o.type = 'P'
  AND o.is_ms_shipped = 0
  AND ps.last_execution_time IS NOT NULL
  AND o.name LIKE 'dt%'
ORDER BY o.name ASC,
         ps.last_execution_time DESC;