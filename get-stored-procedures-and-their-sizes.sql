-- Get stored procedures and their sizes
use SLIS;
go

-- CANNOT use INFORMATION_SCHEMA.ROUTINES because of 4000 character limit
select o.[type_desc]       as ROUTINE_TYPE
     , s.[name]            as SCHEMA_NAME
     , o.[name]            as ROUTINE_NAME
     , len(m.[definition]) as ROUTINE_DEF_SIZE
from sys.sql_modules       as m
    inner join sys.objects as o
        on m.object_id = o.object_id
    inner join sys.schemas as s
        on o.schema_id = s.schema_id
order by ROUTINE_DEF_SIZE desc;