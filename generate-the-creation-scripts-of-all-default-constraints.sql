SELECT 
    'ALTER TABLE [' + sch.name + '].[' + t.name + '] ADD CONSTRAINT [' + dc.name + '] DEFAULT ' + 
    dc.definition + ' FOR [' + c.name + '];' AS DefaultConstraintSQL
FROM sys.default_constraints dc
JOIN sys.columns c ON dc.parent_object_id = c.object_id AND dc.parent_column_id = c.column_id
JOIN sys.tables t ON dc.parent_object_id = t.object_id
JOIN sys.schemas sch ON t.schema_id = sch.schema_id;
