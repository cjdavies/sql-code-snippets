SELECT database_id, name
  FROM sys.databases
 WHERE name NOT IN 
 (
     'Admin',
     'AdventureWorks2012',
     'DBA',
     'DEID',
     'DMR',
     'master',
     'model',
     'msdb',
     'plumtree5_esc3',
     'smtp',
     'Temp_Object_Repository',
     'tempdb'
 );