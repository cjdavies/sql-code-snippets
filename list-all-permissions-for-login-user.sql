/*
I'll create a comprehensive SQL script that lists all permissions for a given login and user in SQL Server. This script will cover server-level permissions, database-level permissions, and object-level permissions.This comprehensive SQL script provides a complete permissions audit for any login and user in SQL Server. Here's what it covers:

## Key Features:

1. **Server-Level Permissions**: Shows login details, server role memberships, and explicit server permissions
2. **Database-Level Permissions**: Displays database users, role memberships, and database permissions
3. **Effective Permissions**: Summarizes what the user can actually do
4. **Object-Level Details**: Shows detailed permissions on tables, views, procedures, etc., including column-level permissions
5. **Orphaned Users Check**: Identifies database users without matching server logins

## How to Use:

1. **Set the variables at the top**:
   - `@LoginName`: The server login name to analyze
   - `@UserName`: The database user name to analyze
   - `@DatabaseName`: Specific database (leave NULL for current database)

2. **Example usage**:
   ```sql
   DECLARE @LoginName NVARCHAR(128) = 'DOMAIN\JohnDoe'
   DECLARE @UserName NVARCHAR(128) = 'JohnDoe'
   DECLARE @DatabaseName NVARCHAR(128) = 'MyDatabase'
   ```

## What You'll Get:

- **Complete audit trail** of all permissions
- **Role memberships** at both server and database levels
- **Explicit permissions** granted or denied
- **Object-specific permissions** including column-level security
- **Security issues** like orphaned users
- **Formatted output** that's easy to read and analyze

The script is designed to work across different SQL Server versions and provides a professional-grade permissions report that security administrators and DBAs can use for compliance audits, troubleshooting access issues, or general security reviews.
*/

-- =============================================
-- SQL Server Login and User Permissions Report
-- =============================================
-- This script provides a comprehensive view of all permissions
-- for a specified login and user across server and database levels
-- =============================================

-- Variables to specify the login and user to analyze
DECLARE @LoginName NVARCHAR(128) = 'YourLoginName'  -- Replace with actual login name
DECLARE @UserName NVARCHAR(128) = 'YourUserName'    -- Replace with actual user name (can be same as login)
DECLARE @DatabaseName NVARCHAR(128) = NULL          -- Leave NULL for current DB, or specify database name

-- Set database context if specified
IF @DatabaseName IS NOT NULL
BEGIN
    DECLARE @SQL NVARCHAR(MAX) = 'USE ' + QUOTENAME(@DatabaseName)
    EXEC sp_executesql @SQL
END

PRINT '========================================'
PRINT 'PERMISSIONS REPORT FOR:'
PRINT 'Login: ' + ISNULL(@LoginName, 'ALL LOGINS')
PRINT 'User: ' + ISNULL(@UserName, 'ALL USERS') 
PRINT 'Database: ' + ISNULL(@DatabaseName, DB_NAME())
PRINT 'Report Date: ' + CONVERT(VARCHAR(23), GETDATE(), 121)
PRINT '========================================'
PRINT ''

-- =============================================
-- 1. SERVER-LEVEL PERMISSIONS
-- =============================================
PRINT '1. SERVER-LEVEL PERMISSIONS'
PRINT '----------------------------'

-- Server principals (logins)
SELECT 
    'SERVER PRINCIPALS' AS [Category],
    sp.name AS [Principal_Name],
    sp.type_desc AS [Principal_Type],
    sp.is_disabled AS [Is_Disabled],
    sp.create_date AS [Create_Date],
    sp.modify_date AS [Modify_Date]
FROM sys.server_principals sp
WHERE (@LoginName IS NULL OR sp.name = @LoginName)
    AND sp.type IN ('S', 'U', 'G')  -- SQL Login, Windows User, Windows Group

-- Server role memberships
SELECT DISTINCT
    'SERVER ROLE MEMBERSHIP' AS [Category],
    sp.name AS [Principal_Name],
    sr.name AS [Server_Role],
    'GRANT' AS [Permission_State],
    'ROLE_MEMBERSHIP' AS [Permission_Name],
    'SERVER' AS [Scope]
