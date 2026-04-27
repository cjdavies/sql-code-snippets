Here are a few solid T‑SQL patterns you can use in SQL Server 2019 to
count rows by **month/year** based on a created\_on column.

**1) Most common: group by the first day of the month**

This groups all rows into monthly buckets using a normalized “month
start” date. It’s efficient and sorts naturally.

SELECT

    DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1) AS
month\_start,

    COUNT(\*) AS row\_count

FROM dbo.YourTable

WHERE created\_on IS NOT NULL

GROUP BY DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1)

ORDER BY month\_start;

**Why this pattern?**

-   DATEFROMPARTS(YEAR(), MONTH(), 1) normalizes all dates in the same
    calendar month to a single value (e.g., 2025-11-01).

-   It avoids the ambiguity of grouping by just YEAR(created\_on),
    MONTH(created\_on) without a single sortable column.

-   Works great with an index on created\_on.

**2) If you want separate Year and Month columns**

SELECT

    YEAR(created\_on)  AS \[year\],

    MONTH(created\_on) AS \[month\],

    COUNT(\*)          AS row\_count

FROM dbo.YourTable

WHERE created\_on IS NOT NULL

GROUP BY

    YEAR(created\_on),

    MONTH(created\_on)

ORDER BY

    \[year\],

    \[month\];

Note: Grouping by YEAR, MONTH alone is fine; just be aware that the pair
(2024, 1) and (2025, 1) are distinct.

**3) Friendly display label (without slowing the GROUP BY)**

Avoid using FORMAT() inside the grouping (it’s slower). Instead, group
by month\_start and format in an outer query:

WITH monthly AS (

    SELECT DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1) AS
month\_start,

           COUNT(\*) AS row\_count

    FROM dbo.YourTable

    WHERE created\_on IS NOT NULL

    GROUP BY DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1)

)

SELECT

    month\_start,

    CONVERT(char(7), month\_start, 126) AS ym\_label,  -- 'yyyy-MM'

    row\_count

FROM monthly

ORDER BY month\_start;

**4) Filtering to a date range**

Use an open-ended upper bound to keep it sargable and index-friendly:

DECLARE @StartDate date = '2019-01-01';

DECLARE @EndDate   date = '2026-03-01'; -- exclusive upper bound (first
day of next month you want)

SELECT

    DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1) AS
month\_start,

    COUNT(\*) AS row\_count

FROM dbo.YourTable

WHERE created\_on &gt;= @StartDate

  AND created\_on &lt;  @EndDate

GROUP BY DATEFROMPARTS(YEAR(created\_on), MONTH(created\_on), 1)

ORDER BY month\_start;

**5) Include months with zero rows (a calendar CTE)**

If you need to show months even when there were no rows, generate a
month series and left join:

DECLARE @StartMonth date = '2019-01-01';

DECLARE @EndMonth   date = DATEFROMPARTS(YEAR(GETDATE()),
MONTH(GETDATE()), 1); -- current month start

;WITH months AS (

    SELECT @StartMonth AS month\_start

    UNION ALL

    SELECT DATEADD(month, 1, month\_start)

    FROM months

    WHERE month\_start &lt; @EndMonth

)

SELECT

    m.month\_start,

    COUNT(t.created\_on) AS row\_count

FROM months AS m

LEFT JOIN dbo.YourTable AS t

    ON t.created\_on &gt;= m.month\_start

   AND t.created\_on &lt;  DATEADD(month, 1, m.month\_start)

GROUP BY m.month\_start

ORDER BY m.month\_start

OPTION (MAXRECURSION 0);

**Performance tips**

-   **Index**: If you run this often, a nonclustered index on
    created\_on helps a lot: CREATE INDEX IX\_YourTable\_created\_on ON
    dbo.YourTable(created\_on); If you also select other columns in the
    future (e.g., to break down counts), consider INCLUDE (...) to cover
    the query.

-   **Data type**: If created\_on is datetimeoffset and you care about
    *local* month boundaries, convert to your local time before
    grouping:

-- Example: convert to Central Time (adjust to your TZ or use AT TIME
ZONE logic)

SELECT

    DATEFROMPARTS(YEAR(created\_on AT TIME ZONE 'UTC' AT TIME ZONE
'Central Standard Time'),

                  MONTH(created\_on AT TIME ZONE 'UTC' AT TIME ZONE
'Central Standard Time'), 1) AS month\_start\_local,

    COUNT(\*) AS row\_count

FROM dbo.YourTable

GROUP BY DATEFROMPARTS(YEAR(created\_on AT TIME ZONE 'UTC' AT TIME ZONE
'Central Standard Time'),

                       MONTH(created\_on AT TIME ZONE 'UTC' AT TIME ZONE
'Central Standard Time'), 1)

ORDER BY month\_start\_local;
