/* This query joins the sys.security_policies, sys.security_predicates, and sys.tables catalog views to retrieve the names of the security policies and the tables they apply to. This should give you a clear mapping of security policies to their respective tables.
*/
SELECT DISTINCT
    s1.name AS PolicySchemaName,
    sp.name AS SecurityPolicyName,
    s2.name AS TableSchemaName,
    t.name AS TableName
FROM 
    sys.security_policies sp
JOIN
    sys.schemas s1 ON sp.schema_id = s1.schema_id
JOIN 
    sys.security_predicates spr ON sp.object_id = spr.object_id
JOIN 
    sys.tables t ON spr.target_object_id = t.object_id
JOIN
    sys.schemas s2 ON t.schema_id = s2.schema_id;
