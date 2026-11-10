Here’s the short version first:
**In SQL Server 2019, you can identify who has access to a database — and what privileges they have — by querying system catalog views such as `sys.database_principals`, `sys.database_permissions`, `sys.server_principals`, and `sys.database_role_members`.**
 
Below is a complete, practical set of scripts you can run immediately.
 
---
 
## ✅ **1. List all users who have access to a specific database**
Run this **inside the target database**:
 
```sql
SELECT
    dp.name AS DatabaseUser,
    dp.type_desc AS PrincipalType,
    sp.name AS LoginName,
    sp.type_desc AS LoginType,
    dp.authentication_type_desc AS AuthenticationType
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE dp.type IN ('S','U','G','E','X')   -- SQL users, Windows users/groups, external, etc.
  AND dp.name NOT IN ('guest','INFORMATION_SCHEMA','sys')
ORDER BY dp.name;
```
 
This shows **who can access the database** and which login they map to.
 
---
 
## ✅ **2. Show all explicit permissions for each user**
This reveals **GRANT**, **DENY**, and **REVOKE** permissions at the object, schema, or database level.
 
```sql
SELECT
    dp.name AS PrincipalName,
    dp.type_desc AS PrincipalType,
    perm.permission_name,
    perm.state_desc AS PermissionState,
    perm.class_desc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp
    ON perm.grantee_principal_id = dp.principal_id
ORDER BY dp.name, perm.class_desc, perm.permission_name;
```
 
This is the core view of **who has what privileges**.
 
---
 
## ✅ **3. Show database role memberships**
This shows which users belong to roles like `db_datareader`, `db_owner`, etc.
 
```sql
SELECT
    role.name AS RoleName,
    member.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals role
    ON drm.role_principal_id = role.principal_id
JOIN sys.database_principals member
    ON drm.member_principal_id = member.principal_id
ORDER BY role.name, member.name;
```
 
Role membership is critical because roles grant many permissions implicitly.
 
---
 
## ✅ **4. Combine permissions + roles into a single unified view**
This gives a more complete picture of each user’s effective access.
 
```sql
-- Explicit permissions
SELECT
    dp.name AS PrincipalName,
    'EXPLICIT' AS PermissionSource,
    perm.permission_name AS PermissionName,
    perm.state_desc AS StateDesc,
    perm.class_desc AS ClassDesc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp
    ON perm.grantee_principal_id = dp.principal_id
 
UNION ALL
 
-- Role-based permissions
SELECT
    member.name AS PrincipalName,
    'ROLE: ' + role.name AS PermissionSource,
    perm.permission_name AS PermissionName,
    perm.state_desc AS StateDesc,
    perm.class_desc AS ClassDesc,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_role_members drm
JOIN sys.database_principals role
    ON drm.role_principal_id = role.principal_id
JOIN sys.database_principals member
    ON drm.member_principal_id = member.principal_id
JOIN sys.database_permissions perm
    ON perm.grantee_principal_id = role.principal_id
 
ORDER BY PrincipalName, PermissionSource, PermissionName;
```
 
This is the closest thing to a **full effective permissions report** without using external tools.
 
---
 
## ✅ **5. Identify server-level logins with access to the database**
Run this in **master**:
 
```sql
SELECT
    sp.name AS LoginName,
    sp.type_desc AS LoginType,
    sp.is_disabled,
    sl.sysadmin,
    sl.securityadmin,
    sl.serveradmin,
    sl.setupadmin,
    sl.processadmin,
    sl.diskadmin,
    sl.dbcreator,
    sl.bulkadmin
FROM sys.server_principals sp
LEFT JOIN sys.syslogins sl
    ON sp.sid = sl.sid
WHERE sp.type IN ('S','U','G')
ORDER BY sp.name;
```
 
This helps identify logins that may have **implicit access** (e.g., sysadmin).
 
---
 
The report is structured so that each section prints as plain text followed by the corresponding data. It uses `PRINT` statements and `SELECT` queries, producing a human-readable audit report.
 
---
 
# 📄 **SMTP Database Access Report (Text Output)**
### SQL Server 2019 — Full Access & Permissions Summary
Run this entire script **inside the SMTP database**.
 
