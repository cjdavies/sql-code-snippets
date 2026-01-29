SELECT
    dp.name AS UserName,
    dp.type_desc AS UserType,
    dp.create_date,
    dp.modify_date,
    p.permission_name,
    p.state_desc AS PermissionState
FROM sys.database_principals dp
    LEFT JOIN sys.database_permissions p
           ON dp.principal_id = p.grantee_principal_id
WHERE
    dp.name = 'RsUser';