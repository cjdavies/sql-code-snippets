SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET DEADLOCK_PRIORITY LOW;
GO
/* Calculate total storage used by user objects only */
SELECT 
    DB_NAME() AS DatabaseName,
    CAST(SUM(a.total_pages) * 8 / 1024.0 AS DECIMAL(18,2)) AS TotalUsedMB
FROM 
    sys.objects o
    INNER JOIN sys.indexes i 
        ON o.object_id = i.object_id
    INNER JOIN sys.partitions p 
        ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a 
        ON p.partition_id = a.container_id
WHERE 
    o.is_ms_shipped = 0  -- Exclude system objects
    AND o.type_desc <> 'SYSTEM_TABLE'
    AND i.object_id > 255; -- Exclude internal system tables;


/* Calculate for all non-system databases in the instance */
SET NOCOUNT ON;

CREATE TABLE #DBSpaceUsage (
    DatabaseName SYSNAME,
    TotalUsedMB DECIMAL(18,2)
);

EXEC sp_MSforeachdb '
IF ''?'' NOT IN (
    ''Admin'',
    ''AdventureWorks2012'',
    ''DBA'',
    ''DEID'',
    ''DMR'',
    ''master'',
    ''model'',
    ''msdb'',
    ''plumtree5_esc3'',
    ''smtp'',
    ''Temp_Object_Repository'',
    ''tempdb''
    )
BEGIN
    DECLARE @sql NVARCHAR(MAX) = N''
    USE [?];
    SELECT
        DB_NAME() AS DatabaseName,
        CAST(SUM(a.total_pages) * 8 / 1024.0 AS DECIMAL(18,2)) AS TotalUsedMB
    FROM sys.objects o
    INNER JOIN sys.indexes i 
        ON o.object_id = i.object_id
    INNER JOIN sys.partitions p 
        ON i.object_id = p.object_id AND i.index_id = p.index_id
    INNER JOIN sys.allocation_units a 
        ON p.partition_id = a.container_id
    WHERE o.is_ms_shipped = 0
      AND o.type_desc <> ''''SYSTEM_TABLE''''
      AND i.object_id > 255;
    '';
    INSERT INTO #DBSpaceUsage
    EXEC sp_executesql @sql;
END
';

SELECT * FROM #DBSpaceUsage ORDER BY TotalUsedMB DESC;

DROP TABLE #DBSpaceUsage;
