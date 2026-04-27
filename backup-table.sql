/* Backup a table before doing DML operations on it, so that we can restore it if needed. */
EXEC [DEID].[dbo].[CreateBackupTable] '[slis]', '[dbo].[accexec]'