SELECT prin.name AS PrincipalName,
       perm.permission_name,
       perm.state_desc,
       obj.type_desc AS ObjectType,
       obj.name AS ObjectName
FROM sys.database_permissions perm
JOIN sys.database_principals prin ON perm.grantee_principal_id = prin.principal_id
LEFT JOIN sys.objects obj ON perm.major_id = obj.object_id
WHERE prin.name = 'YourUserOrRoleName';


EXECUTE AS USER = 'YourUserOrRoleName';
SELECT * FROM fn_my_permissions(NULL, 'DATABASE');
REVERT;

SELECT * FROM fn_my_permissions('YourTableOrView', 'OBJECT');


SELECT dp.name AS RoleName, mp.name AS MemberName
FROM sys.database_role_members drm
JOIN sys.database_principals dp ON drm.role_principal_id = dp.principal_id
JOIN sys.database_principals mp ON drm.member_principal_id = mp.principal_id
WHERE dp.name = 'YourRoleName';
