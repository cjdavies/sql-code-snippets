/* Here's the SQL to extract the CDC captured columns as a single comma-separated string, in their correct ordinal order:
*/
SELECT
    STRING_AGG('[' + cc.column_name + ']', ', ') WITHIN GROUP (ORDER BY cc.column_ordinal) AS captured_columns
--    STRING_AGG(cc.column_name, ', ') WITHIN GROUP (ORDER BY cc.column_ordinal) AS captured_columns
FROM
    cdc.change_tables         ct
    INNER JOIN cdc.captured_columns cc
        ON ct.object_id = cc.object_id
WHERE
    ct.capture_instance = 'your_capture_instance_name';

/* Key points
**`cdc.change_tables`** holds one row per capture instance. The `capture_instance` name defaults to `schema_tablename` (e.g. `dbo_MyTable`) but can be customised — check yours with:
*/
SELECT capture_instance, source_object_id
FROM cdc.change_tables;

/*
**`cdc.captured_columns`** holds one row per captured column per capture instance. The important fields used here are:

| Column | Purpose |
|---|---|
| `column_name` | The column's name |
| `column_ordinal` | The position the column was listed when CDC was enabled — this drives the `ORDER BY` |
| `object_id` | Joins back to `cdc.change_tables` |

**`STRING_AGG ... WITHIN GROUP (ORDER BY ...)`** is the SQL Server 2017+ way to produce a single ordered string. The `WITHIN GROUP` clause is what guarantees ordinal ordering rather than relying on storage order.
*/

-- If you need to scope the query to a specific source table rather than knowing the capture instance name, you can join via the source object ID instead:

SELECT
    STRING_AGG('[' + cc.column_name + ']', ', ') WITHIN GROUP (ORDER BY cc.column_ordinal) AS captured_columns
FROM
    cdc.change_tables         ct
    INNER JOIN cdc.captured_columns cc
        ON ct.object_id = cc.object_id
WHERE
    ct.source_object_id = OBJECT_ID('dbo.YourSourceTable');

-- This handles the edge case where a table has multiple capture instances, returning one row per instance — you may want to add `GROUP BY ct.capture_instance` in that scenario.
