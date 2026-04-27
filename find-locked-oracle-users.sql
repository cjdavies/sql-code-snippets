SELECT username, account_status, lock_date
FROM dba_users
WHERE account_status <> 'OPEN'
ORDER BY lock_date DESC, username ASC;