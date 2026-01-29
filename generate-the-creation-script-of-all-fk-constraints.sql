--- SCRIPT TO GENERATE THE CREATION SCRIPT OF ALL FOREIGN KEY CONSTRAINTS
DECLARE @ForeignKeyID INT;
DECLARE @ForeignKeyName VARCHAR(4000);
DECLARE @ParentTableName VARCHAR(4000);
DECLARE @ParentColumn VARCHAR(4000);
DECLARE @ReferencedTable VARCHAR(4000);
DECLARE @ReferencedColumn VARCHAR(4000);
DECLARE @StrParentColumn VARCHAR(MAX);
DECLARE @StrReferencedColumn VARCHAR(MAX);
DECLARE @ParentTableSchema VARCHAR(4000);
DECLARE @ReferencedTableSchema VARCHAR(4000);
DECLARE @TSQLCreationFK VARCHAR(MAX);
DECLARE CursorFK CURSOR FOR
SELECT
    object_id --, name, object_name( parent_object_id) 
FROM
    sys.foreign_keys;

OPEN CursorFK;

FETCH NEXT
FROM
    CursorFK INTO @ForeignKeyID;

WHILE(@ @FETCH_STATUS = 0)
BEGIN
SET @StrParentColumn = '';
SET @StrReferencedColumn = '';

DECLARE CursorFKDetails CURSOR FOR
SELECT
    fk.name ForeignKeyName,
    SCHEMA_NAME(t1.schema_id) ParentTableSchema,
    OBJECT_NAME(fkc.parent_object_id) ParentTable,
    c1.name ParentColumn,
    SCHEMA_NAME(t2.schema_id) ReferencedTableSchema,
    OBJECT_NAME(fkc.referenced_object_id) ReferencedTable,
    c2.name ReferencedColumn
FROM
    --sys.tables t inner join 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN sys.columns c1 ON c1.object_id = fkc.parent_object_id
    AND c1.column_id = fkc.parent_column_id
    INNER JOIN sys.columns c2 ON c2.object_id = fkc.referenced_object_id
    AND c2.column_id = fkc.referenced_column_id
    INNER JOIN sys.tables t1 ON t1.object_id = fkc.parent_object_id
    INNER JOIN sys.tables t2 ON t2.object_id = fkc.referenced_object_id
WHERE
    fk.object_id = @ForeignKeyID;

OPEN CursorFKDetails;

FETCH NEXT
FROM
    CursorFKDetails INTO @ForeignKeyName,
    @ParentTableSchema,
    @ParentTableName,
    @ParentColumn,
    @ReferencedTableSchema,
    @ReferencedTable,
    @ReferencedColumn;

WHILE(@ @FETCH_STATUS = 0)
BEGIN
SET @StrParentColumn = @StrParentColumn + ', ' + QUOTENAME(@ParentColumn);
SET @StrReferencedColumn = @StrReferencedColumn + ', ' + QUOTENAME(@ReferencedColumn);

FETCH NEXT
FROM
    CursorFKDetails INTO @ForeignKeyName,
    @ParentTableSchema,
    @ParentTableName,
    @ParentColumn,
    @ReferencedTableSchema,
    @ReferencedTable,
    @ReferencedColumn;

END;

CLOSE CursorFKDetails;

DEALLOCATE CursorFKDetails;

SET @StrParentColumn = SUBSTRING(@StrParentColumn, 2, LEN(@StrParentColumn) -1);
SET @StrReferencedColumn = SUBSTRING(@StrReferencedColumn, 2, LEN(@StrReferencedColumn) -1);
SET @TSQLCreationFK = 'ALTER TABLE ' + QUOTENAME(@ParentTableSchema) + '.' + QUOTENAME(@ParentTableName) + ' WITH CHECK ADD CONSTRAINT ' + QUOTENAME(@ForeignKeyName) + ' FOREIGN KEY(' + LTRIM(@StrParentColumn) + ') ' + CHAR(13) + 'REFERENCES ' + QUOTENAME(@ReferencedTableSchema) + '.' + QUOTENAME(@ReferencedTable) + ' (' + LTRIM(@StrReferencedColumn) + ') ' + CHAR(13) + 'GO';

PRINT @TSQLCreationFK;

FETCH NEXT
FROM
    CursorFK INTO @ForeignKeyID;

END;

CLOSE CursorFK;

DEALLOCATE CursorFK;