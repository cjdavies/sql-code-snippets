/* This script finds user sessions that are idle, blocking others, or holding open transactions, while avoiding interference with production workloads. */

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET DEADLOCK_PRIORITY LOW;
GO

WITH session_data AS
(
    SELECT
        s.session_id,
        s.login_time,
        s.last_request_start_time,
        s.status,
        s.login_name,
        s.host_name,
        s.program_name,
        s.open_transaction_count,
        r.database_id,  -- Use database_id ONLY from dm_exec_requests
        r.blocking_session_id,
        r.wait_type,
        r.wait_time,
        r.wait_resource,
        r.sql_handle
    FROM sys.dm_exec_sessions s
    LEFT JOIN sys.dm_exec_requests r
        ON s.session_id = r.session_id
    WHERE s.is_user_process = 1
)
SELECT
    sd.session_id AS spid,
    sd.open_transaction_count AS open_tran,
    sd.login_time,

    -- Idle time in minutes
    DATEDIFF(MINUTE, sd.last_request_start_time, GETDATE()) AS idle_minutes,

    --Database context (active OR last executed)
    DB_NAME(COALESCE(sd.database_id, txt.dbid)) AS database_name,
    sd.status,
    sd.login_name,
    sd.host_name,
    sd.program_name,

    -- Blocking & wait details
    sd.blocking_session_id,
    sd.wait_type,
    sd.wait_time,
    sd.wait_resource,

    -- SQL text (current or last)
    txt.text AS sql_text
FROM session_data sd
OUTER APPLY sys.dm_exec_sql_text(sd.sql_handle) txt
WHERE
(
        -- All sleeping user sessions
        sd.status = 'sleeping'

        -- Sessions blocking others
     OR sd.session_id IN
        (
            SELECT DISTINCT blocking_session_id
            FROM sys.dm_exec_requests
            WHERE blocking_session_id > 0
        )

        -- Sleeping sessions with open transactions (classic blockers)
     OR (sd.status = 'sleeping' AND sd.open_transaction_count > 0)
)
    --AND COALESCE(sd.database_id, txt.dbid) = DB_ID('YourDB')
ORDER BY idle_minutes DESC, sd.login_time DESC
;

