/* Verify whether Change Data Capture(CDC) is enabled on database tables.
If a table is CDC enabled and a new column is added, then the new column won't be replicated to Snowflake until you create a new ticket for the BI Group or Enterprise DBA's to add it to the CDC configuration. 

Adapted from original script by Mark Mills */

--Find DBs with CDC enabled on a SQL Instance
USE MSDB;
GO
SELECT [name], [enabled], [description], [date_modified]
FROM msdb.[dbo].[sysjobs]
WHERE LEFT(name, 4) = 'cdc.' AND name LIKE '%Capture'
ORDER BY [name];

USE CHCRepository;  -- Update your database name
GO
SELECT DB_NAME() AS DB_Name,
       s.name AS Schema_Name,
       t.name AS Table_Name,
       t.max_column_id_used AS [# of columns replicated],
       t.is_replicated,
       t.is_tracked_by_cdc,
       t.data_retention_period_unit_desc,
       t.modify_date
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.is_tracked_by_cdc = 1
ORDER BY Schema_Name, Table_Name;
GO

-- This will error if no tables are CDC enabled
SELECT OBJECT_NAME(object_id) AS CDC_Table,
       OBJECT_NAME(source_object_id) AS Native_Table,
       capture_instance,
       create_date
FROM cdc.change_tables
ORDER BY Native_Table;
GO