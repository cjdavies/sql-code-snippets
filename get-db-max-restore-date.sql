SELECT MAX(restore_date) AS LastRefreshDate
  FROM msdb.dbo.restorehistory
 WHERE destination_database_name = 'smtp';

SELECT TOP (1)
    rh.restore_date,
    rh.user_name,
    rh.restore_type,
    rh.destination_database_name
FROM msdb.dbo.restorehistory AS rh
WHERE rh.destination_database_name = DB_NAME()
ORDER BY rh.restore_date DESC;