In Microsoft SQL Server, you can identify which databases contain a particular schema by querying the system catalog views across all databases. Here are several approaches:

### Using sp_MSforeachdb (Quick Method)
EXEC sp_MSforeachdb 'USE [?]; 
IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = ''YourSchemaName'')
    PRINT ''Database: '' + DB_NAME() + '' contains the schema'''

### Using Dynamic SQL (More Robust)
DECLARE @SchemaName NVARCHAR(128) = 'cdc';
DECLARE @SQL NVARCHAR(MAX) = '';

SELECT @SQL = @SQL + 
    'IF EXISTS (SELECT 1 FROM ' + QUOTENAME(name) + '.sys.schemas WHERE name = ''' + @SchemaName + ''')
        SELECT ''' + name + ''' AS DatabaseName;
    '
  FROM sys.databases
 WHERE state_desc = 'ONLINE' 
   AND database_id BETWEEN 6 AND 16383
   AND name NOT IN ('DEID', 'DMR');

EXEC sp_executesql @SQL;

### Using a Cursor (Most Flexible)
DECLARE @DatabaseName NVARCHAR(128);
DECLARE @SchemaName NVARCHAR(128) = 'YourSchemaName';
DECLARE @SQL NVARCHAR(MAX);

CREATE TABLE #Results (DatabaseName NVARCHAR(128));

DECLARE db_cursor CURSOR FOR
SELECT name 
FROM sys.databases 
WHERE state_desc = 'ONLINE'
    AND name NOT IN ('tempdb');

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DatabaseName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'USE ' + QUOTENAME(@DatabaseName) + ';
        IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = ''' + @SchemaName + ''')
            INSERT INTO #Results VALUES (''' + @DatabaseName + ''')';
    
    EXEC sp_executesql @SQL;
    FETCH NEXT FROM db_cursor INTO @DatabaseName;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;

SELECT * FROM #Results;
DROP TABLE #Results;

Key Points
•	Replace 'YourSchemaName' with the actual schema name you're looking for
•	These queries require appropriate permissions to access each database
•	You can filter sys.databases to exclude system databases or offline databases as needed
•	The dynamic SQL approach is generally preferred over sp_MSforeachdb as it's more reliable and officially supported
The second method (dynamic SQL) is usually the best balance of simplicity and reliability.
