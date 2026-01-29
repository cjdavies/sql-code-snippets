USE [YourDatabaseName]; -- Replace with your database name
GO

SELECT 
    OBJECT_NAME(i.object_id) AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    s.user_seeks AS UserSeeks,
    s.user_scans AS UserScans,
    s.user_lookups AS UserLookups,
    s.user_updates AS UserUpdates,
    i.is_disabled AS IsDisabled
FROM 
    sys.indexes AS i
LEFT JOIN 
    sys.dm_db_index_usage_stats AS s
ON 
    i.object_id = s.object_id 
    AND i.index_id = s.index_id 
    AND s.database_id = DB_ID()
WHERE 
    i.is_hypothetical = 0 -- Exclude hypothetical indexes
    AND i.is_primary_key = 0 -- Exclude primary key constraints
    AND i.is_unique = 0 -- Exclude unique indexes
    AND s.index_id IS NULL -- Unused since the last restart
ORDER BY 
    TableName, IndexName;
GO

/*
Explanation:
sys.indexes: Contains information about all indexes in the database.
sys.dm_db_index_usage_stats: Tracks index usage statistics (seeks, scans, lookups, and updates).
LEFT JOIN: Ensures indexes with no usage data are included (likely unused).
Filters:
Exclude hypothetical indexes (i.is_hypothetical = 0).
Exclude primary keys (i.is_primary_key = 0).
Exclude unique indexes (i.is_unique = 0).
Show indexes with no recorded usage (s.index_id IS NULL).
*/