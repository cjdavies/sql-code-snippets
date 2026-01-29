/* List all triggers in a database.
USE [databasename];
GO
*/
SELECT 
    t.name                  AS TriggerName,
    t.object_id             AS TriggerID,
    s.name                  AS SchemaName,
    o.name                  AS TableOrViewName,
    o.type_desc             AS ObjectType,
    t.type_desc             AS TriggerType,
    t.is_disabled           AS IsDisabled,
    t.is_instead_of_trigger AS IsInsteadOf
FROM 
    sys.triggers t
JOIN 
    sys.objects o ON t.parent_id = o.object_id
JOIN 
    sys.schemas s ON o.schema_id = s.schema_id
WHERE t.is_ms_shipped = 0
ORDER BY 
    SchemaName, TableOrViewName, TriggerName;
