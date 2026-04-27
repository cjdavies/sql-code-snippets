DECLARE @SearchString NVARCHAR(255) = UPPER('your_search_string_here');

SELECT
    SCHEMA_NAME(o.schema_id) AS SchemaName,
    OBJECT_NAME(m.object_id) AS ProcedureName,
    c.occurrences            AS OccurrenceCount
FROM sys.sql_modules m
    INNER JOIN sys.objects o
    ON m.object_id = o.object_id
CROSS APPLY (
    SELECT occurrences = (
        LEN(UPPER(m.definition)) - LEN(REPLACE(UPPER(m.definition), @SearchString, ''))
    ) / NULLIF(LEN(@SearchString), 0)
) c
WHERE o.type = 'P' -- Stored Procedures only
    AND UPPER(m.definition) LIKE '%' + @SearchString + '%'
    AND c.occurrences > 0
ORDER BY OccurrenceCount DESC, ProcedureName ASC;
