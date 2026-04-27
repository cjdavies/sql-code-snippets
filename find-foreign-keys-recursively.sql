/* ============================================
   Recursive FK chain finder (column-lineage aware)
   SQL Server 2017+ (STRING_AGG used)
   Author: M365 Copilot
   ============================================ */

DECLARE 
    @BaseSchema     sysname = N'cld',            -- <<<< set me
    @BaseTable      sysname = N'Concept',      -- <<<< set me
    @BaseColumnList nvarchar(4000) = N'ConceptID';  -- <<<< set me (comma-separated). Use NULL to default to PK

/*---------------------------------------------
  Resolve base table & seed column set
----------------------------------------------*/
DECLARE @base_object_id int;

SELECT @base_object_id = t.object_id
FROM sys.tables AS t
JOIN sys.schemas AS s ON s.schema_id = t.schema_id
WHERE s.name = @BaseSchema
  AND t.name = @BaseTable;

IF @base_object_id IS NULL
BEGIN
    RAISERROR('Base table %s.%s not found.', 16, 1, @BaseSchema, @BaseTable);
    RETURN;
END

-- Build a table variable of the seed columns (column_ids)
DECLARE @SeedColumns TABLE (column_id int PRIMARY KEY);

IF @BaseColumnList IS NULL
BEGIN
    -- Default to base table's PRIMARY KEY columns
    INSERT INTO @SeedColumns(column_id)
    SELECT ic.column_id
    FROM sys.indexes i
    JOIN sys.index_columns ic 
      ON ic.object_id = i.object_id AND ic.index_id = i.index_id
    WHERE i.object_id = @base_object_id
      AND i.is_primary_key = 1;

    IF NOT EXISTS (SELECT 1 FROM @SeedColumns)
    BEGIN
        RAISERROR('No @BaseColumnList supplied and base table has no PRIMARY KEY. Please provide @BaseColumnList.', 16, 1);
        RETURN;
    END
END
ELSE
BEGIN
    ;WITH cols AS (
        SELECT LTRIM(RTRIM(value)) AS colname
        FROM STRING_SPLIT(@BaseColumnList, ',')
    )
    INSERT INTO @SeedColumns(column_id)
    SELECT c.column_id
    FROM cols
    JOIN sys.columns c
      ON c.object_id = @base_object_id
     AND c.name = cols.colname;

    -- Validate all supplied columns exist:
    IF (SELECT COUNT(*) FROM @SeedColumns) <> (SELECT COUNT(*) FROM STRING_SPLIT(@BaseColumnList, ','))
    BEGIN
        RAISERROR('One or more columns in @BaseColumnList do not exist on %s.%s.', 16, 1, @BaseSchema, @BaseTable);
        RETURN;
    END
END

-- Canonical "seed set" of referenced column IDs (comma-joined, sorted)
DECLARE @SeedColSet nvarchar(2000);
SELECT @SeedColSet = STRING_AGG(CAST(column_id AS nvarchar(20)), ',') WITHIN GROUP (ORDER BY column_id)
FROM @SeedColumns;

