USE SLIS;
GO

DECLARE @PerID INT;
SET @PerID = 568303;  --<-- put per_id here
DECLARE @maxdate DATETIME;
 
SET @maxdate = (
	SELECT MAX([change_dt])
      FROM [SLIS].[dbo].[phone]
     WHERE [phone_type] = 'W' 
       AND [relation_id] =  @PerID);
 
SELECT TOP 1 [relation_id] AS [Per_ID],
             [phone] AS [Work ph],
             [change_dt]
  FROM [SLIS].[dbo].[phone]
 WHERE [phone_type] = 'W' 
   AND [relation_id] =  @PerID ;
