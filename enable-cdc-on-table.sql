USE SLIS
GO

IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'nonpaid') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'nonpaid', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'emp_benefit_option') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'emp_benefit_option', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'client_csp') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'client_csp', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'm_client_csp') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'm_client_csp', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'bid_business_size') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'bid_business_size', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'bid_sic_factor') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'bid_sic_factor', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'zipmod') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'zipmod', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'cntalloc') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'cntalloc', @role_name = null;
IF NOT EXISTS (SELECT 1 from sys.tables WHERE is_tracked_by_cdc = 1 AND name = 'cntmods') EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'cntmods', @role_name = null;
