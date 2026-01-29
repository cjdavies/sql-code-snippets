select t.name as TableName
  from sys.tables  t
  join sys.columns c
    on t.object_id = c.object_id
 group by t.name
having count(c.column_id) = 1;