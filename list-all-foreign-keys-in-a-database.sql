SELECT
    schema_name (pk_tab.schema_id) + '.' + pk_tab.name AS target_table_name,
    fk.name AS fk_constraint_name,
    schema_name (fk_tab.schema_id) + '.' + fk_tab.name AS foreign_table_name
FROM
    sys.foreign_keys fk
    INNER JOIN sys.tables fk_tab ON fk_tab.object_id = fk.parent_object_id
    INNER JOIN sys.tables pk_tab ON pk_tab.object_id = fk.referenced_object_id
    INNER JOIN sys.foreign_key_columns fk_cols ON fk_cols.constraint_object_id = fk.object_id
ORDER BY
    target_table_name,
    foreign_table_name,
    fk_constraint_name;