/*

## ✅ What This Version Adds

In addition to the original behavior, it now includes:

*   ✅ **Wait information** (`wait_type`, `wait_time`, `wait_resource`)
*   ✅ **Accurate blocking detection**
*   ✅ **Idle duration (minutes)**
*   ✅ **Transaction context**
*   ✅ **Current SQL for active requests**
*   ✅ **Last SQL for idle sessions**
*   ✅ **User-session–only filtering**
*   ✅ **Modern, supported DMVs only**

***

## Fully Enhanced Modern DMV Query

## 🔍 Explanation of Enhancements

### 1. **Wait Diagnostics**

```sql
wait_type,
wait_time,
wait_resource
```

These immediately tell you:

*   *Why* a session is stalled
*   Whether the wait is lock-based, I/O, memory, or CPU related
*   Which resource is involved (page, key, object)

This is essential for diagnosing **blocking vs resource pressure**.

***

### 2. **Idle Time (Minutes)**

```sql
DATEDIFF(MINUTE, sd.last_request_start_time, GETDATE()) AS idle_minutes
```

Helps answer:

*   “How long has this session been doing nothing?”
*   “Which sleeping session has held a transaction open the longest?”

Very useful for:

*   Connection pool leaks
*   App bugs
*   Forgotten SSMS windows

***

### 3. **Blocking Session Detection (Correct Way)**

```sql
blocking_session_id
```

This replaces the old `blocked` column and:

*   Reflects **real-time blocking chains**
*   Avoids legacy timing inconsistencies
*   Allows easy expansion into full blocking trees

***

### 4. **OUTER APPLY for SQL Text**

```sql
OUTER APPLY sys.dm_exec_sql_text(sd.sql_handle)
```

Why `OUTER APPLY` matters:

*   Sleeping sessions often have **NULL sql\_handle**
*   You still want to see:
    *   Who owns the transaction
    *   What was last executed

This preserves the full result set.

***

### 5. **User Sessions Only**

```sql
WHERE s.is_user_process = 1
```

Cleaner and safer than:

```sql
spid > 50
```

This:

*   Excludes system tasks
*   Handles future changes in SPID usage
*   Is the officially supported approach

***

## 🚦 Common Variations You Might Want

### Only show **problem sessions**

```sql
AND (sd.open_transaction_count > 0 OR sd.blocking_session_id > 0)
```

### Only show **long-idle transactions**

```sql
AND sd.open_transaction_count > 0
AND DATEDIFF(MINUTE, sd.last_request_start_time, GETDATE()) > 10
```

### Order by worst offenders

```sql
ORDER BY
    sd.open_transaction_count DESC,
    idle_minutes DESC,
    sd.login_time DESC;
```

***

## 🧠 Practical Use Cases

This query is ideal for:

*   Production blocking incidents
*   “Why is my deploy hung?”
*   Log file won’t truncate
*   Emergency troubleshooting without side effects
*   Identifying misbehaving applications or SSMS users

***

## One‑sentence takeaway

> This enhanced DMV-based version is a **production-safe, future-proof replacement** for the original `sys.sysprocesses` script, with superior visibility into blocking, waits, and idle transactions.

In SQL Server, **`wait_type`** tells you **what a session (or request) is waiting on right now**. It is one of the **most important diagnostic signals** when troubleshooting blocking, slowness, or resource contention.

Below is a **practical, DBA‑oriented explanation**: what waits mean, why they occur, and when to worry.

***

## 1. What `wait_type` Represents

A **wait** occurs when a task **cannot proceed immediately** and SQL Server puts it into a waiting state until a required resource becomes available.

Examples of resources:

*   Locks
*   CPU
*   Disk I/O
*   Memory
*   Network
*   Parallel threads
*   Latches (internal engine structures)

If `wait_type` is:

*   **NULL** → session is running or sleeping with no active wait
*   **Non‑NULL** → session is currently blocked by something specific

***

## 2. The Most Important Wait Types (By Category)

Below are the **waits you will see most often in real systems**, especially when using your diagnostic query.

***

## 3. Lock & Blocking-Related Waits (Most Common in OLTP)

These indicate **blocking due to locks**.

### 🔒 `LCK_M_*` (Lock waits)

Examples:

*   `LCK_M_S` – waiting for a **shared lock**
*   `LCK_M_X` – waiting for an **exclusive lock**
*   `LCK_M_U` – waiting for an \*\*update lock\`

**What it means**

*   Another session holds a conflicting lock
*   Your query is blocked

**Common causes**

*   Sleeping sessions with open transactions
*   Long-running transactions
*   Missing indexes causing large scans
*   Serializable isolation level

✅ **Action**

*   Identify blocking session (`blocking_session_id`)
*   Check open transactions
*   Fix transaction scope or indexing

***

## 4. Transaction & Log Waits

### 🧾 `WRITELOG`

**Meaning**

*   Waiting for transaction log flush to disk

**Usually normal**, but problematic if excessive.

**Common causes**

*   Slow disk for log file
*   Very high transaction rate
*   Synchronous AG replicas

✅ **Action**

*   Check log disk latency
*   Separate log files to fast storage

***

### 🧾 `LOGBUFFER`

**Meaning**

*   Waiting for free space in log buffer

**Usually appears alongside `WRITELOG`.**

***

## 5. I/O-Related Waits

### 💽 `PAGEIOLATCH_SH / EX / UP`

**Meaning**

*   Waiting for **data or index pages to be read from disk into memory**

| Type | Meaning |
| ---- | ------- |
| `SH` | Read    |
| `EX` | Write   |
| `UP` | Update  |

**Common causes**

*   Slow storage
*   Insufficient memory
*   Large table/index scans

✅ **Action**

*   Check disk latency
*   Improve indexing
*   Add RAM or tune queries

***

### 💽 `IO_COMPLETION`

**Meaning**

*   SQL Server is waiting for an I/O request to finish

Usually indicates **storage subsystem pressure**.

***

## 6. CPU & Parallelism Waits

### 🧠 `SOS_SCHEDULER_YIELD`

**Meaning**

*   The worker voluntarily yielded CPU to let others run

⚠️ **Often misunderstood**

**Indicates**

*   CPU pressure
*   Many runnable tasks competing for CPU

✅ **Action**

*   Check CPU usage
*   Reduce parallelism
*   Optimize expensive queries

***

### 🧵 `CXPACKET` / `CXCONSUMER`

**Meaning**

*   Parallel query coordination waits

**Healthy in moderation**

| Wait         | Meaning                     |
| ------------ | --------------------------- |
| `CXPACKET`   | One thread waits for others |
| `CXCONSUMER` | Normal consumer thread wait |

✅ **Action**

*   Investigate only if excessive
*   Review `MAXDOP` and query plans

***

## 7. Memory-Related Waits

### 🧠 `RESOURCE_SEMAPHORE`

**Meaning**

*   Query is waiting for **memory grant**

**Common causes**

*   Large sorts or hashes
*   Many concurrent large queries
*   Insufficient RAM

✅ **Action**

*   Tune queries
*   Reduce memory grants
*   Avoid oversized hash joins

***

### 🧠 `CMEMTHREAD`

**Meaning**

*   Contention on internal memory structures

Seen on **very busy systems**.

***

## 8. Network & Client Waits

### 🌐 `ASYNC_NETWORK_IO`

**Meaning**

*   SQL Server sent data, waiting for the **client to consume it**

**Important insight**

*   SQL Server is NOT the bottleneck
*   Client or network is slow

✅ **Action**

*   Check application code
*   Reduce row counts
*   Ensure client fetches results promptly

***

## 9. Idle / Benign Waits (Usually Safe to Ignore)

These are expected and **not performance problems**.

| Wait Type                | Meaning                  |
| ------------------------ | ------------------------ |
| `SLEEP_TASK`             | Idle task                |
| `BROKER_RECEIVE_WAITFOR` | Service Broker wait      |
| `XE_TIMER_EVENT`         | Extended Events timer    |
| `WAITFOR`                | Explicit WAITFOR command |
| `LAZYWRITER_SLEEP`       | Background housekeeping  |

✅ These **do not indicate bottlenecks**

***

## 10. How to Interpret `wait_type` Correctly

### ✅ Good practice

*   Look at **patterns**, not single rows
*   Correlate with:
    *   `blocking_session_id`
    *   `wait_time`
    *   `open_transaction_count`
    *   Query text

### ❌ Common mistakes

*   Chasing benign waits
*   Overreacting to `CXPACKET`
*   Ignoring blockers and open transactions

***

## 11. How This Ties Back to Your Query

In your enhanced query:

```sql
wait_type,
wait_time,
wait_resource
```

You can immediately answer:

*   Is this blocked? → `LCK_*`
*   CPU pressure? → `SOS_SCHEDULER_YIELD`
*   Storage issue? → `PAGEIOLATCH_*`
*   Client slow? → `ASYNC_NETWORK_IO`

This turns the query from **“who is connected?”** into **“why are they slow?”**

***

## Quick Mental Cheat Sheet

| Wait Category         | Usually Means  |
| --------------------- | -------------- |
| `LCK_*`               | Blocking       |
| `PAGEIOLATCH_*`       | Disk or memory |
| `WRITELOG`            | Log I/O        |
| `SOS_SCHEDULER_YIELD` | CPU            |
| `CXPACKET`            | Parallelism    |
| `RESOURCE_SEMAPHORE`  | Memory         |
| `ASYNC_NETWORK_IO`    | Client/network |
| `SLEEP_*`             | Idle           |

***

## One‑sentence takeaway

> `wait_type` tells you **what resource a session is missing**, and when read in context (blocking, time, SQL text), it’s the fastest way to pinpoint the real bottleneck in SQL Server.
*/