CREATE SCHEMA Security; -- Do this only once
GO

CREATE FUNCTION Security.fn_RLSFilter (@tenant_id INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
(
    SELECT 1 AS AccessResult
     WHERE @tenant_id = CONVERT(INT, SESSION_CONTEXT(N'tenant_id'))  -- Session key must match
);
GO


DECLARE @TenantIDName   NVARCHAR(128) = 'tenant_id';    -- Set this before run
DECLARE @PolicySchema   NVARCHAR(128) = 'Security';     -- Set this before run
DECLARE @FilterFunction NVARCHAR(128) = 'fn_RLSFilter'; -- Set this before run
DECLARE @TableSchema    NVARCHAR(128) = 'dbo';          -- Set this before run
DECLARE @TableName      NVARCHAR(128);
DECLARE @SQL            NVARCHAR(MAX);

DECLARE TableCursor CURSOR FOR
 SELECT TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_TYPE = 'BASE TABLE'
    AND TABLE_SCHEMA = @TableSchema;

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @TableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @SQL = 'CREATE SECURITY POLICY ' + @PolicySchema + '.' + @TableName + '_policy 
                ADD FILTER PREDICATE ' + @PolicySchema + '.' + @FilterFunction + '(' + @TenantIDName + ') ON ' +  @TableSchema + '.' + @TableName + ' WITH (STATE = ON);';

    EXEC(@SQL);

    SET @SQL = 'ALTER SECURITY POLICY ' + @PolicySchema + '.' + @TableName + '_policy 
                ADD BLOCK PREDICATE ' + @PolicySchema + '.' + @FilterFunction + '(' + @TenantIDName + ') ON ' + @TableSchema + '.' + @TableName + ' AFTER INSERT, 
                ADD BLOCK PREDICATE ' + @PolicySchema + '.' + @FilterFunction + '(' + @TenantIDName + ') ON ' + @TableSchema + '.' + @TableName + ' AFTER UPDATE, 
                ADD BLOCK PREDICATE ' + @PolicySchema + '.' + @FilterFunction + '(' + @TenantIDName + ') ON ' + @TableSchema + '.' + @TableName + ' BEFORE DELETE;';

    EXEC(@SQL);
    
    FETCH NEXT FROM TableCursor INTO @TableName;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;

/* Toggle SECURITY POLICY for viewing test results (by table)
ALTER SECURITY POLICY <policy name> WITH (STATE = OFF); -- Disable security policy
ALTER SECURITY POLICY <policy name> WITH (STATE = ON);  -- Enable security policy
*/