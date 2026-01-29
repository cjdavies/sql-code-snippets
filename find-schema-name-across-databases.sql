-- Search for a schema name across all databases

DECLARE @DatabaseName NVARCHAR(255)
DECLARE @Query        NVARCHAR(MAX)
DECLARE @SchemaName   NVARCHAR(255) = 'YourSchemaName' -- Schema name to look for

-- Table to store results
DROP TABLE IF EXISTS #MyResults
CREATE TABLE #MyResults (DatabaseName NVARCHAR(255), SchemaName NVARCHAR(255), SchemaOwner NVARCHAR(255))

DECLARE db_cursor CURSOR FOR 
SELECT name 
  FROM sys.databases 
 WHERE state = 0                        -- Only select databases that are online
   AND database_id BETWEEN 6 AND 16383  -- Skip system databases
   AND name NOT IN ('DEID', 'DMR', 'AGconfig');

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @DatabaseName  

WHILE @@FETCH_STATUS = 0  
BEGIN  
    SET @Query = '
        USE [' + @DatabaseName + '];
        INSERT INTO #MyResults (DatabaseName, SchemaName, SchemaOwner)
        SELECT ''' + @DatabaseName + ''' AS DatabaseName, SCHEMA_NAME, SCHEMA_OWNER
        FROM INFORMATION_SCHEMA.SCHEMATA
        WHERE SCHEMA_NAME = ''' + @SchemaName + '''
        ORDER BY SCHEMA_NAME, SCHEMA_OWNER;'

    EXEC sp_executesql @Query

    FETCH NEXT FROM db_cursor INTO @DatabaseName  
END 

CLOSE db_cursor  
DEALLOCATE db_cursor

-- Display results
SELECT * FROM #MyResults
DROP TABLE #MyResults