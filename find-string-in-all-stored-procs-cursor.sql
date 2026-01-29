DROP TABLE IF EXISTS #modlines;

CREATE TABLE #modlines (
    SchemaName    NVARCHAR(128),
    ObjectName    NVARCHAR(128),
    LineNumber    INT,
    Line          NVARCHAR(MAX)
);

INSERT INTO #modlines (
    SchemaName,
    ObjectName,
    LineNumber,
    Line
)
SELECT
    OBJECT_SCHEMA_NAME(m.object_id) AS SchemaName,
    OBJECT_NAME(m.object_id) AS ObjectName,
    LineNumber,
    Line
FROM 
    (SELECT 
        object_id,
        definition,
        ROW_NUMBER() OVER (PARTITION BY object_id ORDER BY (SELECT NULL)) AS LineNumber,
        LTRIM(RTRIM(value)) AS Line
    FROM 
        sys.sql_modules
    CROSS APPLY 
        STRING_SPLIT(definition, CHAR(13))
    ) m
JOIN sys.objects o ON m.object_id = o.object_id
WHERE o.type IN ('P', 'FN', 'IF', 'TF')
ORDER BY SchemaName, ObjectName, LineNumber;

DROP TABLE IF EXISTS #selectlines;

CREATE TABLE #selectlines (
    SchemaName    NVARCHAR(128),
    ObjectName    NVARCHAR(128),
    LineNumber    INT,
    Line          NVARCHAR(MAX)
);


DECLARE @SchemaName     NVARCHAR(128);
DECLARE @ObjectName     NVARCHAR(128);
DECLARE @LineNumber     INT;
DECLARE @Line           NVARCHAR(MAX);
DECLARE @StrLen         INT;
DECLARE @Pos            INT;

DECLARE TableCursor CURSOR FOR
SELECT
    SchemaName,
    ObjectName,
    LineNumber,
    Line
FROM #modlines
ORDER BY SchemaName, ObjectName, LineNumber;

OPEN TableCursor;

FETCH NEXT FROM TableCursor INTO @SchemaName, @ObjectName, @LineNumber, @Line;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @StrLen = LEN(@Line);
    SELECT @Pos = CHARINDEX('select ', @Line);
    IF @StrLen > 0 AND @Pos > 0
        SELECT @Pos = CHARINDEX('*', SUBSTRING(@Line, @Pos+7, @StrLen-@Pos-7));
        IF @Pos > 0
            INSERT INTO #selectlines (
                SchemaName,
                ObjectName,
                LineNumber,
                Line
            )
            SELECT @SchemaName, @ObjectName, @LineNumber, @Line;
    
    FETCH NEXT FROM TableCursor INTO @SchemaName, @ObjectName, @LineNumber, @Line;
END

CLOSE TableCursor;
DEALLOCATE TableCursor;
DROP TABLE IF EXISTS #modlines;
DROP TABLE IF EXISTS #selectlines;
