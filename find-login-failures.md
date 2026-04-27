In **SQL Server 2019**, login failures can be checked in a few standard places, depending on *how* SQL Server is configured and *what level of detail* you need.

***

## 1. SQL Server Error Log (Most Common)

SQL Server records **login failure messages (Error 18456)** in the SQL Server error log.

### Using SSMS

1.  Open **SQL Server Management Studio**
2.  Go to **Management**
3.  Expand **SQL Server Logs**
4.  Open **Current** (or archived) log
5.  Filter for:
    ```text
    Error: 18456
    ```

### Using T‑SQL

```sql
EXEC xp_readerrorlog 0, 1, '18456';
```

Optional filtering:

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed';
```

> This gives you:

*   Login name
*   Failure reason (state code)
*   Client IP (sometimes)

⚠️ **By default**, SQL Server does **NOT** log successful logins, only failures.

***

## 2. Windows Event Viewer (Security Log)

If SQL Server is configured to log to Windows:

### Where to look

*   **Event Viewer**
    *   Windows Logs
        *   **Application** → SQL Server events
        *   **Security** → If Windows Authentication failures

### Typical events

*   **Event ID 18456** – SQL Server login failure
*   **Event ID 4625** – Windows logon failure (Windows Auth)

You’ll often see the **client IP and account name** here, which isn’t always present in the SQL error log.

***

## 3. Enable More Detailed Login Auditing (If Needed)

To log **both successful and failed logins**:

### SSMS

1.  Right‑click the server → **Properties**
2.  **Security**
3.  Set **Login auditing** to:
    *   ✅ *Failed logins only* (default)
    *   ✅ *Successful logins only*
    *   ✅ *Both failed and successful logins*

### Via T‑SQL

```sql
EXEC xp_instance_regwrite
  N'HKEY_LOCAL_MACHINE',
  N'Software\Microsoft\MSSQLServer\MSSQLServer',
  N'AuditLevel',
  REG_DWORD,
  3;  -- 0=None, 1=Success, 2=Failure, 3=Both
```

➡ Requires **SQL Server service restart**.

***

## 4. Extended Events (Best for Ongoing Monitoring)

If you need **who, when, from where, consistently**, Extended Events is the modern approach.

### Relevant events

*   `sqlserver.login_failed`
*   `sqlserver.login`

Example session:

```sql
CREATE EVENT SESSION LoginFailures
ON SERVER
ADD EVENT sqlserver.login_failed
(
    ACTION (sqlserver.client_hostname, sqlserver.client_ip, sqlserver.username)
)
ADD TARGET package0.event_file
(
    SET filename = 'C:\XE\LoginFailures.xel'
);
GO

ALTER EVENT SESSION LoginFailures ON SERVER STATE = START;
```

This avoids error log spam and gives cleaner data.

***

## 5. Common Error 18456 States (Very Useful)

You’ll often see a **state number**, which matters:

| State  | Meaning                             |
| ------ | ----------------------------------- |
| 2, 5   | Invalid username                    |
| 6      | Login disabled                      |
| 7      | Incorrect password                  |
| 8      | Password mismatch                   |
| 11, 12 | Login valid but server access issue |
| 16     | Database access problem             |
| 18     | Password expired                    |

Example from log:

    Error: 18456, Severity: 14, State: 8

This immediately points to a **bad password**.

***

## Recommendation for DBAs

For SQL Server 2019 production systems:

*   ✅ Use **SQL Error Log** for quick troubleshooting
*   ✅ Use **Extended Events** for persistent tracking
*   🚫 Avoid enabling “both failed and successful logins” long‑term (log noise & overhead)

***

If you want, tell me:

*   Are these **SQL Logins or Windows logins?**
*   Single server or **multiple replicas / AGs?**
*   Ad‑hoc troubleshooting or **continuous monitoring/security**?

I can tailor a precise setup.

You can search the **SQL Server error log for a specific login** using the built‑in stored procedures that allow **string filtering**. This is the fastest and safest method.

***

## ✅ Recommended: `xp_readerrorlog`

`xp_readerrorlog` supports **up to two search strings**, which makes it ideal for narrowing to a specific login.

### Basic example

Search the **current error log** for a specific login name:

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed', 'MyLoginName';
```

*   `0` → current error log
*   `1` → SQL Server error log (not SQL Agent)
*   `'Login failed'` → message filter
*   `'MyLoginName'` → login filter

***

## ✅ Search for *any* login activity (not just failures)

If auditing is enabled for successful logins:

```sql
EXEC xp_readerrorlog 0, 1, 'Login', 'MyLoginName';
```

***

## ✅ Search older error logs

SQL Server archives old logs as log **1, 2, 3…**

Example: search the **previous log**

```sql
EXEC xp_readerrorlog 1, 1, 'Login failed', 'MyLoginName';
```

Search multiple logs manually:

```sql
EXEC xp_readerrorlog 0, 1, 'MyLoginName';
EXEC xp_readerrorlog 1, 1, 'MyLoginName';
EXEC xp_readerrorlog 2, 1, 'MyLoginName';
```

***

## ✅ Capture results into a table (for analysis)

This is very useful if you want counts, grouping, or timestamps.

```sql
CREATE TABLE #LoginSearch
(
    LogDate     DATETIME,
    ProcessInfo NVARCHAR(50),
    Text        NVARCHAR(MAX)
);

INSERT INTO #LoginSearch
EXEC xp_readerrorlog 0, 1, 'Login failed', 'MyLoginName';

SELECT *
FROM #LoginSearch
ORDER BY LogDate DESC;
```

