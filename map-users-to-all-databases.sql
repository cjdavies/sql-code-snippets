DECLARE @sql NVARCHAR(MAX);

SET @sql = '';

SELECT 
    @sql += '
    USE [' + name + '];
    SELECT 
        ''' + name + ''' AS DatabaseName,
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
        dp.type IN (''S'', ''U'', ''G'', ''A'') -- S = SQL user, U = Windows user, G = Windows group, A = Application role
        AND dp.name NOT LIKE ''##%'' -- Exclude system accounts
    ORDER BY 
        UserName;
    ' 
FROM 
    sys.databases
WHERE 
    database_id > 5 -- Exclude system databases (master, model, msdb, tempdb, dba)
    AND state = 0; -- Ensure the database is online

EXEC sp_executesql @sql;

/*
Explanation:
Dynamic SQL:
The script constructs a query for each non-system database using the sys.databases view.
Database Filtering:
database_id > 4: Excludes system databases (master, model, msdb, tempdb).
state = 0: Ensures the database is online.
Dynamic Query Execution:
The sp_executesql system procedure executes the generated SQL.
Output:
The script outputs a consolidated list of user accounts and roles across all non-system databases. Each row includes the database name for easy reference. Run this script in SQL Server Management Studio (SSMS) at the server level.
*/
