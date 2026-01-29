SELECT name
  FROM master.sys.databases
 WHERE database_id > 4  -- Ignore system databases
 ORDER BY name;