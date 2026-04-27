USE [DEMO]
GO

ALTER SECURITY POLICY security_user_mask_policy WITH (STATE = OFF)
GO
SELECT TOP 100 * FROM [DEMO].[dbo].security_user_mask
GO
ALTER SECURITY POLICY security_user_mask_policy WITH (STATE = ON)
GO

EXEC sp_set_session_context @key = 'tenant_id', @value = 1001, @read_only=1; 
GO
EXEC te_security_user_mask @action = 'ALL', @user_id = 1;
GO

EXEC sp_set_session_context @key = 'tenant_id', @value = 1001, @read_only=1; 
GO
EXEC te_security_user_mask @action = 'ASG', @user_id = 4, @security_mask_id = 0, @access_code = 'A';
GO

USE [DEMO]
GO
EXEC sp_set_session_context @key = 'tenant_id', @value = 1001, @read_only=1; 
GO
EXEC te_security_user_mask @action = 'RMV', @user_id = 4;
GO

USE [DEMO]
GO
EXEC sp_set_session_context @key = 'tenant_id', @value = 1002, @read_only=1; 
GO
EXEC te_security_user_mask @action = 'UPD', @user_id = 1, @security_mask_id = 0, @access_code = 'X';
GO

/* Get session _context
DECLARE @tenant_id INT;
SELECT @tenant_id = CONVERT(INT, SESSION_CONTEXT(N'tenant_id'));

SELECT CONVERT(INT, SESSION_CONTEXT(N'tenant_id')) as tenant_id;

*/