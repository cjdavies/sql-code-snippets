/* Add table to security policy */
ALTER SECURITY POLICY EmployeeSecurityPolicy
ADD FILTER PREDICATE dbo.fn_securitypredicate
ON dbo.EmployeeDetails;

ALTER SECURITY POLICY EmployeeSecurityPolicy
ADD BLOCK PREDICATE
ON dbo.EmployeeRecords
AFTER INSERT
AS dbo.EmployeePredicate;

/* Remove table from security policy */
ALTER SECURITY POLICY [YourSecurityPolicyName]
DROP FILTER PREDICATE ON [dbo].[YourTableName];

ALTER SECURITY POLICY [YourSecurityPolicyName]
DROP BLOCK PREDICATE ON [dbo].[YourTableName];
