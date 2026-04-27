In SQL Server 2019, **logins are server-level principals**, so you check for their existence in the **master database system views**, not in a user database.

Below are the **reliable and commonly accepted ways** to determine whether a login exists, depending on what problem you’re solving.

***

## ✅ Recommended: Query `sys.server_principals`

This is the **modern, supported** approach.

### Check for a specific login

```sql
SELECT 1
FROM sys.server_principals
WHERE name = N'YourLoginName';
```

If the query returns:

*   **1 row** → login exists
*   **0 rows** → login does not exist

***

### Wrap it in an IF EXISTS check (most practical)

```sql
IF EXISTS (
    SELECT 1
    FROM sys.server_principals
    WHERE name = N'YourLoginName'
)
    PRINT 'Login exists';
ELSE
    PRINT 'Login does not exist';
```

***

## 🔍 Filter by Login Type (Optional but Useful)

This helps distinguish SQL logins vs Windows logins.

### SQL-authenticated logins only

```sql
SELECT 1
FROM sys.server_principals
WHERE name = N'YourLoginName'
  AND type_desc = 'SQL_LOGIN';
```

### Windows users or groups

```sql
SELECT 1
FROM sys.server_principals
WHERE name = N'DOMAIN\UserOrGroup'
  AND type_desc IN ('WINDOWS_LOGIN', 'WINDOWS_GROUP');
```

***

## ✅ Legacy (Still Works): `sys.syslogins` (Not Recommended)

```sql
SELECT 1
FROM sys.syslogins
WHERE name = N'YourLoginName';
```

⚠️ `sys.syslogins` is **deprecated**. Avoid it in new code.

***

## 🚫 What *Not* To Do

### ❌ `sys.database_principals`

This checks **database users**, not server logins:

```sql
-- NOT correct for logins
SELECT * FROM sys.database_principals;
```

A login may exist **without** a database user, and vice versa.

***

## ✅ Check Login + Access Pattern (Best Practice)

If your goal is to safely create a login only if it doesn’t exist:

```sql
IF NOT EXISTS (
    SELECT 1
    FROM sys.server_principals
    WHERE name = N'YourLoginName'
)
BEGIN
    CREATE LOGIN [YourLoginName]
    WITH PASSWORD = 'StrongPasswordHere!';
END;
```

***

## ✅ Bonus: Check Login and Its Status

```sql
SELECT
    name,
    type_desc,
    is_disabled,
    create_date,
    modify_date
FROM sys.server_principals
WHERE name = N'YourLoginName';
```

Useful for:

*   troubleshooting access issues
*   auditing
*   detecting disabled logins

***

## ✅ Summary

**To determine whether a login exists in SQL Server 2019:**

✅ Use:

```sql
sys.server_principals
```

✅ Prefer:

```sql
IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = ...)
```

🚫 Avoid:

*   `sys.database_principals`
*   deprecated views unless maintaining legacy code

***

If you want, I can also show:

*   how to map a login to database users
*   how to detect orphaned users
*   how this behaves in AGs / failovers
*   how Azure SQL differs

Just tell me 👍


To see **which databases a SQL Server login is mapped to**, you’re really looking for **database users whose `SID` matches the login’s `SID`**.

Below are **correct, production‑safe ways** to do this in SQL Server 2019, including edge cases like **contained databases**.

***

## ✅ Core Concept (Important)

*   **Logins** live at the **server level**
*   **Users** live at the **database level**
*   A login is mapped to a database user **by SID**, not by name

***

## ✅ Step 1: Get the Login’s SID (optional but useful)

```sql
SELECT
    name,
    sid,
    type_desc
FROM sys.server_principals
WHERE name = N'YourLoginName';
```

You don’t *have* to manually capture the SID—we’ll resolve it inline below.

***

## ✅ Step 2 (Most Common): Find All Databases the Login Is Mapped To

This script loops through all online databases and checks for a matching user.

