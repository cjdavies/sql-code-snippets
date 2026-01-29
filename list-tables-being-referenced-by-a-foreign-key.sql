SELECT
    fk.name AS ForeignKeyName,
    sp.name AS ParentSchema,
    tp.name AS ParentTable,
    cp.name AS ParentColumn,
    sr.name AS ReferencedSchema,
    tr.name AS ReferencedTable,
    cr.name AS ReferencedColumn
FROM sys.foreign_keys fk
    JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    JOIN sys.tables tp               ON fkc.parent_object_id = tp.object_id
    JOIN sys.columns cp              ON fkc.parent_object_id = cp.object_id
         AND fkc.parent_column_id = cp.column_id
    JOIN sys.tables tr               ON fkc.referenced_object_id = tr.object_id
    JOIN sys.columns cr              ON fkc.referenced_object_id = cr.object_id
         AND fkc.referenced_column_id = cr.column_id
    JOIN sys.schemas sp              ON tp.schema_id = sp.schema_id
    JOIN sys.schemas sr              ON tr.schema_id = sr.schema_id
WHERE tr.name LIKE 'Integration%'
ORDER BY ParentSchema, ParentTable, ForeignKeyName;