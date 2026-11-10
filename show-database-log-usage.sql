/* Show database log usage */
IF OBJECT_ID('tempdb..#LogUsage') IS NOT NULL DROP TABLE #LogUsage;

CREATE TABLE #LogUsage
(
    DatabaseID          SYSNAME,
    DatabaseName        SYSNAME,
    LogSizeMB           SYSNAME,
    UsedLogSpaceMB      SYSNAME,
    UsedLogSpacePercent SYSNAME
);

EXEC sp_MSforeachdb N'
USE [?];
INSERT INTO #LogUsage
SELECT DB_ID() AS DatabaseID,
       DB_NAME() AS DatabaseName,
       total_log_size_in_bytes / 1048576 AS LogSizeMB,
       used_log_space_in_bytes / 1048576 AS UsedLogSpaceMB,
       CAST(used_log_space_in_percent AS DECIMAL(5, 1)) AS UsedLogSpacePercent
FROM sys.dm_db_log_space_usage;
';

SELECT *
FROM #LogUsage
ORDER BY DatabaseName, LogSizeMB, UsedLogSpaceMB, UsedLogSpacePercent;
--ORDER BY UsedLogSpacePercent DESC, DatabaseID, LogSizeMB, UsedLogSpaceMB;

DROP TABLE #LogUsage;