/*---------------------------------------------
  Precompute FK map, including:
  - referenced side (parent): table & column set
  - referencing side (child): table & column set
----------------------------------------------*/
;WITH FKCols AS (
    SELECT 
        fk.object_id AS fk_id,
        fk.name      AS fk_name,
        fk.is_disabled,
        fk.is_not_trusted,
        fk.delete_referential_action_desc AS on_delete,
        fk.update_referential_action_desc AS on_update,

        fkc.referenced_object_id,
        fkc.referenced_column_id,
        fkc.parent_object_id     AS referencing_object_id,
        fkc.parent_column_id     AS referencing_column_id,
        fkc.constraint_column_id
    FROM sys.foreign_keys fk
    JOIN sys.foreign_key_columns fkc
      ON fkc.constraint_object_id = fk.object_id
),
FKAgg AS (
    SELECT
        k.fk_id,
        MAX(k.fk_name)                AS fk_name,
        MAX(k.is_disabled)            AS is_disabled,
        MAX(k.is_not_trusted)         AS is_not_trusted,
        MAX(k.on_delete)              AS on_delete,
        MAX(k.on_update)              AS on_update,

        k.referenced_object_id,
        k.referencing_object_id,

        -- Canonical ID sets (for matching lineage)
        STRING_AGG(CAST(k.referenced_column_id AS nvarchar(20)), ',') 
            WITHIN GROUP (ORDER BY k.referenced_column_id) AS ref_colset_ids,
        STRING_AGG(CAST(k.referencing_column_id AS nvarchar(20)), ',') 
            WITHIN GROUP (ORDER BY k.referencing_column_id) AS rcf_colset_ids,

        -- Readable column name lists
        STRING_AGG(QUOTENAME(rcs.name) + N'.' + QUOTENAME(rc.name), N', ')
            WITHIN GROUP (ORDER BY k.referenced_column_id) AS ref_cols,
        STRING_AGG(QUOTENAME(ps.name) + N'.' + QUOTENAME(pc.name), N', ')
            WITHIN GROUP (ORDER BY k.referencing_column_id) AS rcf_cols
    FROM FKCols k
    JOIN sys.columns rc
      ON rc.object_id = k.referenced_object_id
     AND rc.column_id = k.referenced_column_id
    JOIN sys.objects o_ref
      ON o_ref.object_id = k.referenced_object_id
    JOIN sys.schemas rcs
      ON rcs.schema_id = o_ref.schema_id
    JOIN sys.columns pc
      ON pc.object_id = k.referencing_object_id
     AND pc.column_id = k.referencing_column_id
    JOIN sys.objects o_ref2
      ON o_ref2.object_id = k.referencing_object_id
    JOIN sys.schemas ps
      ON ps.schema_id = o_ref2.schema_id
    GROUP BY
        k.fk_id, k.referenced_object_id, k.referencing_object_id, k.is_disabled, k.is_not_trusted, k.on_delete, k.on_update
),
FKMap AS (
    SELECT
        a.fk_id,
        a.fk_name,
        a.is_disabled,
        a.is_not_trusted,
        a.on_delete,
        a.on_update,
        a.referenced_object_id,
        a.referencing_object_id,
        a.ref_colset_ids,
        a.rcf_colset_ids,
        a.ref_cols,
        a.rcf_cols,

        QUOTENAME(sref.name) + N'.' + QUOTENAME(tref.name) AS referenced_table,
        QUOTENAME(sref2.name) + N'.' + QUOTENAME(tref2.name) AS referencing_table
    FROM FKAgg a
    JOIN sys.tables tref  ON tref.object_id = a.referenced_object_id
    JOIN sys.schemas sref ON sref.schema_id = tref.schema_id
    JOIN sys.tables tref2  ON tref2.object_id = a.referencing_object_id
    JOIN sys.schemas sref2 ON sref2.schema_id = tref2.schema_id
)
-- Recursive chain:
, Chain AS (
    -- Anchor: FKs that reference the base table on the seed column set
    SELECT
        1 AS depth,
        CAST(CONCAT('(0) ', QUOTENAME(@BaseSchema), '.', QUOTENAME(@BaseTable), ' [cols:', @SeedColSet, ']') AS nvarchar(max)) AS path_sig,
        m.fk_id,
        m.fk_name,
        m.is_disabled,
        m.is_not_trusted,
        m.on_delete,
        m.on_update,
        m.referenced_table,
        m.ref_cols,
        m.referencing_table,
        m.rcf_cols,
        m.ref_colset_ids,
        m.rcf_colset_ids
    FROM FKMap m
    WHERE m.referenced_object_id = @base_object_id
      AND m.ref_colset_ids = @SeedColSet

    UNION ALL

    -- Recurse: find FKs that reference the *previous referencing table*,
    -- on the *same columns* that were used as referencing columns in the prior hop
    SELECT
        c.depth + 1 AS depth,
        CAST(c.path_sig + N' -> ' + m.referencing_table + N' [cols:' + m.rcf_colset_ids + N']' AS nvarchar(max)) AS path_sig,
        m.fk_id,
        m.fk_name,
        m.is_disabled,
        m.is_not_trusted,
        m.on_delete,
        m.on_update,
        m.referenced_table,
        m.ref_cols,
        m.referencing_table,
        m.rcf_cols,
        m.ref_colset_ids,
        m.rcf_colset_ids
    FROM Chain c
    JOIN FKMap m
      ON m.referenced_table = c.referencing_table
     AND m.ref_colset_ids = c.rcf_colset_ids
    -- prevent cycles on (table + colset) signatures:
    WHERE c.path_sig NOT LIKE '%' + m.referencing_table + ' [cols:' + m.rcf_colset_ids + ']%'
)
SELECT
    depth,
    referenced_table       AS [Referenced (parent) table],
    ref_cols               AS [Referenced columns],
    fk_name                AS [FK name],
    referencing_table      AS [Referencing (child) table],
    rcf_cols               AS [Referencing columns],
    on_update              AS [ON UPDATE],
    on_delete              AS [ON DELETE],
    is_disabled,
    is_not_trusted,
    path_sig               AS [Path signature]
FROM Chain
ORDER BY depth, [FK name], [Referencing (child) table]
OPTION (MAXRECURSION 32767);