```sql
/* ============================================================
   SMTP DATABASE ACCESS REPORT
   SQL Server 2019
   ============================================================ */
 
PRINT '============================================================';
PRINT 'DATABASE ACCESS REPORT FOR: SMTP';
PRINT 'Generated On: ' + CONVERT(varchar(30), GETDATE(), 120);
PRINT '============================================================';
PRINT '';
 
/* ============================================================
   SECTION 1 — DATABASE USERS
   ============================================================ */
PRINT '------------------------------------------------------------';
PRINT 'SECTION 1: USERS WITH ACCESS TO THIS DATABASE';
PRINT '------------------------------------------------------------';
 
SELECT
    dp.name AS DatabaseUser,
    dp.type_desc AS PrincipalType,
    sp.name AS LoginName,
    sp.type_desc AS LoginType,
    dp.authentication_type_desc AS AuthenticationType
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE dp.type IN ('S','U','G','E','X')
  AND dp.name NOT IN ('guest','INFORMATION_SCHEMA','sys')
ORDER BY dp.name;
 
PRINT '';
PRINT 'End of Section 1';
PRINT '';
 
/* ============================================================
   SECTION 2 — EXPLICIT PERMISSIONS
   ============================================================ */
PRINT '------------------------------------------------------------';
PRINT 'SECTION 2: EXPLICIT PERMISSIONS (GRANT / DENY)';
PRINT '------------------------------------------------------------';
 
SELECT
    dp.name AS PrincipalName,
    dp.type_desc AS PrincipalType,
    perm.permission_name AS Permission,
    perm.state_desc AS State,
    perm.class_desc AS Class,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals dp
    ON perm.grantee_principal_id = dp.principal_id
ORDER BY dp.name, perm.class_desc, perm.permission_name;
 
PRINT '';
PRINT 'End of Section 2';
PRINT '';
 
/* ============================================================
   SECTION 3 — ROLE MEMBERSHIP
   ============================================================ */
PRINT '------------------------------------------------------------';
PRINT 'SECTION 3: ROLE MEMBERSHIP';
PRINT '------------------------------------------------------------';
 
SELECT
    role.name AS RoleName,
    member.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals role
    ON drm.role_principal_id = role.principal_id
JOIN sys.database_principals member
    ON drm.member_principal_id = member.principal_id
ORDER BY role.name, member.name;
 
PRINT '';
PRINT 'End of Section 3';
PRINT '';
 
/* ============================================================
   SECTION 4 — ROLE-BASED PERMISSIONS
   ============================================================ */
PRINT '------------------------------------------------------------';
PRINT 'SECTION 4: PERMISSIONS INHERITED FROM ROLES';
PRINT '------------------------------------------------------------';
 
SELECT
    member.name AS PrincipalName,
    role.name AS RoleName,
    perm.permission_name AS Permission,
    perm.state_desc AS State,
    perm.class_desc AS Class,
    OBJECT_NAME(perm.major_id) AS ObjectName
FROM sys.database_role_members drm
JOIN sys.database_principals role
    ON drm.role_principal_id = role.principal_id
JOIN sys.database_principals member
    ON drm.member_principal_id = member.principal_id
JOIN sys.database_permissions perm
    ON perm.grantee_principal_id = role.principal_id
ORDER BY member.name, role.name, perm.permission_name;
 
PRINT '';
PRINT 'End of Section 4';
PRINT '';
 
/* ============================================================
   SECTION 5 — ORPHANED USERS
   ============================================================ */
PRINT '------------------------------------------------------------';
PRINT 'SECTION 5: ORPHANED USERS (NO MATCHING LOGIN)';
PRINT '------------------------------------------------------------';
 
SELECT
    dp.name AS OrphanedUser,
    dp.type_desc AS PrincipalType
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE sp.sid IS NULL
  AND dp.type IN ('S','U','G')
  AND dp.name NOT IN ('guest','INFORMATION_SCHEMA','sys');
 
PRINT '';
PRINT 'End of Section 5';
PRINT '';
 
/* ============================================================
   END OF REPORT
   ============================================================ */
PRINT '============================================================';
PRINT 'END OF SMTP DATABASE ACCESS REPORT';
PRINT '============================================================';
```
 
---
 
# 🧭 What this report gives you
 
### **1. Who can access the SMTP database**
- SQL users
- Windows users
- Windows groups
- External users
- Mapped logins
 
### **2. Explicit permissions**
Everything directly granted or denied:
- SELECT
- INSERT
- EXECUTE
- CONTROL
- ALTER
- VIEW DEFINITION
- etc.
 
### **3. Role membership**
Shows who is in:
- db_datareader
- db_datawriter
- db_owner
- custom roles
 
### **4. Role-based permissions**
Permissions inherited from roles (often the most important part).
 
### **5. Orphaned users**
Users whose logins no longer exist at the server level.
 
---