```sql
DECLARE @LoginName sysname = N'YourLoginName';

CREATE TABLE #LoginMappings
(
    DatabaseName sysname,
    UserName sysname,
    UserType nvarchar(60)
);

DECLARE @sql nvarchar(max);

SELECT @sql = STRING_AGG(CONVERT(nvarchar(max), '
USE ' + QUOTENAME(name) + ';
INSERT INTO #LoginMappings (DatabaseName, UserName, UserType)
SELECT
    DB_NAME(),
    dp.name,
    dp.type_desc
FROM sys.database_principals dp
JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE sp.name = ''' + @LoginName + '''
  AND dp.type IN (''S'',''U'',''G'');
'), CHAR(13))
FROM sys.databases
WHERE state_desc = 'ONLINE';

EXEC sys.sp_executesql @sql;

SELECT *
FROM #LoginMappings
ORDER BY DatabaseName;

DROP TABLE #LoginMappings;
```

### ✅ Output tells you:

*   Database name
*   Database user name
*   User type (SQL user, Windows user, Windows group)

***

## ✅ Lightweight Alternative (Run Per Database)

If you already know which database you care about:

```sql
USE YourDatabaseName;

SELECT
    dp.name AS UserName,
    dp.type_desc
FROM sys.database_principals dp
WHERE dp.sid = SUSER_SID(N'YourLoginName');
```

If it returns rows → the login is mapped

***

## ✅ Contained Databases (Very Important Edge Case)

Contained database users **do NOT map to server logins**.

To detect those:

```sql
SELECT
    name,
    type_desc,
    authentication_type_desc
FROM sys.database_principals
WHERE authentication_type_desc = 'DATABASE';
```

If a database uses contained users:

*   That user will **not appear** in `sys.server_principals`
*   It authenticates **directly to the database**

***

## ✅ Detect Orphaned Users (Related but Different Problem)

A login might be deleted, leaving users behind:

```sql
USE YourDatabaseName;

SELECT
    dp.name AS OrphanedUser
FROM sys.database_principals dp
LEFT JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE sp.sid IS NULL
  AND dp.type IN ('S','U')
  AND dp.name NOT IN ('dbo','guest','sys','INFORMATION_SCHEMA');
```

***

## ✅ Bonus: Include Role Memberships

```sql
USE YourDatabaseName;

SELECT
    u.name AS UserName,
    r.name AS RoleName
FROM sys.database_principals u
JOIN sys.database_role_members rm
    ON u.principal_id = rm.member_principal_id
JOIN sys.database_principals r
    ON rm.role_principal_id = r.principal_id
WHERE u.sid = SUSER_SID(N'YourLoginName');
```

***

## ✅ Summary

**To identify which databases a login is mapped to:**

✔ Use `sys.server_principals` to identify the login  
✔ Use `sys.database_principals` to find users  
✔ Match them **by SID**  
✔ Loop through databases for a full picture

**Key reminders**

*   Same login name ≠ same mapping
*   SID matters
*   Contained users are separate

***

If you want, I can also:

*   convert this into a stored procedure
*   add AG / failover awareness
*   generate a security audit report
*   auto‑fix orphaned users safely

Just say the word.


To **map a server login to a database** in SQL Server 2019, you create a **database user** that is linked to that login. The mapping is done by **SID**, not just by name.

Below are the **correct patterns**, including common scenarios and fixes.

***

## ✅ Default & Correct Method (Most Common)

### 1️⃣ Ensure the login exists

```sql
SELECT name
FROM sys.server_principals
WHERE name = N'YourLoginName';
```

***

### 2️⃣ Create the database user mapped to the login

```sql
USE YourDatabaseName;
GO

CREATE USER [YourLoginName]
FOR LOGIN [YourLoginName];
```

✅ This automatically maps the database user’s SID to the login’s SID.

***

## ✅ Grant Permissions or Roles (Typical Next Step)

### Add to a database role

```sql
USE YourDatabaseName;

ALTER ROLE db_datareader ADD MEMBER [YourLoginName];
ALTER ROLE db_datawriter ADD MEMBER [YourLoginName];
```

