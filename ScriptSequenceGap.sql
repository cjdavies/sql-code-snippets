DECLARE @ScriptSequenceGap TABLE (
    script_id INT,
    start INT,
    stop INT
);

DECLARE @RequiredGap INT = 1;

WITH
    cteDeductsInActiveScripts (script_id, sequence)
    AS
    (
        SELECT SL.script_id, sequence
        FROM script_line SL
            JOIN dbo.pay_group_script AS PGS
            ON SL.script_id  = PGS.script_id
                AND GETDATE() < PGS.stop_date
            JOIN dbo.pay_group AS PG
            ON PG.pay_group_id = PGS.pay_group_id
                AND PG.active_flag   = 1
        WHERE SL.formula LIKE 'te_pay_deduct_from_salary(%'
    ),
    cteScripts (script_id)
    AS
    (
        SELECT DISTINCT script_id
        FROM cteDeductsInActiveScripts
    ),
    cteMaxDeduct (script_id, max_sequence)
    AS
    (
        SELECT script_id, max(sequence)
        FROM cteDeductsInActiveScripts
        GROUP BY script_id
    ),
    cteNextLineGap (row, script_id, start, stop)
    AS
    (
        SELECT
            ROW_NUMBER() OVER( PARTITION BY SL.script_id ORDER BY sequence ASC) as row,
            SL.script_id,
            MD.max_sequence,
            SL.sequence
        FROM script_line AS SL
            JOIN cteMaxDeduct MD ON MD.script_id = SL.script_id
        WHERE SL.sequence > MD.max_sequence
    ),
    cteGaps (script_id, start, stop)
    AS
    (
                    SELECT script_id, start+1, stop-1
            FROM cteNextLineGap
            WHERE row = 1

        UNION

            SELECT
                cte.script_id,
                cte.sequence + 1 AS start,
                MIN(rEnd.sequence) - 1 AS stop
            FROM cteDeductsInActiveScripts cte
                LEFT JOIN cteDeductsInActiveScripts rBegin ON cte.sequence = (rBegin.sequence - 1) AND cte.script_id = rBegin.script_id
                LEFT JOIN cteDeductsInActiveScripts rEnd ON cte.sequence < rEnd.sequence AND cte.script_id = rEnd.script_id
            WHERE rBegin.sequence IS NULL
                AND rEnd.sequence IS NOT NULL
            GROUP BY cte.script_id, cte.sequence, rBegin.sequence
    ),
    cteBigEnoughGap (row, script_id, start, stop)
    AS
    (
        SELECT
            ROW_NUMBER() OVER( PARTITION BY script_id ORDER BY start ASC),
            script_id,
            start,
            stop
        FROM cteGaps
        WHERE ((stop+1)-(start)) >= @RequiredGap
    )
INSERT INTO @ScriptSequenceGap
    (script_id, start, stop)
SELECT S.*, BEG.start, BEG.stop
FROM cteScripts S
    LEFT JOIN cteBigEnoughGap BEG ON BEG.script_id = S.script_id
WHERE BEG.row = 1 OR BEG.row IS NULL;

SELECT DB_NAME() AS DB, *
FROM @ScriptSequenceGap
WHERE start is null;

