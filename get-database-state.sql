SELECT 
    [name]       AS DatabaseName,
    [state_desc] AS DatabaseState
FROM 
    sys.databases;

/*
BEGIN
SET NOCOUNT ON
DECLARE @env2    VARCHAR(50) = (SELECT UPPER( Convert(VARCHAR(50),(Select ServerProperty('Servername')))));
DECLARE @day     VARCHAR(50) = FORMAT (getdate(), 'dddd, MMMM, dd, yyyy');
DECLARE @clk     VARCHAR(50) = FORMAT (getdate(), 'hh:mm:ss tt') ;
DECLARE @usr     VARCHAR(100) = (select suser_name());
DECLARE @env1    VARCHAR(25) = (SELECT UPPER(CAST(value AS VARCHAR(25))) 
    FROM [master].[sys].fn_listextendedproperty('environment', default, default, default, default, default, default));
DECLARE @mydb    VARCHAR(50) = (Select DB_Name());
DECLARE @dbstate VARCHAR(50) = (SELECT CONVERT(VARCHAR(128), (SELECT DATABASEPROPERTYEX ( @mydb , 'Updateability' ))) )

PRINT 'The user ' + @usr + ' has run a query on the [' + @mydb + '] database in the **' + @env1 +  ' ENVIRONMENT**' ;
PRINT 'on SQL Instance: ' + @env2 + ' where the db [' + @mydb + '] is in [' + @DBState + '] mode. ';
PRINT 'It is currently ' + @clk + ' on ' + @day ;
Print ' ';
Print ' ';
END;
GO
*/

/*
BEGIN
DECLARE @mydb0 VARCHAR(25) = (Select DB_NAME())
DECLARE @usr VARCHAR(100) = (select suser_name());
SELECT GETDATE() AS [Query Execution Date/Time],
       @usr as [Query run by user],
       UPPER(CONVERT(VARCHAR(50),(SELECT SERVERPROPERTY('Servername')))) AS [Query Executed on SQL Instance],
	   (Select '[' + @mydb0 + ']') AS [in Database],
       DATABASEPROPERTYEX(@mydb0, 'UPDATEABILITY') AS [where DB Status is];
END;
*/