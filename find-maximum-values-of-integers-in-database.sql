/* Find the maximum values of integers in a database */
DECLARE @TableName VARCHAR(255),
	@ColumnName VARCHAR(255),
	@SQL VARCHAR(4000)

DROP TABLE IF EXISTS #IntTemp
CREATE TABLE #IntTemp (
	DatabaseName varchar(255),
	TableName	varchar(255),
	ColumnName	Varchar(255),
	CurrentMaxValue	INT
	)

DECLARE IntColumns CURSOR
FOR
SELECT '['+S.name+'].['+O.Name+']' AS TableName,
	C.Name AS ColumnName
	--,T.Name AS DataType
	--,C.is_identity
	FROM sys.columns C
JOIN sys.Types T ON T.user_type_id = C.user_type_id
	AND T.Name = 'int'
JOIN sys.Objects O on O.object_id = c.object_id
	and O.Type = 'U'
	AND C.is_identity = 1
JOIN sys.Schemas S on S.schema_id = O.schema_id
ORDER BY TableName, C.is_identity DESC

OPEN IntColumns
FETCH NEXT FROM IntColumns INTO @TableName, @ColumnName

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @SQL = 'INSERT INTO #IntTemp (DatabaseName, TableName, ColumnName, CurrentMaxValue)
				SELECT db_name() as DatabaseName, ' +
				CHAR(39) + @TableName + CHAR(39) + ' as TableName, '+
				CHAR(39) + @columnName + CHAR(39) + ' as ColumnName,
				ISNULL(MAX(['+@ColumnName+']),0) as CurrentMaxValue FROM '+ @TableName
	EXEC (@SQL)
	PRINT @SQL
FETCH NEXT FROM IntColumns INTO @TableName, @ColumnName

END
CLOSE IntColumns
DEALLOCATE IntColumns
;

SELECT @@SERVERNAME, DatabaseName, TableName, ColumnName, CurrentMaxValue From #IntTemp
--SELECT * from #IntTemp


