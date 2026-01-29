SELECT 
    t.name AS TableName,
    t.create_date
FROM sys.tables t
WHERE t.name = 'YourTableName';
