USE SLIS
GO
 
DECLARE @userId AS [VARCHAR](10) = 'sxosma'		--user_id of the new employee
EXEC [dbo].[GrantAimsPermissions] @userId
GO


/* To verify data is populated: */
 
DECLARE @userId AS [VARCHAR](10) = 'sxosma'		--user_id of the new employee
DECLARE @perId AS [INTEGER]
 
SELECT @perId = per_id FROM dbuser WHERE [user_id] = @userId
SELECT * FROM dbo.dbuser WHERE [user_id] = @userId 
SELECT * FROM dbo.d_person WHERE per_id = @perId
SELECT * FROM dbo.usergrp WHERE [user_id] = @userId 
SELECT * FROM dbo.person WHERE per_id = @perId 
SELECT * FROM dbo.pos WHERE per_id = @perId 
SELECT * FROM dbo.d_pos WHERE per_id = @perId 
SELECT * FROM dbo.pay WHERE per_id = @perId 
SELECT * FROM dbo.w4fed WHERE per_id = @perId 
SELECT * FROM dbo.emp_i9_data WHERE per_id = @perId 
SELECT * FROM dbo.emp_i9_document WHERE per_id = @perId
