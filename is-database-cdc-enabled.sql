SELECT [name], [is_cdc_enabled]
FROM sys.databases
ORDER BY [is_cdc_enabled] DESC, [name] ASC;