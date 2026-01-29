-- To check if a column is an identity column
SELECT COLUMN_NAME, COLUMNPROPERTY(OBJECT_ID(TABLE_SCHEMA + '.' + TABLE_NAME), COLUMN_NAME, 'IsIdentity') AS IsIdentity
FROM INFORMATION_SCHEMA.COLUMNS


SELECT c.name AS ColumnName, c.is_identity
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
WHERE t.name = 'YourTableName' AND c.is_identity = 1;


EXEC sp_help 'YourTableName';


-- To list all identity columns in the database
SELECT
    t.name AS TableName,
    c.name AS ColumnName,
    s.name AS SchemaName
FROM sys.columns c
JOIN sys.tables t  ON c.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE c.is_identity = 1
ORDER BY s.name, t.name, c.name;
