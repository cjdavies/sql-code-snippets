SELECT
    t.name AS TableName,
    tr.name AS TriggerName,
    tr.is_disabled,
    tr.create_date,
    tr.modify_date
FROM sys.triggers tr
    JOIN sys.tables t
    ON tr.parent_id = t.object_id
ORDER BY t.name, tr.name;
