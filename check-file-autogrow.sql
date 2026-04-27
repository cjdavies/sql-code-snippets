SELECT
    mf.name AS [File Name],
    mf.physical_name AS [Physical Name],
    mf.size * 8 / 1024 AS [Size (MB)],
    mf.growth * 8 / 1024 AS [AutoGrow Increment (MB)],
    CASE
        WHEN mf.growth = 0 THEN 'No AutoGrow'
        WHEN mf.is_percent_growth = 1 THEN 'Percentage-based growth'
        WHEN mf.is_percent_growth = 0 THEN 'Size-based growth'
        ELSE 'Unknown'
    END AS [Growth Type],
    mf.max_size AS [Max Size]
FROM sys.master_files mf
ORDER BY [File Name], [Physical Name];
