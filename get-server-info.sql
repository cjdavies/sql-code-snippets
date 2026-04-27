SELECT
    SERVERPROPERTY('ServerName') AS [Server Name],
    SERVERPROPERTY('ProductVersion') AS [SQL Build Number],
    SERVERPROPERTY('Edition') AS [SQL Edition],
    (SELECT total_physical_memory_kb / 1024 FROM sys.dm_os_sys_memory) AS [Total Server Memory (MB)],
    (SELECT cpu_count FROM sys.dm_os_sys_info) AS [Total Visible Processors],
    MAX(CASE WHEN name = 'min server memory (MB)' THEN value_in_use END) AS [Min Server Memory (MB)],
    MAX(CASE WHEN name = 'max server memory (MB)' THEN value_in_use END) AS [Max Server Memory (MB)],
    MAX(CASE WHEN name = 'optimize for ad hoc workloads' THEN value_in_use END) AS [Optimize for Ad Hoc Workloads],
    MAX(CASE WHEN name LIKE '%backup compression%' THEN value_in_use END) AS [Backup Compression Default],
    MAX(CASE WHEN name = 'remote admin connections' THEN value_in_use END) AS [Remote Admin Connections]
FROM sys.configurations
WHERE name IN (
    'min server memory (MB)',
    'max server memory (MB)',
    'optimize for ad hoc workloads',
    'remote admin connections'
) OR name LIKE '%backup compression%';