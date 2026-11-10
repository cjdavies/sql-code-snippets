/* USE SLIS
GO
*/

IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'client_audit') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'client_audit', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'contract_audit') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'contract_audit', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'h_debdt_on_paydt') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'h_debdt_on_paydt', @role_name = null;