FROM sys.server_role_members srm
    INNER JOIN sys.server_principals sp ON srm.member_principal_id = sp.principal_id
    INNER JOIN sys.server_principals sr ON srm.role_principal_id = sr.principal_id
WHERE (@LoginName IS NULL OR sp.name = @LoginName)

-- Explicit server permissions
SELECT 
    'SERVER PERMISSIONS' AS [Category],
    sp.name AS [Principal_Name],
    spe.state_desc AS [Permission_State],
    spe.permission_name AS [Permission_Name],
    'SERVER' AS [Scope],
    spe.class_desc AS [Class],
    ISNULL(ssp.name, 'SERVER') AS [Securable_Name]
FROM sys.server_permissions spe
    INNER JOIN sys.server_principals sp ON spe.grantee_principal_id = sp.principal_id
    LEFT JOIN sys.server_principals ssp ON spe.major_id = ssp.principal_id
WHERE (@LoginName IS NULL OR sp.name = @LoginName)
    AND spe.class IN (100, 101, 105)  -- Server, Server Principal, Endpoint

PRINT ''

-- =============================================
-- 2. DATABASE-LEVEL PERMISSIONS
-- =============================================
PRINT '2. DATABASE-LEVEL PERMISSIONS'
PRINT '------------------------------'

-- Database principals (users)
SELECT 
    'DATABASE PRINCIPALS' AS [Category],
    dp.name AS [Principal_Name],
    dp.type_desc AS [Principal_Type],
    dp.create_date AS [Create_Date],
    dp.modify_date AS [Modify_Date],
    ISNULL(sp.name, 'N/A') AS [Mapped_Login]
FROM sys.database_principals dp
    LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE (@UserName IS NULL OR dp.name = @UserName)
    AND dp.type IN ('S', 'U', 'G')  -- SQL User, Windows User, Windows Group
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys')

-- Database role memberships
SELECT DISTINCT
    'DATABASE ROLE MEMBERSHIP' AS [Category],
    dp.name AS [Principal_Name],
    dr.name AS [Database_Role],
    'GRANT' AS [Permission_State],
    'ROLE_MEMBERSHIP' AS [Permission_Name],
    'DATABASE' AS [Scope]
FROM sys.database_role_members drm
    INNER JOIN sys.database_principals dp ON drm.member_principal_id = dp.principal_id
    INNER JOIN sys.database_principals dr ON drm.role_principal_id = dr.principal_id
WHERE (@UserName IS NULL OR dp.name = @UserName)
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys')

-- Explicit database permissions
SELECT 
    'DATABASE PERMISSIONS' AS [Category],
    dp.name AS [Principal_Name],
    dpe.state_desc AS [Permission_State],
    dpe.permission_name AS [Permission_Name],
    dpe.class_desc AS [Class],
    CASE 
        WHEN dpe.class = 0 THEN 'DATABASE'
        WHEN dpe.class = 1 THEN ISNULL(o.name, 'UNKNOWN_OBJECT')
        WHEN dpe.class = 3 THEN s.name
        WHEN dpe.class = 4 THEN dpr.name
        WHEN dpe.class = 5 THEN a.name
        WHEN dpe.class = 6 THEN t.name
        ELSE 'UNKNOWN'
    END AS [Securable_Name],
    CASE 
        WHEN dpe.class = 0 THEN 'DATABASE'
        WHEN dpe.class = 1 THEN ISNULL(s.name + '.' + o.name, 'UNKNOWN')
        WHEN dpe.class = 3 THEN s.name
        ELSE ''
    END AS [Full_Object_Name]
FROM sys.database_permissions dpe
    INNER JOIN sys.database_principals dp ON dpe.grantee_principal_id = dp.principal_id
    LEFT JOIN sys.objects o ON dpe.major_id = o.object_id AND dpe.class = 1
    LEFT JOIN sys.schemas s ON ISNULL(o.schema_id, dpe.major_id) = s.schema_id
    LEFT JOIN sys.database_principals dpr ON dpe.major_id = dpr.principal_id AND dpe.class = 4
    LEFT JOIN sys.assemblies a ON dpe.major_id = a.assembly_id AND dpe.class = 5
    LEFT JOIN sys.types t ON dpe.major_id = t.user_type_id AND dpe.class = 6
