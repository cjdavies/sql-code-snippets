/* Script to List All Triggers That Use Cursors
   This returns every trigger whose definition contains cursor-related statements (DECLARE … CURSOR, OPEN, FETCH, CLOSE, DEALLOCATE).
*/
SELECT
    s.name AS SchemaName,
    o.name AS TriggerName,
    m.definition AS TriggerDefinition
FROM sys.sql_modules AS m
JOIN sys.objects AS o 
    ON m.object_id = o.object_id
JOIN sys.schemas AS s 
    ON o.schema_id = s.schema_id
WHERE o.type = 'TR'
  AND (
         m.definition LIKE '%CURSOR%'
      OR m.definition LIKE '%DECLARE%CURSOR%'
      OR m.definition LIKE '%OPEN%CURSOR%'
      OR m.definition LIKE '%FETCH%CURSOR%'
      OR m.definition LIKE '%CLOSE%CURSOR%'
      OR m.definition LIKE '%DEALLOCATE%CURSOR%'
  )
ORDER BY s.name, o.name;

/* Script to Count Cursor Usage Across All Triggers
   This returns a count of how many triggers contain cursor keywords — plus how many times the word appears.
*/
SELECT
    COUNT(*) AS TriggersWithCursorUsage,
    SUM( (LEN(m.definition) - LEN(REPLACE(LOWER(m.definition), 'cursor', ''))) / 6 ) 
        AS TotalCursorKeywordOccurrences
FROM sys.sql_modules m
JOIN sys.objects o 
    ON m.object_id = o.object_id
WHERE o.type = 'TR'
  AND LOWER(m.definition) LIKE '%cursor%';

/* Script to Find Nested Cursor Usage (Cursor Inside Cursor)
   A "nested cursor" means the trigger defines or opens a cursor inside another cursor loop — not uncommon in legacy systems.
   This script searches for patterns where cursor blocks are inside other cursor blocks:
*/
SELECT
    s.name AS SchemaName,
    o.name AS TriggerName,
    m.definition AS TriggerDefinition
FROM sys.sql_modules m
JOIN sys.objects o
    ON m.object_id = o.object_id
JOIN sys.schemas s
    ON o.schema_id = s.schema_id
WHERE o.type = 'TR'
  AND (
        -- first cursor
        m.definition LIKE '%DECLARE%CURSOR%' 
        AND
        -- another cursor later in the code
        (
            m.definition LIKE '%DECLARE%CURSOR%DECLARE%CURSOR%'
         OR m.definition LIKE '%DECLARE%CURSOR%OPEN%CURSOR%'
         OR m.definition LIKE '%OPEN%CURSOR%DECLARE%CURSOR%'
         OR m.definition LIKE '%OPEN%CURSOR%OPEN%CURSOR%'
        )
      )
ORDER BY s.name, o.name;