***

## ✅ Filter by IP or hostname (if present)

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed', '10.25.14.33';
```

or

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed', 'APP-SERVER-01';
```

***

## ✅ SSMS GUI Method (if you prefer)

1.  **Management**
2.  **SQL Server Logs**
3.  Right‑click **Current**
4.  **View SQL Server Log**
5.  Click **Filter**
6.  Enter value under **Text contains**

This runs the same filtering internally, just with a UI.

***

## ⚠️ Important Notes

*   `xp_readerrorlog` is **read-only** (safe in prod).
*   Login names are **case-insensitive** unless your collation is case‑sensitive.
*   Only **failed logins** are logged by default.
*   Successful logins appear **only if auditing is enabled**.

***

## ✅ Quick troubleshooting combo (DBA favorite)

If users complain of login failures:

```sql
EXEC xp_readerrorlog 0, 1, '18456', 'MyLoginName';
```

This surfaces:

*   timestamp
*   login name
*   failure state (very important)

***

If you want, tell me:

*   **SQL Login or Windows Login?**
*   Do you want to **trend failures over time**?
*   Single instance or **AG / cluster**?

I can give you a one‑query answer tailored exactly to your setup.

Got it — **this is a Windows (Active Directory) login**, not a SQL-authenticated login. That distinction matters, because failures can be logged in **two different places**, and SQL Server doesn’t always have the full story by itself.

Below is the **practical DBA playbook**.

***

## 1️⃣ SQL Server Error Log (What SQL Sees)

Even for **AD-authenticated logins**, SQL Server logs failures as **Error 18456**.

### Search for a specific AD login

```sql
EXEC xp_readerrorlog 0, 1, '18456', 'DOMAIN\UserName';
```

Or without the error number:

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed', 'DOMAIN\UserName';
```

✅ This will tell you:

*   Time of failure
*   AD account name
*   SQL failure **state**
*   Occasionally client info

📌 Typical message:

    Login failed for user 'DOMAIN\UserName'. Reason: Token-based server access validation failed...

***

## 2️⃣ Interpreting Common AD Login Failure States (Critical)

For **Windows logins**, these states are especially useful:

| State | Meaning                                        |
| ----- | ---------------------------------------------- |
| 5     | User not associated with a SQL login           |
| 6     | Login disabled                                 |
| 11    | Valid login, not authorized to connect         |
| 12    | Login valid but default database issue         |
| 16    | Default database unavailable                   |
| 20    | Login failed due to permission or SID mismatch |

💡 **State 11/12/16** usually means:

*   Login exists
*   Authentication succeeded
*   **Authorization failed**

This is very common with AD group changes.

***

## 3️⃣ Windows Event Viewer (What AD Sees)

If authentication fails **before SQL Server fully processes it**, the failure will **only show in Windows logs**, not SQL.

### Where to look

**Event Viewer → Windows Logs → Security**

### Key events

*   **4625** → Failed Windows logon
*   **4624** → Successful Windows logon

Look for:

*   Account Name
*   Domain
*   Logon Type = **3** (network)
*   Source IP / Hostname

This is where you’ll see:

*   Bad password
*   Locked account
*   Expired password
*   AD policy issues

✅ If SQL error log shows **nothing**, check here.

***

## 4️⃣ Common AD + SQL Server Failure Scenarios

### 🔹 User added to AD group but can’t log in

Cause:

*   SQL Server caches group membership in the access token

Fix:

```sql
-- user must disconnect/reconnect
-- or SQL Server service restart (last resort)
```

***

### 🔹 Login exists, but default database is bad

Look for **State 16**

Fix:

```sql
ALTER LOGIN [DOMAIN\UserName] WITH DEFAULT_DATABASE = master;
```

***

### 🔹 SID mismatch (especially after domain migration)

Look for **State 20**

Fix:

```sql
DROP LOGIN [DOMAIN\UserName];
CREATE LOGIN [DOMAIN\UserName] FROM WINDOWS;
```

***

## 5️⃣ If the Login Is an AD Group

Search by **group name**, not user name:

```sql
EXEC xp_readerrorlog 0, 1, 'Login failed', 'DOMAIN\SqlUsersGroup';
```

SQL logs the **security principal**, not the individual user.

***

## 6️⃣ Power Combo Query (SQL-first triage)

When someone reports “I can’t log in”:

```sql
EXEC xp_readerrorlog 0, 1, '18456';
```

Then:

1.  Check **state code**
2.  If unclear → check **Windows Security log (4625)**
3.  Validate:
    ```sql
    SELECT name, type_desc, is_disabled
    FROM sys.server_principals
    WHERE name LIKE 'DOMAIN%';
    ```

***

## 7️⃣ When SQL Logs Are Not Enough (Best Practice)

For environments with frequent AD-related issues:

*   Use **Extended Events** for `login_failed`
*   OR rely on **Windows Security logs** (most authoritative for AD)

SQL Server can only log what it receives — **Active Directory does the actual authentication**.

***

### TL;DR

*   ✅ **SQL Error Log** → authorization problems (post-auth)
*   ✅ **Windows Security Log** → authentication problems (pre-auth)
*   ✅ Search SQL logs using `DOMAIN\UserName` or AD group
*   ✅ State codes tell you *why* it failed

If you want, tell me:

*   Is this a **direct user login or AD group**?
*   Is this happening on **one instance or many**?
*   Standalone SQL or **cluster/AG**?

I can zero in on the root cause quickly.
