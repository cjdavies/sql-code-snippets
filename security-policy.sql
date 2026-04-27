USE [DEMO]
GO

/* REF_ACCESS_CODE */
CREATE SECURITY POLICY Security.ref_access_code_policy
ADD FILTER PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.ref_access_code
WITH (STATE = ON);
GO
ALTER SECURITY POLICY Security.ref_access_code_policy
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.ref_access_code AFTER INSERT,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.ref_access_code AFTER UPDATE,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.ref_access_code BEFORE DELETE;
GO

/* SECURITY_USER */
CREATE SECURITY POLICY Security.security_user_policy
ADD FILTER PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user
WITH (STATE = ON);
GO
ALTER SECURITY POLICY Security.security_user_policy
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user AFTER INSERT,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user AFTER UPDATE,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user BEFORE DELETE;
GO

/* SECURITY_MASK */
CREATE SECURITY POLICY Security.security_mask_policy
ADD FILTER PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_mask
WITH (STATE = ON);
GO
ALTER SECURITY POLICY Security.security_mask_policy
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_mask AFTER INSERT,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_mask AFTER UPDATE,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_mask BEFORE DELETE;
GO

/* SECURITY_USER_MASK */
CREATE SECURITY POLICY Security.security_user_mask_policy
ADD FILTER PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user_mask
WITH (STATE = ON);
GO
ALTER SECURITY POLICY Security.security_user_mask_policy
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user_mask AFTER INSERT,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user_mask AFTER UPDATE,
ADD BLOCK PREDICATE Security.fn_RLSFilter(tenant_id) ON dbo.security_user_mask BEFORE DELETE;
GO

/* Toggle SECURITY POLICY Security.for viewing test results
ALTER SECURITY POLICY Security._policy WITH (STATE = OFF); -- Disable security policy
ALTER SECURITY POLICY Security._policy WITH (STATE = ON);  -- Enable security policy
*/