### Or grant specific permissions

```sql
GRANT SELECT, INSERT, UPDATE ON dbo.YourTable TO [YourLoginName];
```

***

## ✅ Windows Login or Group

Same syntax works for Windows principals:

```sql
USE YourDatabaseName;

CREATE USER [DOMAIN\UserOrGroup]
FOR LOGIN [DOMAIN\UserOrGroup];
```

***

## ✅ Login Exists, User Already Exists but Is **Orphaned**

This happens if:

*   database was restored
*   login was recreated
*   SID mismatch

### Fix the mapping safely

```sql
USE YourDatabaseName;

ALTER USER [UserNameInDatabase]
WITH LOGIN = [YourLoginName];
```

✅ This rebinds the SID without dropping permissions.

***

## ✅ If the User Does Not Exist Yet (Explicit SID Mapping)

Useful in scripted deployments:

```sql
USE YourDatabaseName;

CREATE USER [UserNameInDatabase]
FOR LOGIN [YourLoginName]
WITH DEFAULT_SCHEMA = dbo;
```

***

## ✅ Verify the Mapping

```sql
USE YourDatabaseName;

SELECT
    dp.name AS UserName,
    dp.sid,
    sp.name AS LoginName
FROM sys.database_principals dp
JOIN sys.server_principals sp
    ON dp.sid = sp.sid
WHERE sp.name = N'YourLoginName';
```

If rows return → mapping is successful ✅

***

## 🚫 Contained Database (Important Exception)

If the database is **contained**, you do **not** map to a login.

```sql
USE YourContainedDB;

CREATE USER ContainedUser
WITH PASSWORD = 'StrongPassword!';
```

Contained users:

*   authenticate directly to the database
*   do *not* appear in `sys.server_principals`

Check containment:

```sql
SELECT containment_desc
FROM sys.databases
WHERE name = 'YourDatabaseName';
```

***

## ✅ Best‑Practice “Safe Mapping” Script

Use this pattern in automation:

```sql
USE YourDatabaseName;

IF NOT EXISTS (
    SELECT 1 FROM sys.database_principals WHERE name = N'YourLoginName'
)
BEGIN
    CREATE USER [YourLoginName]
    FOR LOGIN [YourLoginName];
END
ELSE
BEGIN
    ALTER USER [YourLoginName]
    WITH LOGIN = [YourLoginName];
END;
```

***

## ✅ Summary

**To map a login to a database in SQL Server 2019:**

✔ Login must exist (`sys.server_principals`)  
✔ Create or alter a database user (`sys.database_principals`)  
✔ Mapping is done via **SID**  
✔ Grant roles or permissions afterward  
✔ Use `ALTER USER ... WITH LOGIN` to fix orphaned users

***

If you want, I can:

*   generate a script to map a login across **all databases**
*   handle **AG / read replicas**
*   audit effective permissions
*   compare SQL login vs Windows vs contained users

Just tell me what you’re aiming for.

Below is a **safe, production‑ready way to map an existing SQL Server login across *all databases*** on a SQL Server 2019 instance.

This handles:

*   databases where the user **does not exist**
*   databases where the user **exists but is orphaned**
*   excludes system databases
*   skips offline / read‑only databases
*   preserves existing permissions

***

## ✅ Prerequisites

*   The **login must already exist**
*   You need **sysadmin** or sufficient rights to create/alter users in each database

```sql
-- Verify login exists
SELECT name, type_desc
FROM sys.server_principals
WHERE name = N'YourLoginName';
```

***

## ✅ Recommended Script: Map Login Across All Databases

