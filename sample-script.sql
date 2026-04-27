DECLARE @HasHours BIT;
DECLARE @HasDays  BIT;
DECLARE @HasYears BIT;
DECLARE @CurrentDate DATETIME = GETDATE();

SET @HasHours = (
    SELECT TOP 1 1
    FROM script_line sl
    JOIN script s ON s.script_id = sl.script_id
    WHERE
        s.effective_date <= @CurrentDate
        AND s.stop_date >= @CurrentDate
        AND sl.formula LIKE 'te_accrual_eligible_hours_worked_from_hire(%'
        AND sl.script_action LIKE '%EXECUTE%'
);

SET @HasDays = (
    SELECT TOP 1 1
    FROM script_line sl
    JOIN script s ON s.script_id = sl.script_id
    WHERE
        s.effective_date <= @CurrentDate
        AND s.stop_date >= @CurrentDate
        AND sl.formula LIKE 'te_accrual_eligible_days_worked_from_hire(%'
        AND sl.script_action LIKE '%EXECUTE%'
);

SET @HasYears = (
    SELECT TOP 1 1
    FROM script_line sl
    JOIN script s ON s.script_id = sl.script_id
    WHERE
        s.effective_date <= @CurrentDate
        AND s.stop_date >= @CurrentDate
        AND sl.formula LIKE 'te_accrual_eligible_years_worked_from_hire(%'
        AND sl.script_action LIKE '%EXECUTE%'
);

IF @HasHours IS NULL AND @HasDays IS NULL AND @HasYears IS NULL
    RETURN;

SELECT
    @HasHours AS 'HAS_HOURS',
    @HasDays AS 'HAS_DAYS',
    @HasYears AS 'HAS_YEARS';
