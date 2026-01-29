Short answer: **Yes — SQL Server system-versioned temporal tables *do* capture the initial row insert**, but with an important detail about *when* the history row is created.

Here’s how it works:

***

## ✅ **What Happens on an INSERT into a Temporal Table**

When you insert a row into a system‑versioned temporal table:

*   SQL Server writes the row into the **current table**.
*   It sets the **SysStartTime** to the insert time and **SysEndTime** to `9999‑12‑31 23:59:59.9999999`.
*   **No row is written to the history table yet**.

➡️ **So the initial insert *is captured as the beginning of the row’s valid period*, but it does *not* create a history row.**

A row only appears in the **history table** after its first update or delete.

***

## ✅ **When a History Row Is Created**

A history row is written **only when**:

### 1️⃣ You UPDATE a row

SQL Server:

*   Moves the current version to the history table (with the previous SysStart/SysEnd)
*   Inserts a new current version with new SysStartTime

### 2️⃣ You DELETE a row

SQL Server:

*   Moves the current version to the history table
*   Removes it from the current table

***

## 📌 Example Timeline

| Action | Current Table                  | History Table                     |
| ------ | ------------------------------ | --------------------------------- |
| INSERT | Row exists with SysStart = now | ❌ None                            |
| UPDATE | Updated row in current         | Previous version moved to history |
| DELETE | Row removed                    | Latest version added to history   |

***

## 🔍 **Why SQL Server Doesn’t Write History on Insert**

Because there *is no previous version* of the row yet. Temporal history tracks **changes over time**, not the initial state.

***

## ✔ So, do temporal tables capture initial inserts?

**Yes — the initial row exists as the first version in the current table.  
No — they do not create a history table entry until the row changes.**

***

#   How this interacts with CDC

Just let me know!

Here’s the clean and **accurate** breakdown of how **SQL Server Temporal Tables** interact with **Change Data Capture (CDC)** — especially important for you since you’re working with SQL Server 2022.

***

# ✅ Do Temporal Tables Work with CDC?

**Yes — you can enable CDC on:**

*   The **current table** of a system‑versioned temporal table
*   The **history table** (manually)
*   Or **both**

But the two features behave very differently.

***

# ⭐ **Key Concept: Temporal Tables Track Row *Versions*, CDC Tracks Row *Changes***

This is the biggest difference:

| Feature             | What It Captures                             | When It Captures                        |
| ------------------- | -------------------------------------------- | --------------------------------------- |
| **Temporal tables** | Full row **versions**                        | Only when the row is UPDATED or DELETED |
| **CDC**             | Row-level **changes (insert/update/delete)** | Immediately for every DML action        |

***

# 🧩 **So What Happens on an INSERT?**

## 📌 **Temporal Table Behavior**

On an insert:

*   The row is written to the **current table**
*   **No history row is created**

Because there’s no “previous version” yet.

## 📌 **CDC Behavior**

CDC *does* record the insert:

*   Writes an **`__$operation = 2` (insert)** entry into the CDC change table
*   Logs the committed row values

➡️ **CDC captures initial inserts. Temporal tables do not (in history).**

***

# 🧩 **What Happens on an UPDATE?**

### Temporal:

*   Moves the old version to **history**
*   Writes the new version to **current**

### CDC:

*   Logs either:
    *   **Before + after values** (if `@supports_net_changes = 1`)
    *   Or just the after image

➡️ **Both features capture updates, but in different formats**.

***

# 🧩 **What Happens on a DELETE?**

### Temporal:

*   Moves the last version to the **history table**

### CDC:

*   Logs a **delete operation** with `__$operation = 1`

➡️ Both capture deletes.

***

# 🔍 **So How Do They Work Together?**

Here’s the combined effect:

### ✔ **CDC gives you every change event**

— granular, event-based auditing

### ✔ **Temporal gives you the complete row-state timeline**

— what the data *looked like* at any point in time

They are fully compatible.

**Most teams use:**

*   **CDC for ETL, auditing, downstream replication**
*   **Temporal for point‑in‑time queries and tracking business-state changes**

***

# 🔥 Example: Combined Behavior Summary

| DML Action | Temporal Table (History) | CDC Capture |
| ---------- | ------------------------ | ----------- |
| **INSERT** | ❌ No history row         | ✅ Yes       |
| **UPDATE** | ✅ Old version saved      | ✅ Yes       |
| **DELETE** | ✅ Old version saved      | ✅ Yes       |

***

# 🏗 If You Enable CDC on the *History Table* Too

You can — but it’s rarely necessary.

If you do:

*   Every time temporal moves a row into history, CDC logs it as an **insert**
*   Can be noisy
*   But useful if downstream systems must mirror the full row‑version history

***

# 🧠 Which Should You Use for What?

| Goal                                               | Use CDC? | Use Temporal? |
| -------------------------------------------------- | -------- | ------------- |
| Point‑in‑time querying (“state as of 2 weeks ago”) | ❌        | ✔             |
| ETL to a data lake / incremental loads             | ✔        | ❌             |
| Auditing exactly *who* changed what                | ✔        | ❌             |
| Automatic history tracking                         | ❌        | ✔             |
| High performance operational logging               | ✔        | ❌             |
| Regulatory “data versioning” requirements          | ❌        | ✔             |

***