```sql
DECLARE @LoginName sysname = N'YourLoginName';
DECLARE @sql nvarchar(MAX);

SELECT @sql = STRING_AGG(CONVERT(nvarchar(MAX), '
USE ' + QUOTENAME(name) + ';

IF DB_ID() > 4  -- exclude master, model, msdb, tempdb
BEGIN
    -- Skip contained databases
    IF (SELECT containment FROM sys.databases WHERE name = DB_NAME()) = 0
    BEGIN
        IF NOT EXISTS (
            SELECT 1
            FROM sys.database_principals
            WHERE name = ''' + @LoginName + '''
        )
        BEGIN
            CREATE USER ' + QUOTENAME(@LoginName) + '
            FOR LOGIN ' + QUOTENAME(@LoginName) + ';
        END
        ELSE
        BEGIN
            ALTER USER ' + QUOTENAME(@LoginName) + '
            WITH LOGIN = ' + QUOTENAME(@LoginName) + ';
        END
    END
END
'), CHAR(13))
FROM sys.databases
WHERE state_desc = 'ONLINE'
  AND is_read_only = 0;

EXEC sys.sp_executesql @sql;
```

### ✅ What this does

| Scenario                   | Result                      |
| -------------------------- | --------------------------- |
| Login exists, user missing | ✅ `CREATE USER`             |
| User exists but orphaned   | ✅ `ALTER USER … WITH LOGIN` |
| User already mapped        | ✅ safely re‑affirms mapping |
| Contained database         | ✅ skipped                   |
| Offline / read‑only DB     | ✅ skipped                   |

***

## ✅ Optional: Automatically Add Roles (Common Use Case)

Example: Add the login to `db_datareader` and `db_datawriter` everywhere.

Add *inside* the `BEGIN … END` block:

```sql
ALTER ROLE db_datareader ADD MEMBER [YourLoginName];
ALTER ROLE db_datawriter ADD MEMBER [YourLoginName];
```

✅ This will **not error** if the user already belongs to the role.

***

## ✅ Verification Query (Afterwards)

```sql
DECLARE @LoginName sysname = N'YourLoginName';

SELECT
    d.name AS DatabaseName,
    dp.name AS UserName
FROM sys.databases d
CROSS APPLY (
    SELECT name
    FROM sys.database_principals
    WHERE sid = SUSER_SID(@LoginName)
) dp
WHERE d.state_desc = 'ONLINE'
ORDER BY d.name;
```

***

## 🚫 Important Exclusions & Caveats

### Contained Databases

Logins **cannot** be mapped.

```sql
SELECT name
FROM sys.databases
WHERE containment_desc <> 'NONE';
```

Use **contained users** instead:

```sql
CREATE USER SomeUser
WITH PASSWORD = 'StrongPassword';
```

***

### Availability Groups (AGs)

*   Run the script **on the primary replica**
*   Logins must exist on **every replica**
*   SID consistency matters for failover

***

## ✅ Best Practice (Enterprise Safety)

If you deploy logins via scripts:

*   Create logins **with explicit SID**
*   Store SID centrally
*   Restore databases without orphan users

***

## ✅ Summary

✔ Mapping a login across all databases =  
**create or rebind database users by SID**

✔ Safe automation pattern:

*   Loop databases
*   `CREATE USER` if missing
*   `ALTER USER … WITH LOGIN` if orphaned
*   Skip system, offline, read‑only, contained DBs

***

If you want, I can:

*   add **role selection parameters**
*   make this a **stored procedure**
*   add **AG‑aware logic**
*   generate a **security audit report**
*   auto‑sync logins across replicas

Just tell me what environment you’re working in.


Below is an **enhanced, safe version of the “map login across all databases” script with role mapping built‑in**.

It will:

✅ Create the database user if missing  
✅ Fix orphaned users if present  
✅ Add the user to one or more **database roles**  
✅ Skip system, offline, read‑only, and contained databases  
✅ Avoid errors if the user is already in the role

***

## ✅ Parameterized Script: Login + Role Mapping Across All Databases

### 🔧 Customize these variables

```sql
DECLARE @LoginName sysname = N'YourLoginName';

-- Comma‑separated list of database roles to assign
DECLARE @Roles nvarchar(MAX) = N'db_datareader,db_datawriter';
```

***

