SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET DEADLOCK_PRIORITY LOW;
GO

/*
SELECT DISTINCT TOP (50) SUBSTRING(first_email.val, CHARINDEX('@', first_email.val) + 1, LEN(first_email.val)) AS [EmailDomain]
FROM dbo.mail
CROSS APPLY (
    SELECT LEFT(mailto, CASE WHEN CHARINDEX(';', mailto) > 0 THEN CHARINDEX(';', mailto) - 1 ELSE LEN(mailto) END) AS val
) AS first_email
ORDER BY [EmailDomain];
*/

SELECT SUBSTRING(first_email.val, CHARINDEX('@', first_email.val) + 1, LEN(first_email.val)) AS [EmailDomain], count(*) AS [EmailDomainCount]
FROM dbo.mail
CROSS APPLY (
    SELECT LEFT(mailto, CASE WHEN CHARINDEX(';', mailto) > 0 THEN CHARINDEX(';', mailto) - 1 ELSE LEN(mailto) END) AS val
) AS first_email
WHERE [mailto] IS NOT NULL AND [mailto] <> ''
GROUP BY SUBSTRING(first_email.val, CHARINDEX('@', first_email.val) + 1, LEN(first_email.val))
ORDER BY count(*) DESC, SUBSTRING(first_email.val, CHARINDEX('@', first_email.val) + 1, LEN(first_email.val))
--ORDER BY SUBSTRING(first_email.val, CHARINDEX('@', first_email.val) + 1, LEN(first_email.val))
;

EmailDomain	EmailDomainCount
GMail.Com	38204240
INSPERITY.COM	15908537
YAHOO.com	9364560
hotmail.com	3126505
AOL.com	1547503
iCloud.com	1081265
comcast.net	942259
OUTLOOK.COM	926592
sbcglobal.net	522995
msn.com	501655
live.com	429438
att.net	406495
ME.COM	386844
verizon.net	319089
YMAIL.COM	240647
cox.net	180016
mac.com	153890
OPTONLINE.NET	145451
bellsouth.net	124220
SCHOOLSPECIALTY.COM	101931
Charter.net	89301
protonmail.com	79359
rocketmail.com	75647
congruex.com	71553
varonis.com	62035
EARTHLINK.NET	61512
revantage.com	51418
allstate.com	46386
caliva.org	45735
buildgc.com	42613