USE [YourDatabaseName]; -- Replace with your database name
GO

SELECT 
    dp.name AS UserName,
    dp.type_desc AS UserType,
    dp.create_date AS CreationDate,
    dp.modify_date AS LastModifiedDate,
    sp.name AS LoginName,
    dp.default_schema_name AS DefaultSchema,
    r.name AS DatabaseRole
FROM 
    sys.database_principals AS dp
LEFT JOIN 
    sys.server_principals AS sp
ON 
    dp.sid = sp.sid
LEFT JOIN 
    sys.database_role_members AS drm
ON 
    dp.principal_id = drm.member_principal_id
LEFT JOIN 
    sys.database_principals AS r
ON 
    drm.role_principal_id = r.principal_id
WHERE 
    dp.type IN ('S', 'U', 'G', 'A') -- S = SQL user, U = Windows user, G = Windows group, A = Application role
    AND dp.name NOT LIKE '##%' -- Exclude system accounts
ORDER BY 
    UserType, UserName;
GO

/*
Explanation:
sys.database_principals: Lists all users, roles, and application roles in the current database.
sys.server_principals: Maps database users to server-level logins.
sys.database_role_members: Links database users to database roles.
Filters:
dp.type IN ('S', 'U', 'G', 'A'): Includes SQL users, Windows users, Windows groups, and application roles.
dp.name NOT LIKE '##%': Excludes system-generated accounts.
This script provides a comprehensive list of user accounts, their associated login names, roles, and other relevant details in the specified database. Replace [YourDatabaseName] with the database of interest and execute it in SQL Server Management Studio (SSMS).
*/
