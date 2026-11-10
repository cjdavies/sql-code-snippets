/* Below is a **SQL Server 2019–compatible** query that lists **foreign key columns which are not covered by any index** on the referencing (child) table.

It returns:

*   **Schema name**
*   **Table name**
*   **Foreign key column name**

The logic checks whether each foreign key column appears as the **leading (key) column** of any index on the same table, which is the correct and commonly accepted definition of an indexed foreign key.

***

### ✅ Query: Foreign key columns without supporting indexes

```sql
*/
SELECT
    sch.[name]       AS [schema_name],
    tbl.[name]       AS [table_name],
    col.[name]       AS [column_name]
FROM sys.foreign_keys AS fk
    INNER JOIN sys.foreign_key_columns AS fkc
    ON fk.[object_id] = fkc.[constraint_object_id]
    INNER JOIN sys.tables AS tbl
    ON fk.[parent_object_id] = tbl.[object_id]
    INNER JOIN sys.schemas AS sch
    ON tbl.[schema_id] = sch.[schema_id]
    INNER JOIN sys.columns AS col
    ON fkc.[parent_object_id] = col.[object_id]
        AND fkc.[parent_column_id] = col.[column_id]
WHERE NOT EXISTS
(
    SELECT 1
    FROM sys.indexes AS ix
    INNER JOIN sys.index_columns AS ic
    ON ix.[object_id] = ic.[object_id]
        AND ix.[index_id] = ic.[index_id]
    WHERE ix.[object_id] = tbl.[object_id]
        AND ic.[column_id] = col.[column_id]
        AND ic.[key_ordinal] = 1 -- must be the leading column
        AND ix.[is_disabled] = 0
        AND ix.[is_hypothetical] = 0
)
ORDER BY
    sch.[name],
    tbl.[name],
    col.[name];
/*
```

***

### 🔍 Notes & rationale

*   **Why leading column only?**  
    SQL Server can only efficiently seek on an index when the foreign key column is the **first key column**. An index where the FK column appears second or later does *not* adequately support referential integrity operations.

*   **Included columns are ignored**  
    This query correctly excludes indexes where the FK column is merely an `INCLUDE` column.

*   **Disabled and hypothetical indexes excluded**  
    These indexes provide no runtime benefit and are intentionally filtered out.

*   **Covers multi-column foreign keys**  
    Each column in a composite foreign key is evaluated independently, which is typically how indexing recommendations are assessed.

***

### ✅ Typical follow-up (optional)

If you want, I can also:

*   Restrict results to **large tables or high-write workloads**
*   Include **row counts** to prioritize impact

WITH TableStats AS
(
    SELECT
        p.[object_id],
        SUM(p.[row_count]) AS row_count
    FROM sys.dm_db_partition_stats AS p
    WHERE p.[index_id] IN (0, 1) -- heap or clustered index only
    GROUP BY
        p.[object_id]
),
WriteStats AS
(
    SELECT
        ius.[object_id],
        SUM(ius.user_updates) AS write_count
    FROM sys.dm_db_index_usage_stats AS ius
    WHERE ius.database_id = DB_ID()
    GROUP BY
        ius.[object_id]
)
SELECT
    sch.[name]                  AS [schema_name],
    tbl.[name]                  AS [table_name],
    col.[name]                  AS [column_name],
    ts.row_count                AS [row_count],
    ISNULL(ws.write_count, 0)   AS [write_count]
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc
    ON fk.[object_id] = fkc.[constraint_object_id]
INNER JOIN sys.tables AS tbl
    ON fk.[parent_object_id] = tbl.[object_id]
INNER JOIN sys.schemas AS sch
    ON tbl.[schema_id] = sch.[schema_id]
INNER JOIN sys.columns AS col
    ON fkc.[parent_object_id] = col.[object_id]
   AND fkc.[parent_column_id] = col.[column_id]
INNER JOIN TableStats AS ts
    ON tbl.[object_id] = ts.[object_id]
LEFT JOIN WriteStats AS ws
    ON tbl.[object_id] = ws.[object_id]
WHERE NOT EXISTS
(
    SELECT 1
    FROM sys.indexes AS ix
    INNER JOIN sys.index_columns AS ic
        ON ix.[object_id] = ic.[object_id]
       AND ix.[index_id] = ic.[index_id]
    WHERE ix.[object_id] = tbl.[object_id]
      AND ic.[column_id] = col.[column_id]
      AND ic.[key_ordinal] = 1          -- must be leading key
      AND ix.[is_disabled] = 0
      AND ix.[is_hypothetical] = 0
)
AND
(
    ts.row_count >= 100000              -- large table threshold
    OR ISNULL(ws.write_count, 0) >= 10000 -- high-write threshold
)
ORDER BY
    ts.row_count DESC,
    ISNULL(ws.write_count, 0) DESC,
    sch.[name],
    tbl.[name],
    col.[name];
*/