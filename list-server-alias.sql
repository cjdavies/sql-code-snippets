SELECT [server_name] AS [DB_Alias],
       [full_server_name]
FROM [TimeStarAdmin].[dbo].[admin_server_credentials]
WHERE [server_name] LIKE 'TSDB%'
ORDER BY [DB_Alias]