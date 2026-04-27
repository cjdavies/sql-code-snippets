SELECT
   OBJECT_NAME(object_id) AS ProcedureName,
   OBJECT_DEFINITION(object_id) AS ScriptCode
FROM
   sys.procedures;

EXEC sp_helptext 'YourStoredProcedureName';

SELECT
   ROUTINE_DEFINITION
FROM
   INFORMATION_SCHEMA.ROUTINES
WHERE
   ROUTINE_NAME = 'YourStoredProcedureName';


-- Find stored procedures with more than one JOIN
SELECT 
    p.name AS ProcedureName,
    SCHEMA_NAME(p.schema_id) AS SchemaName,
    m.definition AS ProcedureDefinition,
    (LEN(UPPER(m.definition)) - LEN(REPLACE(UPPER(m.definition), 'JOIN', ''))) / LEN('JOIN') AS JoinCount
FROM 
    sys.procedures p
JOIN 
    sys.sql_modules m ON p.object_id = m.object_id
WHERE 
    (LEN(UPPER(m.definition)) - LEN(REPLACE(UPPER(m.definition), 'JOIN', ''))) / LEN('JOIN') > 1
ORDER BY 
    JoinCount DESC, ProcedureName;
