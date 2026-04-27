SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET DEADLOCK_PRIORITY LOW;
GO

SELECT
    sp.name        AS login_name,
    dp.name        AS database_user,
    dp.type_desc   AS user_type,
    r.name         AS database_role
FROM sys.database_principals dp
    LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
    LEFT JOIN sys.database_role_members rm
    ON dp.principal_id = rm.member_principal_id
    LEFT JOIN sys.database_principals r
    ON rm.role_principal_id = r.principal_id
WHERE dp.principal_id > 4 -- exclude system users
    AND dp.type NOT IN ('A', 'G', 'R') -- exclude application roles, database roles, and database users mapped to certificates/keys
ORDER BY login_name, database_user, database_role;
