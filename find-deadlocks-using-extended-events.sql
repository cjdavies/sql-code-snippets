/* How to find deadlocks in SQL Server using Extended Events */
DECLARE @StartTimeUtc datetime2 = '2026-04-09T14:00:00';
DECLARE @EndTimeUtc   datetime2 = '2026-04-09T14:30:00';

SELECT
    XEvent.value('(event/@timestamp)[1]', 'datetime2') AS DeadlockTimeUtc,
    XEvent.query('(event/data/value/deadlock)[1]')     AS DeadlockGraph
FROM
(
    SELECT CAST(event_data AS xml) AS EventData
    FROM sys.fn_xe_file_target_read_file
    (
        'system_health*.xel',
        NULL, NULL, NULL
    )
) AS Data
CROSS APPLY EventData.nodes('//event[@name="xml_deadlock_report"]') AS XEventData(XEvent)
WHERE
    XEvent.value('(event/@timestamp)[1]', 'datetime2')
        BETWEEN @StartTimeUtc AND @EndTimeUtc
ORDER BY DeadlockTimeUtc DESC;

/* What to look for in the deadlock graph

In SSMS, click the XML and view as a graph:

   Resources section
   *   `KEY`, `RID`, `PAGE`, `OBJECT`
   *   Index name (if applicable)
   Owners / Waiters
   *   Which session *held* and which *waited*
   Edge direction
   *   Shows the cyclic dependency

This directly answers: which resource caused the deadlock.
*/