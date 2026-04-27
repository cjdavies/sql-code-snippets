SELECT
    DB_Name()                AS DatabaseName 
  , OBJECT_NAME([object_id]) AS TableName
  , [name]                   AS ColumnName
  , column_id                AS ColumnID
FROM sys.columns
WHERE OBJECTPROPERTY([object_id], 'IsUserTable') = 1
ORDER BY TableName, ColumnName;
--ORDER BY [name], OBJECT_NAME([object_id]);