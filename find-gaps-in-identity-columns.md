Here's a query using a gaps-and-islands approach with `LEAD()`:

```sql
SELECT
    id AS gap_start,
    next_id AS gap_end,
    next_id - id - 1 AS missing_count
FROM (
    SELECT
        id,
        LEAD(id) OVER (ORDER BY id) AS next_id
    FROM dbo.YourTable
) t
WHERE next_id - id > 1
ORDER BY id;
```

Replace `dbo.YourTable` and `id` with your actual table/column names.

- `gap_start` / `gap_end` show the values bracketing each gap (e.g., 5 and 9 means 6, 7, 8 are missing).
- `missing_count` is how many IDs are missing in that gap.

If you also want to check for a gap at the very start (before the minimum value) or verify the sequence against an expected range, let me know your starting value and I can extend the query.

```sql
DECLARE @StartValue INT = 123;

SELECT
    gap_start,
    gap_end,
    gap_end - gap_start - 1 AS missing_count
FROM (
    SELECT
        ISNULL(LAG(id) OVER (ORDER BY id), @StartValue - 1) AS gap_start,
        id AS gap_end
    FROM dbo.YourTable
) t
WHERE gap_end - gap_start > 1
ORDER BY gap_start;
```

This treats `@StartValue - 1` as the "previous" value before the first row, so if the table's minimum `id` isn't `123`, that's reported as a gap too. Replace `dbo.YourTable` and `id` with your actual names.

```sql
DECLARE @StartValue INT = 123;
DECLARE @EndValue INT = 9999;

SELECT
    gap_start,
    gap_end,
    gap_end - gap_start - 1 AS missing_count
FROM (
    SELECT
        ISNULL(LAG(id) OVER (ORDER BY id), @StartValue - 1) AS gap_start,
        id AS gap_end
    FROM dbo.YourTable
    WHERE id BETWEEN @StartValue AND @EndValue

    UNION ALL

    SELECT
        MAX(id),
        @EndValue + 1
    FROM dbo.YourTable
    WHERE id BETWEEN @StartValue AND @EndValue
) t
WHERE gap_end - gap_start > 1
ORDER BY gap_start;
```

This checks for gaps within the `@StartValue`–`@EndValue` range, including a missing range at the very start (before the first row) and at the very end (after the last row, up to `@EndValue`). Replace `dbo.YourTable` and `id` with your actual names.
