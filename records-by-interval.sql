DECLARE @interval int = 60;

SELECT
    DATEADD(
        MINUTE,
        DATEDIFF(MINUTE, '2000', im.TimestampUTC) / @interval * @interval,
        '2000'
    ) AS [date_truncated],
    COUNT(*) AS [records_in_interval]
FROM
    common.IntegrationMessage AS im
WHERE
    im.TimestampUTC > '2025-10-08 00:00:00.9374414'
    AND im.TimestampUTC <= '2025-10-09 00:00:00.9374414'
GROUP BY
    DATEDIFF(MINUTE, '2000', im.TimestampUTC) / @interval -- HAVING COUNT(*) > 1000
ORDER BY
    [date_truncated];