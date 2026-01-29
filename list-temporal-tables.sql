SELECT s.[name] AS schema_name,
       t.[name] AS table_name
  FROM sys.tables t
 INNER JOIN sys.schemas s ON s.schema_id = t.schema_id
 WHERE t.temporal_type = 2
 ORDER BY schema_name,
          table_name;