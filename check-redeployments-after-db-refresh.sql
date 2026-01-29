/* After a database refresh, use this to see which releases were redeployed after refresh.*/
Use <your Db>
GO
SELECT * FROM dbo.[RfcVersionHistory] WHERE [EnteredDate] > GETDATE ()-3;
