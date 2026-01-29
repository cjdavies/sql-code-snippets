WITH ModuleLines AS (
    SELECT 
        object_id,
        definition,
        ROW_NUMBER() OVER (PARTITION BY object_id ORDER BY (SELECT NULL)) AS line_number,
        LTRIM(RTRIM(value)) AS line
    FROM 
        sys.sql_modules
    CROSS APPLY 
        STRING_SPLIT(definition, CHAR(13))
    WHERE definition LIKE '%select \*%' ESCAPE '\'
)
SELECT
    OBJECT_SCHEMA_NAME(m.object_id) AS SchemaName,
    OBJECT_NAME(m.object_id) AS ObjectName,
    line_number,
    line
FROM 
    ModuleLines m
JOIN sys.objects o ON m.object_id = o.object_id
WHERE o.type IN ('P', 'FN', 'IF', 'TF')
ORDER BY SchemaName, ObjectName, line_number;



/* This returns modules that contain 'select *', but I have not yet figured out how to find variations on it, such as 'select p.*' or with varying numbers of spaces after the select. */
SELECT 
    OBJECT_SCHEMA_NAME(o.object_id) AS SchemaName,
    o.name AS ObjectName,
    o.type_desc AS ObjectType,
    m.definition AS ObjectDefinition
FROM sys.sql_modules m
JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition LIKE '%select \*%' ESCAPE '\'
  AND o.type IN ('P', 'FN', 'IF', 'TF')
ORDER BY SchemaName, ObjectName;


/* This returns modules that contain 'select .*' where a string or character immediately precedes the period. */
WITH proc_defs AS (
    SELECT 
        OBJECT_SCHEMA_NAME(o.object_id) AS SchemaName,
        o.name AS ObjectName,
        o.type_desc AS ObjectType,
        REPLACE(m.definition, '.*', '.ASTERISK') AS ObjectDefinition
    FROM sys.sql_modules m
    JOIN sys.objects o ON m.object_id = o.object_id
    WHERE o.type IN ('P')
)
SELECT 
    SchemaName
   ,ObjectName
   ,ObjectType
   --,ObjectDefinition
FROM proc_defs
WHERE ObjectDefinition LIKE '%select%ASTERISK%'
ORDER BY SchemaName, ObjectName;