-- Per-table storage (MB), including indexes
WITH au AS (
    SELECT
        s.name  AS schema_name,
        t.name  AS table_name,
        i.index_id,
        i.name  AS index_name,
        au.type_desc AS alloc_type,            -- IN_ROW_DATA / LOB_DATA / ROW_OVERFLOW_DATA
        SUM(au.total_pages) AS total_pages,    -- reserved pages
        SUM(au.used_pages)  AS used_pages,     -- used pages
        SUM(au.data_pages)  AS data_pages,     -- leaf data pages (rowstore)
        MAX(p.rows)         AS row_count
    FROM sys.tables AS t
    JOIN sys.schemas AS s
      ON s.schema_id = t.schema_id
    JOIN sys.indexes AS i
      ON i.object_id = t.object_id
    JOIN sys.partitions AS p
      ON p.object_id = i.object_id
     AND p.index_id  = i.index_id
    JOIN sys.allocation_units AS au
      ON au.container_id =
         CASE
            -- Rowstore: IN_ROW_DATA(1)/ROW_OVERFLOW_DATA(3) use hobt_id; LOB_DATA(2) uses hobt_id too.
            WHEN au.type IN (1, 3) THEN p.hobt_id
            ELSE p.partition_id -- defensive; covers internal/columnstore mappings
         END
    WHERE t.is_ms_shipped = 0 -- user tables only
    GROUP BY
        s.name, t.name, i.index_id, i.name, au.type_desc
)
SELECT
    schema_name,
    table_name,
    -- Reserved/Used totals in MB (8 KB pages)
    CAST(SUM(total_pages) * 8.0 / 1024 AS DECIMAL(18,2)) AS reserved_mb,
    CAST(SUM(used_pages)  * 8.0 / 1024 AS DECIMAL(18,2)) AS used_mb,

    -- Split data (heap/clustered) vs index (nonclustered, columnstore, etc.)
    CAST(SUM(CASE WHEN index_id IN (0,1) THEN total_pages ELSE 0 END) * 8.0 / 1024 AS DECIMAL(18,2)) AS data_mb,
    CAST(SUM(CASE WHEN index_id NOT IN (0,1) THEN total_pages ELSE 0 END) * 8.0 / 1024 AS DECIMAL(18,2)) AS index_mb,

    -- Row count (best-effort from partitions)
    MAX(row_count) AS [rows]
FROM au
GROUP BY schema_name, table_name
ORDER BY reserved_mb DESC;