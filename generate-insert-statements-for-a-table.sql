/* Generate insert statements for a table */
SET NOCOUNT ON;

--------------------------------------------------------------------------------
-- CONFIGURE: date range and batch size (<= 1000 due to VALUES constructor limit)
--------------------------------------------------------------------------------
DECLARE @StartDate datetime2(7) = '2024-01-01T00:00:00';
DECLARE @EndDate   datetime2(7) = '2024-12-31T23:59:59.9999999';
DECLARE @BatchSize int          = 1000;

IF @BatchSize > 1000 SET @BatchSize = 1000;

-- Column list (explicit, matches table definition)
DECLARE @ColumnList nvarchar(max) = 
    N'[employee_occupation_id],[per_id],[cpny_id],[soc_id],[effective_start_date],[effective_end_date],[change_reason],[created_on],[created_by],[last_modified_on],[last_modified_by]';

--------------------------------------------------------------------------------
-- Build literal tokens per row (escape strings, ISO 8601 for datetime2)
-- Filter by effective period overlap:
--   effective_start_date <= @EndDate AND effective_end_date >= @StartDate
--------------------------------------------------------------------------------
;WITH src AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY employee_occupation_id) AS rn,

        -- tuple of literals in source order as NVARCHAR(MAX)
        tuple_values = CAST(
            CONCAT(
                -- employee_occupation_id (bigint identity)
                CASE WHEN employee_occupation_id IS NULL
                     THEN N'NULL' ELSE CONVERT(nvarchar(30), employee_occupation_id) END, N',',
                -- per_id (int)
                CASE WHEN per_id IS NULL
                     THEN N'NULL' ELSE CONVERT(nvarchar(11), per_id) END, N',',
                -- cpny_id (int)
                CASE WHEN cpny_id IS NULL
                     THEN N'NULL' ELSE CONVERT(nvarchar(11), cpny_id) END, N',',
                -- soc_id (int)
                CASE WHEN soc_id IS NULL
                     THEN N'NULL' ELSE CONVERT(nvarchar(11), soc_id) END, N',',
                -- effective_start_date (datetime2(7))
                CASE WHEN effective_start_date IS NULL
                     THEN N'NULL' ELSE N'''' + CONVERT(nvarchar(33), effective_start_date, 126) + N'''' END, N',',
                -- effective_end_date (datetime2(7))
                CASE WHEN effective_end_date IS NULL
                     THEN N'NULL' ELSE N'''' + CONVERT(nvarchar(33), effective_end_date, 126) + N'''' END, N',',
                -- change_reason (varchar(50))
                CASE WHEN change_reason IS NULL
                     THEN N'NULL' ELSE N'''' + REPLACE(CONVERT(nvarchar(max), change_reason), N'''', N'''''''') + N'''' END, N',',
                -- created_on (datetime2(7))
                CASE WHEN created_on IS NULL
                     THEN N'NULL' ELSE N'''' + CONVERT(nvarchar(33), created_on, 126) + N'''' END, N',',
                -- created_by (varchar(50))
                CASE WHEN created_by IS NULL
                     THEN N'NULL' ELSE N'''' + REPLACE(CONVERT(nvarchar(max), created_by), N'''', N'''''''') + N'''' END, N',',
                -- last_modified_on (datetime2(7))
                CASE WHEN last_modified_on IS NULL
                     THEN N'NULL' ELSE N'''' + CONVERT(nvarchar(33), last_modified_on, 126) + N'''' END, N',',
                -- last_modified_by (varchar(50))
                CASE WHEN last_modified_by IS NULL
                     THEN N'NULL' ELSE N'''' + REPLACE(CONVERT(nvarchar(max), last_modified_by), N'''', N'''''''') + N'''' END
            )
            AS nvarchar(max)
        )
    FROM dbo.employee_occupation
    WHERE effective_start_date <= @EndDate
      AND effective_end_date   >= @StartDate
),
b AS (
    SELECT
        rn,
        ((rn - 1) / @BatchSize) AS batch_id,
        -- Ensure NVARCHAR(MAX) for the VALUES tuple text
        CAST(N'(' + tuple_values + N')' AS nvarchar(max)) AS tuple_text
    FROM src
)
SELECT
    batch_id,
    -- Use NVARCHAR(MAX) concatenations and NCHAR for line breaks
    CAST(N'SET IDENTITY_INSERT [dbo].[employee_occupation] ON;' + NCHAR(13) + NCHAR(10) +
         N'INSERT INTO [dbo].[employee_occupation] (' + @ColumnList + N')' + NCHAR(13) + NCHAR(10) +
         N'SELECT ' + @ColumnList + N'' + NCHAR(13) + NCHAR(10) +
         N'FROM (VALUES ' +
             STRING_AGG(CAST(tuple_text AS nvarchar(max)), N',' + NCHAR(13) + NCHAR(10)) 
                 WITHIN GROUP (ORDER BY rn) +
         N') AS v(' + @ColumnList + N');' + NCHAR(13) + NCHAR(10) +
         N'SET IDENTITY_INSERT [dbo].[employee_occupation] OFF;'
         AS nvarchar(max)
    ) AS insert_statement
FROM b
GROUP BY batch_id
ORDER BY batch_id;