### ▶️ Full Script

```sql
DECLARE @sql nvarchar(MAX);

SELECT @sql = STRING_AGG(CONVERT(nvarchar(MAX), '
USE ' + QUOTENAME(name) + ';

-- Exclude system databases
IF DB_ID() > 4
BEGIN
    -- Skip contained databases
    IF (SELECT containment FROM sys.databases WHERE name = DB_NAME()) = 0
    BEGIN
        -- Create or fix user mapping
        IF NOT EXISTS (
            SELECT 1
            FROM sys.database_principals
            WHERE name = ''' + @LoginName + '''
        )
        BEGIN
            CREATE USER ' + QUOTENAME(@LoginName) + '
            FOR LOGIN ' + QUOTENAME(@LoginName) + ';
        END
        ELSE
        BEGIN
            ALTER USER ' + QUOTENAME(@LoginName) + '
            WITH LOGIN = ' + QUOTENAME(@LoginName) + ';
        END

        -- Role assignments
        DECLARE @role sysname;
        DECLARE role_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT TRIM(value)
            FROM STRING_SPLIT(''' + @Roles + ''', '','');

        OPEN role_cursor;
        FETCH NEXT FROM role_cursor INTO @role;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            IF EXISTS (
                SELECT 1
                FROM sys.database_principals
                WHERE name = @role
                  AND type = ''R''
            )
            BEGIN
                EXEC (N''ALTER ROLE '' + QUOTENAME(@role) +
                      N'' ADD MEMBER ' + QUOTENAME(@LoginName) + '''');
            END
            FETCH NEXT FROM role_cursor INTO @role;
        END

        CLOSE role_cursor;
        DEALLOCATE role_cursor;
    END
END
'), CHAR(13))
FROM sys.databases
WHERE state_desc = 'ONLINE'
  AND is_read_only = 0;

EXEC sys.sp_executesql @sql;
```

***

## ✅ What Roles Can You Assign?

Common options include:

| Role            | Purpose                               |
| --------------- | ------------------------------------- |
| `db_datareader` | Read all user tables                  |
| `db_datawriter` | Write to all user tables              |
| `db_ddladmin`   | Create/alter schema objects           |
| `db_owner`      | Full database control (use carefully) |
| Custom roles    | Application‑specific access           |

Example:

```sql
DECLARE @Roles = N'db_datareader,db_ddladmin';
```

***

## ✅ Why This Script Is Safe

✔ Uses `ALTER ROLE … ADD MEMBER` (idempotent)  
✔ Does **not** drop or recreate users  
✔ Preserves existing permissions  
✔ Does not fail if roles already assigned  
✔ Skips databases where login mapping is invalid

***

## ✅ Optional: Verification Query

Run this after execution to confirm role membership:

```sql
DECLARE @LoginName sysname = N'YourLoginName';

SELECT
    DB_NAME() AS DatabaseName,
    r.name AS RoleName
FROM sys.database_principals u
JOIN sys.database_role_members rm
    ON u.principal_id = rm.member_principal_id
JOIN sys.database_principals r
    ON rm.role_principal_id = r.principal_id
WHERE u.name = @LoginName;
```

(Execute per database or wrap in a loop if desired.)

***

## 🚨 Important Notes

### Contained databases

These are **intentionally skipped**. Logins cannot be mapped there.

### Availability Groups

Run this:

*   on the **primary replica**
*   after ensuring the login exists **with the same SID** everywhere

### `db_owner`

Grant cautiously—this is effectively full admin over that database.

***

## ✅ Summary

This script fully automates **enterprise‑safe login mapping + role assignment across all databases**, handling:

✔ Missing users  
✔ Orphaned users  
✔ Multiple roles  
✔ Real‑world operational edge cases

***

If you’d like, I can also:

*   convert this into a **stored procedure**
*   add **per‑database role logic**
*   make it **AG‑aware**
*   log results to a **security audit table**
*   add **exception handling / dry‑run mode**

Just tell me how far you want to take it.


