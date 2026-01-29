-- Current syntax
DROP TABLE IF EXISTS #TempTable;
GO

-- Older syntax (still works)
IF OBJECT_ID('tempdb..#TempTable') IS NOT NULL
BEGIN
   DROP TABLE #TempTable;
END;
GO