SELECT prin.name AS PrincipalName,
       perm.permission_name,
       perm.state_desc,
       obj.type_desc AS ObjectType,
       obj.name AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals prin ON perm.grantee_principal_id = prin.principal_id
LEFT JOIN sys.objects obj ON perm.major_id = obj.object_id
WHERE prin.name = 'svc_mdmofed';


EXECUTE AS USER = 'svc_mdmofed';
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');
REVERT;

SELECT * FROM fn_my_permissions('YourTableOrView', 'OBJECT');


SELECT dp.name AS RoleName, mp.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals dp ON drm.role_principal_id = dp.principal_id
JOIN sys.database_principals mp ON drm.member_principal_id = mp.principal_id
WHERE dp.name = 'svc_mdmofed';

In **SQL Server Management Studio (SSMS)**, under **"Users mapped to this login"** (found in the **Login Properties** window under the **User Mapping** tab), it indicates the **database users** that are associated with the selected SQL Server login.  

### Meaning:
- **Logins** are server-level security principals that allow access to the SQL Server instance.
- **Users** are database-level security principals that allow access to specific databases.
- A login must be **mapped** to a database user to grant access to that database.

### Key Information:
- The list shows **databases** where the login has a corresponding user.
- The **User column** displays the database username (which might differ from the login name).
- The **Default Schema column** shows the schema assigned to the user in that database.
- Checkboxes allow you to add or remove database mappings for the login.

This mapping ensures that the login can authenticate and access the database with the assigned permissions.