-- Search for a column name across all databases

DECLARE @DatabaseName NVARCHAR(255)
DECLARE @Query NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(255) = 'YourColumnName' -- Column name you're looking for

-- Table to store results
CREATE TABLE #MyResults (DatabaseName NVARCHAR(255), SchemaName NVARCHAR(255), TableName NVARCHAR(255))

DECLARE db_cursor CURSOR FOR 
SELECT name 
FROM sys.databases 
WHERE state = 0 -- Only select databases that are online
AND database_id > 4 -- Skip system databases

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @DatabaseName  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    SET @Query = '
        USE [' + @DatabaseName + '];
        INSERT INTO #MyResults (DatabaseName, SchemaName, TableName)
        SELECT ''' + @DatabaseName + ''' AS DatabaseName, TABLE_SCHEMA, TABLE_NAME
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE COLUMN_NAME = ''' + @ColumnName + '''
        ORDER BY TABLE_SCHEMA, TABLE_NAME;'

    EXEC sp_executesql @Query

    FETCH NEXT FROM db_cursor INTO @DatabaseName  
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

-- Display results
SELECT * FROM #MyResults
DROP TABLE #MyResults