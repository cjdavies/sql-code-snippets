/* To search for a character string in SQL Server that is followed by any number of spaces and then another string, you can use the LIKE operator with wildcards. Here's an example query: */

SELECT *
FROM YourTable
WHERE YourColumn LIKE '%firstString% %secondString%'

/* In this query:

% is a wildcard that matches any sequence of characters (including no characters).
firstString is the initial string you are searching for.
(space) matches any number of spaces.
secondString is the string that follows the spaces.

If you need to ensure that there are only spaces between the two strings, you can use a regular expression with the PATINDEX function: */

SELECT *
FROM YourTable
WHERE PATINDEX('%firstString%[ ]%secondString%', YourColumn) > 0


/* In this query:

% matches any sequence of characters.
[ ] matches any number of spaces.

These queries will help you find rows where firstString is followed by any number of spaces and then secondString. */

SELECT
    OBJECT_SCHEMA_NAME(o.object_id) AS SchemaName,
    o.name AS ObjectName,
    o.type_desc AS ObjectType,
    m.definition AS ObjectDefinition
FROM sys.sql_modules m
JOIN sys.objects o ON m.object_id = o.object_id
--WHERE m.definition LIKE '%table \#%'  ESCAPE '\'
WHERE PATINDEX('%create%table[ ]#%', m.definition) > 0
  AND o.type IN ('P', 'FN', 'IF', 'TF')
ORDER BY SchemaName, ObjectName;



SELECT [TABLE_SCHEMA], [TABLE_NAME], [VIEW_DEFINITION]
FROM [INFORMATION_SCHEMA].[VIEWS]
WHERE VIEW_DEFINITION LIKE '%select \*%' ESCAPE '\'
--WHERE PATINDEX('%select[ ]*%', VIEW_DEFINITION) > 0
ORDER BY [TABLE_SCHEMA], [TABLE_NAME];
