SELECT
    d.name AS [Database Name],
    d.compatibility_level AS [Compatibility Level],
    d.is_auto_update_stats_on AS [Auto Update Stats],
    d.is_auto_create_stats_on AS [Auto Create Stats],
    d.is_auto_shrink_on AS [Auto Shrink],
    d.page_verify_option_desc AS [Page Verify]
FROM sys.databases d
WHERE d.state_desc = 'ONLINE' AND d.name NOT IN ('tempdb', 'model', 'msdb')
ORDER BY [Database Name];