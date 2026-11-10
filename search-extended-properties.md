In **SQL Server 2019**, extended properties are stored as metadata in system catalog views. To search them for a **specific character string**, you query `sys.extended_properties` (or `fn_listextendedproperty`) and cast the value to a string so it can be searched.

***

## Basic search example

```sql
SELECT
    ep.name AS property_name,
    CAST(ep.value AS nvarchar(max)) AS property_value,
    ep.class_desc,
    OBJECT_SCHEMA_NAME(ep.major_id) AS schema_name,
    OBJECT_NAME(ep.major_id) AS object_name
FROM sys.extended_properties ep
WHERE
    ep.name LIKE '%your_search_string%'
    OR CAST(ep.value AS nvarchar(max)) LIKE '%your_search_string%';
```

### Notes

*   `ep.value` is `sql_variant`, so it **must be cast** before using `LIKE`
*   `class_desc` tells you what kind of object the property is attached to (OBJECT, COLUMN, DATABASE, etc.)

***

## Search only object- and column-level properties

This version includes table and column names where applicable:

```sql
SELECT
    ep.name AS property_name,
    CAST(ep.value AS nvarchar(max)) AS property_value,
    s.name AS schema_name,
    o.name AS object_name,
    c.name AS column_name,
    ep.class_desc
FROM sys.extended_properties ep
LEFT JOIN sys.objects o
    ON ep.major_id = o.object_id
LEFT JOIN sys.schemas s
    ON o.schema_id = s.schema_id
LEFT JOIN sys.columns c
    ON ep.major_id = c.object_id
   AND ep.minor_id = c.column_id
WHERE
    CAST(ep.value AS nvarchar(max)) LIKE '%your_search_string%';
```

***

## Search database-level extended properties only

```sql
SELECT
    name,
    CAST(value AS nvarchar(max)) AS property_value
FROM sys.extended_properties
WHERE
    class = 0  -- DATABASE
    AND CAST(value AS nvarchar(max)) LIKE '%your_search_string%';
```

***

## Case-insensitive vs case-sensitive searches

Extended properties follow the **database collation** by default.  
If you need to force behavior:

```sql
WHERE CAST(ep.value AS nvarchar(max)) COLLATE Latin1_General_CI_AS
      LIKE '%your_search_string%';
```

(or use a `_CS_` collation for case-sensitive)

***

## Performance considerations

*   Searching extended properties is typically **metadata-only and small**, so performance is usually not an issue
*   Avoid running these queries extremely frequently on very large schemas unless needed

***

## Quick checklist

✅ Use `sys.extended_properties`  
✅ Cast `sql_variant` to `nvarchar`  
✅ Join to `sys.objects` / `sys.columns` for context  
✅ Filter by `class` or `class_desc` if you want scope control

If you want, I can tailor this to:

*   Only descriptions (`MS_Description`)
*   Only tables / views / procedures
*   Cross-database searching
*   Export results to a report-friendly format (CSV / table)
