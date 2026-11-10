/*
    Generate INSERT statements for a table.

    Change these values:
*/
DECLARE @SchemaName sysname = N'plancustom';
DECLARE @TableName  sysname = N'AccrualPlanTier';
DECLARE @IncludeIdentity bit = 1;

DECLARE @ObjectId int =
    OBJECT_ID(QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName), N'U');

IF @ObjectId IS NULL
    THROW 50000, 'The specified table does not exist.', 1;

DECLARE @FullTableName nvarchar(517) =
    QUOTENAME(@SchemaName) + N'.' + QUOTENAME(@TableName);

DECLARE @ColumnList nvarchar(max);
DECLARE @ValueList nvarchar(max);
DECLARE @OrderBy nvarchar(max) = N'';
DECLARE @Sql nvarchar(max);

SELECT
    @ColumnList = STRING_AGG(QUOTENAME(c.name), N', ')
        WITHIN GROUP (ORDER BY c.column_id)
FROM sys.columns AS c
WHERE c.object_id = @ObjectId
  AND c.is_computed = 0
  AND c.system_type_id NOT IN (189) -- rowversion/timestamp
  AND c.generated_always_type = 0
  AND (@IncludeIdentity = 1 OR c.is_identity = 0);

SELECT
    @ValueList = STRING_AGG(
        CASE
            WHEN c.system_type_id IN (35, 99, 167, 175, 231, 239)
                THEN
                    CASE
                        WHEN c.system_type_id IN (99, 231, 239)
                            THEN N'N'
                        ELSE N''
                    END
                    + N'''' +
                    N''' + REPLACE(CONVERT(nvarchar(max), '
                    + QUOTENAME(c.name)
                    + N'), '''''''', '''''''''''') + N''''

            WHEN c.system_type_id IN (40, 41, 42, 43, 58, 61)
                THEN N'''''' +
                    N' + CONVERT(nvarchar(50), CONVERT(datetime2, '
                    + QUOTENAME(c.name)
                    + N'), 126) + N''''''

            WHEN c.system_type_id = 36
                THEN N'''''' +
                    N' + CONVERT(nvarchar(36), '
                    + QUOTENAME(c.name)
                    + N') + N''''''

            WHEN c.system_type_id IN (binary, varbinary, image)
                THEN N'''''' +
                    N' + CONVERT(nvarchar(max), '
                    + QUOTENAME(c.name)
                    + N', 1) + N''''''

            WHEN c.system_type_id = 104
                THEN N'CASE WHEN ' + QUOTENAME(c.name)
                    + N' = 1 THEN ''1'' ELSE ''0'' END'

            WHEN c.system_type_id IN (241)
                THEN N'N'''' + REPLACE(CONVERT(nvarchar(max), '
                    + QUOTENAME(c.name)
                    + N'), '''''''', '''''''''''') + N''''

            ELSE
                N'CONVERT(nvarchar(max), '
                + QUOTENAME(c.name)
                + N')'
        END,
        N' + N'', '' + '
    )
    WITHIN GROUP (ORDER BY c.column_id)
FROM sys.columns AS c
WHERE c.object_id = @ObjectId
  AND c.is_computed = 0
  AND c.system_type_id NOT IN (189)
  AND c.generated_always_type = 0
  AND (@IncludeIdentity = 1 OR c.is_identity = 0);

-- Wrap nullable values in NULL handling.
SELECT
    @ValueList = STRING_AGG(
        N'CASE WHEN ' + QUOTENAME(c.name) + N' IS NULL THEN N''NULL'' ELSE '
        +
        CASE
            WHEN c.system_type_id IN (35, 99, 167, 175, 231, 239)
                THEN
                    CASE
                        WHEN c.system_type_id IN (99, 231, 239)
                            THEN N'N'
                        ELSE N''
                    END
                    + N'''''' +
                    N' + REPLACE(CONVERT(nvarchar(max), '
                    + QUOTENAME(c.name)
                    + N'), '''''''', '''''''''''') + N''''''

            WHEN c.system_type_id IN (40, 41, 42, 43, 58, 61)
                THEN N'''''' +
                    N' + CONVERT(nvarchar(50), CONVERT(datetime2, '
                    + QUOTENAME(c.name)
                    + N'), 126) + N''''''

            WHEN c.system_type_id = 36
                THEN N'''''' +
                    N' + CONVERT(nvarchar(36), '
                    + QUOTENAME(c.name)
                    + N') + N''''''

            WHEN c.system_type_id IN (binary, varbinary, image)
                THEN N'''''' +
                    N' + CONVERT(nvarchar(max), '
                    + QUOTENAME(c.name)
                    + N', 1) + N''''''

            WHEN c.system_type_id = 104
                THEN N'CASE WHEN ' + QUOTENAME(c.name)
                    + N' = 1 THEN N''1'' ELSE N''0'' END'

            ELSE
                N'CONVERT(nvarchar(max), '
                + QUOTENAME(c.name)
                + N')'
        END
        + N' END',
        N' + N'', '' + '
    )
    WITHIN GROUP (ORDER BY c.column_id)
FROM sys.columns AS c
WHERE c.object_id = @ObjectId
  AND c.is_computed = 0
  AND c.system_type_id NOT IN (189)
  AND c.generated_always_type = 0
  AND (@IncludeIdentity = 1 OR c.is_identity = 0);

IF EXISTS
(
    SELECT 1
    FROM sys.columns
    WHERE object_id = @ObjectId
      AND is_identity = 1
      AND @IncludeIdentity = 1
)
BEGIN
    SET @Sql = N'
SELECT N''SET IDENTITY_INSERT ' + @FullTableName + N' ON;''
UNION ALL
SELECT N''INSERT INTO ' + @FullTableName + N' (' + @ColumnList + N') VALUES ('' +
       ' + @ValueList + N' + N'');''
FROM ' + @FullTableName + N'
UNION ALL
SELECT N''SET IDENTITY_INSERT ' + @FullTableName + N' OFF;'';';
END
ELSE
BEGIN
    SET @Sql = N'
SELECT N''INSERT INTO ' + @FullTableName + N' (' + @ColumnList + N') VALUES ('' +
       ' + @ValueList + N' + N'');''
FROM ' + @FullTableName + N';';
END;

EXEC sys.sp_executesql @Sql;
