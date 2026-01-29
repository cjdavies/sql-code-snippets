USE [DEMO]
GO
EXEC sp_set_session_context @key = 'tenant_id', @value = 1001; 
GO
-- Run code here
EXEC te_security_user_mask @action = 'ALL', @user_id = 1;
GO

/* Toggle security policy for viewing test results
ALTER SECURITY POLICY _policy WITH (STATE = OFF); -- Disable security policy
ALTER SECURITY POLICY _policy WITH (STATE = ON);  -- Enable security policy
*/

/* Get session _context
DECLARE @tenant_id INT;
SELECT @tenant_id = CONVERT(INT, SESSION_CONTEXT(N'tenant_id'));
*/