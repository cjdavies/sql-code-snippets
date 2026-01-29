WITH
    ActiveCompany AS (
        SELECT
            cpny_id
        FROM
            dbo.cltstat x0
        WHERE
            (
                cstat_code = 1
                OR (
                    thrudt IS NULL
                    OR thrudt > GETDATE()
                )
            )
            AND fromdt = (
                SELECT
                    MAX(x1.fromdt)
                FROM
                    dbo.cltstat x1
                WHERE
                    x1.cpny_id = x0.cpny_id
            )
    ),
    RankedRecords AS (
        SELECT
            ROW_NUMBER() OVER (
                PARTITION BY
                    pr.cpny_id
                ORDER BY
                    paydt,
                    pr.cpny_id
            ) AS rn,
            pr.cpny_id AS CompanyId,
            paydt AS PayDate,
            begdt AS BeginningDate,
            enddt AS EndingDate,
            recdt AS ReceivedDate,
            shipdt AS ShipDate,
            status_id,
            step
        FROM
            company c
            INNER JOIN d_company dc ON dc.cpny_id = c.cpny_id
            INNER JOIN prcalendar pr ON pr.cpny_id = c.cpny_id
            INNER JOIN ActiveCompany ac ON ac.cpny_id = dc.cpny_id
        WHERE
            payroll_type = 1
            AND dc.fromdt = (
                SELECT
                    MAX(fromdt)
                FROM
                    d_company b
                WHERE
                    b.cpny_id = dc.cpny_id
            )
            AND pr.paydt > GETDATE()
            AND pr.payroll_type = 1
    )
SELECT
    r.rn CalendarNo,
    R.CompanyId,
    R.PayDate,
    r.BeginningDate,
    r.EndingDate,
    r.ReceivedDate,
    r.ShipDate,
    r.status_id,
    s.[description] StatusDesc,
    r.step,
    step.[description] StepDesc
FROM
    RankedRecords R
    INNER JOIN m_status s ON s.status_id = r.status_id
    INNER JOIN m_step step ON step.step = r.step
WHERE
    rn <= 6
    AND (
        r.status_id <> 0
        AND r.step <> 10
    );