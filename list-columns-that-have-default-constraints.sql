SELECT 
    t.name AS TableName,
    c.name AS ColumnName,
    dc.name AS DefaultConstraintName,
    dc.definition AS DefaultValue
FROM sys.tables t
JOIN sys.columns c              ON t.object_id = c.object_id
JOIN sys.default_constraints dc ON c.default_object_id = dc.object_id
ORDER BY t.name, c.name;
