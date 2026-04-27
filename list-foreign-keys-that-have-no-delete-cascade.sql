/* Lists every FK that does NOT have ON DELETE CASCADE */
SELECT
    fk.name                                     AS ForeignKeyName,
    OBJECT_SCHEMA_NAME(fk.parent_object_id)     AS ChildSchema,
    OBJECT_NAME(fk.parent_object_id)            AS ChildTable,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ParentSchema,
    OBJECT_NAME(fk.referenced_object_id)        AS ParentTable,
    fk.delete_referential_action_desc           AS OnDelete,
    fk.update_referential_action_desc           AS OnUpdate,
    fk.is_disabled,
    fk.is_not_trusted,
    fk.is_not_for_replication
FROM sys.foreign_keys AS fk
WHERE fk.delete_referential_action_desc <> 'CASCADE'
ORDER BY ChildSchema, ChildTable, ForeignKeyName;
