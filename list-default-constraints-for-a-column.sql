SELECT dc.name AS DefaultConstraintName
  FROM sys.default_constraints dc
  JOIN sys.columns c ON dc.parent_object_id = c.object_id AND dc.parent_column_id = c.column_id
  JOIN sys.tables t  ON t.object_id = c.object_id
 WHERE t.name = 'YourTableName' AND c.name = 'YourColumnName';

 SELECT c.name, dc.name AS DefaultConstraintName, dc.definition
  FROM sys.default_constraints dc
  JOIN sys.columns c ON dc.parent_object_id = c.object_id AND dc.parent_column_id = c.column_id
  JOIN sys.tables t  ON t.object_id = c.object_id
 WHERE c.name LIKE '%end%dt%';

SELECT dc.name AS DefaultConstraintName
  FROM sys.default_constraints dc
  JOIN sys.columns c ON dc.parent_object_id = c.object_id
   AND dc.parent_column_id = c.column_id
 WHERE c.name = 'YourColumnName';

 SELECT dc.name DefaultConstraintName, dc.Definition, c.name ColumnName
  FROM sys.default_constraints dc
  JOIN sys.columns c ON dc.parent_object_id = c.object_id
   AND dc.parent_column_id = c.column_id
 WHERE c.name = 'tenant_id';



DECLARE @ConstraintName nvarchar(200)
SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS
WHERE PARENT_OBJECT_ID = OBJECT_ID('__TableName__')
AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns
                        WHERE NAME = N'__ColumnName__'
                        AND object_id = OBJECT_ID(N'__TableName__'))
IF @ConstraintName IS NOT NULL
EXEC('ALTER TABLE __TableName__ DROP CONSTRAINT ' + @ConstraintName)
