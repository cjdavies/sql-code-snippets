SELECT s.name                   AS SchemaName,
       t.name                   AS TableName,
       st.stats_id              AS StatisticID,
       st.name                  AS StatisticName,
       p.rows                   AS NumberOfRowsInTable,
       sp.rows_sampled          AS NumberOfRowsSampled,
       sp.last_updated          AS LastUpdated,
       sp.modification_counter  AS ModificationsSinceLastUpdate,
       CASE
           WHEN sp.last_updated IS NULL THEN
               'Never Updated'
           --WHEN DATEDIFF(day, sp.last_updated, GETDATE()) = 0 THEN 'Updated Today'
           --WHEN DATEDIFF(day, sp.last_updated, GETDATE()) = 1 THEN 'Updated Yesterday'
           ELSE
               CAST(DATEDIFF(DAY, sp.last_updated, GETDATE()) AS VARCHAR(10)) + ' days ago'
       END AS UpdatedDescription,
       CASE
           WHEN st.auto_created = 1 THEN
               'Auto-Created'
           WHEN st.user_created = 1 THEN
               'User-Created'
           ELSE
               'System'
       END AS StatisticType,
       CASE
           WHEN st.no_recompute = 1 THEN
               'Disabled'
           ELSE
               'Enabled'
       END AS AutoUpdateStatus
FROM sys.tables t
    INNER JOIN sys.schemas s
        ON t.schema_id = s.schema_id
    INNER JOIN sys.stats st
        ON t.object_id = st.object_id
    CROSS APPLY sys.dm_db_stats_properties(st.object_id, st.stats_id) sp
    LEFT JOIN sys.partitions p
        ON t.object_id = p.object_id
           AND p.index_id IN (0, 1)  -- 0=heap table, 1=clustered
WHERE t.type = 'U'      -- User tables only
      AND p.rows = 0    -- To find empty tables
ORDER BY s.name,
         t.name,
         st.stats_id;

/* Additional Summary Query: Statistics Health Overview
SELECT 
    'Statistics Summary' AS ReportSection,
    COUNT(*) AS TotalStatistics,
    COUNT(CASE WHEN sp.last_updated IS NULL THEN 1 END) AS NeverUpdated,
    COUNT(CASE WHEN DATEDIFF(day, sp.last_updated, GETDATE()) > 30 THEN 1 END) AS UpdatedOver30DaysAgo,
    COUNT(CASE WHEN DATEDIFF(day, sp.last_updated, GETDATE()) > 7 AND DATEDIFF(day, sp.last_updated, GETDATE()) <= 30 THEN 1 END) AS UpdatedOver7DaysAgo,
    COUNT(CASE WHEN DATEDIFF(day, sp.last_updated, GETDATE()) <= 7 THEN 1 END) AS UpdatedWithinWeek
FROM 
    sys.tables t
    INNER JOIN sys.stats st ON t.object_id = st.object_id
    LEFT JOIN sys.dm_db_stats_properties(st.object_id, st.stats_id) sp ON 1=1
WHERE 
    t.type = 'U';
*/

-- Optional: Detailed Statistics Information with Column Names
-- Uncomment the query below if you want to see which columns each statistic covers
/*
SELECT 
    s.name AS SchemaName,
    t.name AS TableName,
    st.name AS StatisticName,
    c.name AS ColumnName,
    sc.stats_column_id AS ColumnPosition,
    sp.rows_sampled AS NumberOfRowsSampled,
    sp.last_updated AS LastUpdated
FROM 
    sys.tables t
    INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
    INNER JOIN sys.stats st ON t.object_id = st.object_id
    INNER JOIN sys.stats_columns sc ON st.object_id = sc.object_id AND st.stats_id = sc.stats_id
    INNER JOIN sys.columns c ON sc.object_id = c.object_id AND sc.column_id = c.column_id
    LEFT JOIN sys.dm_db_stats_properties(st.object_id, st.stats_id) sp ON 1=1
WHERE 
    t.type = 'U'
ORDER BY 
    s.name, 
    t.name, 
    st.name, 
    sc.stats_column_id;


I'll create a T-SQL script that retrieves statistics information for all tables in a database. This script will query the system catalog views to get the details you requested.This T-SQL script provides comprehensive statistics information for all tables in your database. Here's what it includes:

**Main Query Features:**
- **Schema and Table Names** - Organized by schema for better readability
- **Statistic ID and Name** - Unique identifiers for each statistic
- **Row Counts** - Both total rows in table and rows sampled for statistics
- **Last Updated Date** - When statistics were last refreshed
- **Additional Useful Information:**
  - Days since last update (human-readable format)
  - Modification counter (changes since last stats update)
  - Statistic type (auto-created vs user-created)
  - Auto-update status (enabled/disabled)

**Summary Query:**
The second query provides a health overview showing how many statistics fall into different update age categories, helping you identify statistics that may need attention.

**Optional Detailed Query:**
There's a commented-out third query that shows which specific columns each statistic covers, in case you need that level of detail.

**Key System Views Used:**
- `sys.tables` - Table information
- `sys.stats` - Statistics metadata
- `sys.dm_db_stats_properties()` - Statistics properties and update info
- `sys.partitions` - Row count information

The script filters to user tables only (`t.type = 'U'`) and orders results logically by schema, table, and statistic ID for easy review.
*/
