/* Get active employees */
USE SLIS
GO

SELECT TOP 1000 *
FROM d_garnish dg
    JOIN pos p ON p.per_id = dg.per_id
     AND p.termdt IS NULL
WHERE fromdt >= '2025-07-01 00:00:00';