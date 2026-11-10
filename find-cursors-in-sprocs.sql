/* Find cursors in stored procedures and functions */
SELECT
    s.name AS schema_name,
    o.name AS object_name,
    o.type_desc
FROM sys.objects            AS o
    JOIN sys.schemas        AS s
    ON o.schema_id = s.schema_id
    JOIN sys.sql_modules    AS m
    ON o.object_id = m.object_id
WHERE o.is_ms_shipped = 0
    AND o.type IN ('P', 'FN', 'IF', 'TF') -- Procedures and functions
    AND m.definition LIKE '%CURSOR%'
ORDER BY s.name, o.name;