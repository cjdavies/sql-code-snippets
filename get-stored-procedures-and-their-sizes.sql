-- Get stored procedures and their sizes
USE SLIS;
GO

-- CANNOT use INFORMATION_SCHEMA.ROUTINES because of 4000 character limit
SELECT o.[type_desc]       AS ROUTINE_TYPE
     , s.[name]            AS SCHEMA_NAME
     , o.[name]            AS ROUTINE_NAME
     , len(m.[definition]) AS ROUTINE_DEF_SIZE
FROM sys.sql_modules       AS m
    INNER JOIN sys.objects AS o
    ON m.object_id = o.object_id
    INNER JOIN sys.schemas AS s
    ON o.schema_id = s.schema_id
ORDER BY ROUTINE_DEF_SIZE DESC;