SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET DEADLOCK_PRIORITY LOW;
GO
SELECT
    s.name      AS schema_name,
    t.name      AS table_name,
    SUM(p.rows) AS row_count
FROM sys.tables AS t
    JOIN sys.schemas AS s
      ON t.schema_id = s.schema_id
    JOIN sys.partitions AS p
      ON t.object_id = p.object_id
WHERE p.index_id IN (0, 1)  -- heap or clustered index
    AND t.is_ms_shipped = 0 -- exclude system tables
    AND s.name <> 'cdc'     -- exclude CDC tables (optional)
GROUP BY
    s.name,
    t.name
ORDER BY
    s.name,
    t.name;

/*
  sys.tables      – lists user tables
  sys.schemas     – gets the schema name
  sys.partitions  – provides row counts
  index_id IN (0,1) ensures:
    0 = heap
    1 = clustered index (avoids double-counting rows from nonclustered indexes)
  
  This is fast and accurate enough for admin/reporting purposes.  
  Works without scanning table data.
  Metadata row counts are updated during normal operations, but:
  They can be briefly inaccurate during heavy concurrent activity.
  For CDC tables, temporal tables, or system-versioned tables, this query still works correctly.
*/