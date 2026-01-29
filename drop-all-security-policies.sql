/* Drop all security policies */

DECLARE @PolicyName NVARCHAR(128);
DECLARE @SchemaName NVARCHAR(128);
DECLARE @SQL        NVARCHAR(MAX);

DECLARE PolicyCursor CURSOR FOR
SELECT s.name  AS SchemaName,
       sp.name AS PolicyName
  FROM sys.security_policies sp
  JOIN sys.schemas s ON sp.schema_id = s.schema_id;

OPEN PolicyCursor;

FETCH NEXT FROM PolicyCursor INTO @SchemaName, @PolicyName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'DROP SECURITY POLICY ' + @SchemaName + '.' + @PolicyName + ';';
    
    EXEC(@SQL);
    
    FETCH NEXT FROM PolicyCursor INTO @SchemaName, @PolicyName;
END

CLOSE PolicyCursor;
DEALLOCATE PolicyCursor;
