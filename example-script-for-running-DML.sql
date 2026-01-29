/* Example script for running DML in Prod. Note double quotation marks in printed DML. */
BEGIN
SET NOCOUNT ON;
DECLARE @env2 VARCHAR(50)  = UPPER(CAST((SELECT ServerProperty('Servername')) AS VARCHAR(50)));
DECLARE @day  VARCHAR(50)  = FORMAT (GETDATE(), 'dddd, MMMM, dd, yyyy');
DECLARE @clk  VARCHAR(50)  = FORMAT (GETDATE(), 'hh:mm:ss tt');
DECLARE @usr  VARCHAR(100) = (SELECT suser_name());
DECLARE @mydb VARCHAR(50)  = (SELECT DB_Name());
DECLARE @env1 VARCHAR(25)  = (SELECT UPPER(CAST(value AS VARCHAR(25)))
   FROM [master].[sys].fn_listextendedproperty('environment', default, default, default, default, default, default));
PRINT 'It is currently ' + @clk + ' on ' + @day;
PRINT 'The user ' + @usr + ' is connected to the ' + @mydb + ' database';
PRINT 'in the ' + @env1 + ' environment';
PRINT 'on SQL Instance: ' + @env2;
PRINT '';
PRINT 'UPDATE feature_toggle
SET is_active = 0
WHERE name = ''ALLOW_EELIST_ACCESS_FOR_ITA_XML_UPLOAD_PAYROLLS''
';
END;

UPDATE feature_toggle
SET is_active = 0
WHERE name = 'ALLOW_EELIST_ACCESS_FOR_ITA_XML_UPLOAD_PAYROLLS';
