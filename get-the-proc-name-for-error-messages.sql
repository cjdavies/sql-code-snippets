/* Example of how to get the proc name for error messages */
CREATE OR ALTER PROC demo_an_error_message 
AS
DECLARE	@proc_name sysname = CONCAT(
		QUOTENAME(OBJECT_SCHEMA_NAME(@@PROCID)),
		'.',
		QUOTENAME(OBJECT_NAME(@@PROCID))
		)

DECLARE @msg varchar(255)

SET @msg = 'ERROR in ' + @proc_name + ' whatever the message should say'
RAISERROR (@msg, 16, 1) WITH NOWAIT;
/* NOWAIT sends the message immediately. WITH LOG logs the error in the error log and application log.

exec demo_an_error_message;
GO

Level values (first number is severity, second number is state):
0–10  Informational messages
11–18 Errors
19–25 Fatal errors

Msg 50000, Level 16, State 1, Procedure demo_an_error_message, Line 9
ERROR in [dbo].[demo_an_error_message] whatever the message should say
*/