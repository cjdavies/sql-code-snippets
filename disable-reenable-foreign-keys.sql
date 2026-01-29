/* Disable a Specific Foreign Key */
ALTER TABLE Purchasing.PurchaseOrderHeader
NOCHECK CONSTRAINT FK_PurchaseOrderHeader_Employee_EmployeeID;

/* To re-enable it and validate existing data */
ALTER TABLE Purchasing.PurchaseOrderHeader
WITH CHECK CHECK CONSTRAINT FK_PurchaseOrderHeader_Employee_EmployeeID;

/* Disable All Foreign Keys in a Table */
ALTER TABLE ttoc_soc_relation NOCHECK CONSTRAINT ALL;

/* Re-enable all with validation */
ALTER TABLE MyTable WITH CHECK CHECK CONSTRAINT ALL;
