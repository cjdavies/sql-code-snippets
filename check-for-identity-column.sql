/* check for identity column */
IF EXISTS (
    SELECT 1
    FROM [sys].[identity_columns]
    WHERE [name] IN (N'PlanStatusId', N'DisplayValue', N'LegacyIsActive')
      AND [object_id] = OBJECT_ID(N'[plancustom].[PlanStatus]')
)
SET IDENTITY_INSERT [plancustom].[PlanStatus] ON;
