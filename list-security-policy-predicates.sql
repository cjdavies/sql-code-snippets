/* List all security policy predicates */

SELECT
    s1.name                  AS SecurityPolicySchema,
    sp.name                  AS SecurityPolicy,
    spp.predicate_definition AS PredicateDefinition,
    spp.predicate_type_desc  AS PredicateType,
    spp.operation_desc       AS OperationDesc,
    s2.name                  AS TableSchema,
    t.name                   AS TableName
FROM 
    sys.security_policies AS sp
JOIN 
    sys.security_predicates AS spp ON sp.object_id = spp.object_id
JOIN 
    sys.tables AS t ON spp.target_object_id = t.object_id
JOIN
    sys.schemas AS s1 ON sp.schema_id = s1.schema_id
JOIN 
    sys.schemas AS s2 ON t.schema_id = s2.schema_id
ORDER BY SecurityPolicySchema ASC,
         SecurityPolicy ASC,
         PredicateType DESC,
         OperationDesc ASC;
