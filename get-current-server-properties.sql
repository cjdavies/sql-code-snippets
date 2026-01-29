/* Get current server properties */
/* https://learn.microsoft.com/en-us/sql/t-sql/functions/serverproperty-transact-sql?view=sql-server-ver17#examples */
SELECT
    SERVERPROPERTY('MachineName')                AS [ComputerName],
    SERVERPROPERTY('ServerName')                 AS [InstanceName],
    SERVERPROPERTY('ProductVersion')             AS [ProductVersion],
    SERVERPROPERTY('ProductLevel')               AS [ProductLevel],
    SERVERPROPERTY('Edition')                    AS [Edition],
    SERVERPROPERTY('Collation')                  AS [Collation],
    SERVERPROPERTY('InstanceDefaultDataPath')    AS [DefaultDataPath],
    SERVERPROPERTY('InstanceDefaultLogPath')     AS [DefaultLogPath];
--FROM [sys].[dm_os_windows_info];
