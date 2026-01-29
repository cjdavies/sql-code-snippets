DECLARE @sql NVARCHAR(MAX) = N'';

SELECT @sql += 
    'ALTER TABLE [' + sch.name + '].[' + t.name + '] DROP CONSTRAINT [' + chk.name + '];' + CHAR(13)
FROM sys.check_constraints chk
JOIN sys.tables t ON chk.parent_object_id = t.object_id
JOIN sys.schemas sch ON t.schema_id = sch.schema_id;

EXEC sp_executesql @sql;
