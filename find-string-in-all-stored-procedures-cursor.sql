DECLARE @SchemaName     NVARCHAR(128);
DECLARE @ObjectName     NVARCHAR(128);
DECLARE @LineNumber     INT;
DECLARE @Line           NVARCHAR(MAX);
DECLARE @StrLen         INT;
DECLARE @Pos            INT;

DECLARE TableCursor CURSOR FOR
WITH ModuleLines AS (
    SELECT 
        object_id,
        definition,
        ROW_NUMBER() OVER (PARTITION BY object_id ORDER BY (SELECT NULL)) AS line_number,
        LTRIM(RTRIM(value)) AS line
    FROM 
        sys.sql_modules
    CROSS APPLY 
        STRING_SPLIT(definition, CHAR(13))
    WHERE definition LIKE '%select \*%' ESCAPE '\'
)
SELECT
    OBJECT_SCHEMA_NAME(m.object_id) AS SchemaName,
    OBJECT_NAME(m.object_id) AS ObjectName,
    line_number,
    line
FROM 
    ModuleLines m
JOIN sys.objects o ON m.object_id = o.object_id
WHERE o.type IN ('P', 'FN', 'IF', 'TF')
ORDER BY SchemaName, ObjectName, line_number;

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @SchemaName, @ObjectName, @LineNumber, @Line;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @StrLen = LEN(@Line);
    SELECT @Pos = CHARINDEX('select ', @Line);
    IF @StrLen = 0 OR @Pos = 0
        CONTINUE;
    ELSE
        SELECT @Pos = CHARINDEX('*', SUBSTRING(@Line, @Pos+7, @StrLen-@Pos-7));
        IF @Pos > 0
            PRINT @SchemaName + '.' + @ObjectName + CAST(@LineNumber AS NVARCHAR(1000)) + @Line;
    
    FETCH NEXT FROM TableCursor INTO @SchemaName, @ObjectName, @LineNumber, @Line;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;
