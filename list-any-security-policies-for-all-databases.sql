/* List any security policies for all databases */

DECLARE @command VARCHAR(4000);
SELECT @command = '
BEGIN USE ?
		BEGIN
		SELECT s.name  AS SchemaName, 
		       sp.name AS PolicyName 
		FROM sys.security_policies sp 
		JOIN sys.schemas s 
		ON sp.schema_id = s.schema_id; 
		END;
END';

EXEC sp_MSforeachdb @command;