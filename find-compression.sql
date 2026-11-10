/* In SQL Server, you can detect whether any tables or indexes in a database are using row or page compression by querying the system catalog views.
Here’s a complete, safe, and reusable T-SQL script that works for all tables and indexes in the current database:*/

-- Detect tables and indexes using compression in the current database
SELECT  
    s.name AS SchemaName,
    t.name AS TableName,
    i.name AS IndexName,
    p.partition_number,
    p.data_compression_desc AS CompressionType
FROM sys.partitions AS p
JOIN sys.indexes AS i
  ON p.object_id = i.object_id
 AND p.index_id = i.index_id
JOIN sys.tables AS t
  ON i.object_id = t.object_id
JOIN sys.schemas AS s
  ON t.schema_id = s.schema_id
WHERE p.data_compression <> 0
ORDER BY s.name, t.name, i.name, p.partition_number;

/* How it works:

sys.partitions → Holds partition-level info, including data_compression.
sys.indexes → Links indexes to tables.
sys.tables and sys.schemas → Provide table and schema names.
data_compression_desc → Shows the compression type (0 = NONE, 1 = ROW, 2 = PAGE, 3 = COLUMNSTORE, etc.).
The WHERE p.data_compression <> 0 filter ensures only compressed objects are returned.
*/