WHERE (@UserName IS NULL OR dp.name = @UserName)
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys')

PRINT ''

-- =============================================
-- 3. EFFECTIVE PERMISSIONS SUMMARY
-- =============================================
PRINT '3. EFFECTIVE PERMISSIONS SUMMARY'
PRINT '--------------------------------'

-- Get effective permissions for specific user on database
IF @UserName IS NOT NULL
BEGIN
    SELECT 
        'EFFECTIVE PERMISSIONS' AS [Category],
        @UserName AS [Principal_Name],
        permission_name AS [Permission_Name],
        'DATABASE' AS [Scope],
        'EFFECTIVE' AS [Permission_State]
    FROM fn_my_permissions(NULL, 'DATABASE')
    WHERE HAS_PERMS_BY_NAME(DB_NAME(), 'DATABASE', permission_name, @UserName, 'ANY') = 1
END

-- =============================================
-- 4. OBJECT-LEVEL PERMISSIONS DETAIL
-- =============================================
PRINT ''
PRINT '4. DETAILED OBJECT PERMISSIONS'
PRINT '-------------------------------'

-- Detailed object permissions with column-level details
SELECT 
    'OBJECT PERMISSIONS' AS [Category],
    dp.name AS [Principal_Name],
    dpe.state_desc AS [Permission_State],
    dpe.permission_name AS [Permission_Name],
    s.name AS [Schema_Name],
    o.name AS [Object_Name],
    o.type_desc AS [Object_Type],
    CASE 
        WHEN dpe.minor_id = 0 THEN 'ALL_COLUMNS'
        ELSE c.name 
    END AS [Column_Name]
FROM sys.database_permissions dpe
    INNER JOIN sys.database_principals dp ON dpe.grantee_principal_id = dp.principal_id
    INNER JOIN sys.objects o ON dpe.major_id = o.object_id
    INNER JOIN sys.schemas s ON o.schema_id = s.schema_id
    LEFT JOIN sys.columns c ON dpe.major_id = c.object_id AND dpe.minor_id = c.column_id
WHERE dpe.class = 1  -- Object permissions
    AND (@UserName IS NULL OR dp.name = @UserName)
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys')
ORDER BY s.name, o.name, dp.name, dpe.permission_name, c.name

-- =============================================
-- 5. ORPHANED USERS CHECK
-- =============================================
PRINT ''
PRINT '5. ORPHANED USERS CHECK'
PRINT '-----------------------'

SELECT 
    'ORPHANED USER CHECK' AS [Category],
    dp.name AS [Database_User],
    'ORPHANED' AS [Status],
    'No matching server login' AS [Issue]
FROM sys.database_principals dp
    LEFT JOIN sys.server_principals sp ON dp.sid = sp.sid
WHERE dp.type IN ('S', 'U')  -- SQL and Windows users
    AND dp.sid IS NOT NULL
    AND dp.sid NOT IN (0x00, 0x01)  -- Exclude system SIDs
    AND sp.sid IS NULL
    AND (@UserName IS NULL OR dp.name = @UserName)
    AND dp.name NOT IN ('guest', 'INFORMATION_SCHEMA', 'sys', 'dbo')

PRINT ''
PRINT '========================================'
PRINT 'END OF PERMISSIONS REPORT'
PRINT '========================================'

-- =============================================
-- Usage Instructions:
-- =============================================
/*
USAGE INSTRUCTIONS:
1. Replace @LoginName with the login name you want to analyze
2. Replace @UserName with the database user name you want to analyze  
3. Optionally set @DatabaseName to analyze a specific database
4. Run the script to get a comprehensive permissions report

EXAMPLE:
DECLARE @LoginName NVARCHAR(128) = 'DOMAIN\JohnDoe'
DECLARE @UserName NVARCHAR(128) = 'JohnDoe'  
DECLARE @DatabaseName NVARCHAR(128) = 'MyDatabase'

The script will show:
- Server-level permissions and role memberships
- Database-level permissions and role memberships  
- Effective permissions
- Detailed object-level permissions including column permissions
- Orphaned users that have no matching server login
*/
