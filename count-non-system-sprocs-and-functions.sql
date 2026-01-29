Option 1: Using sys.objects
Copy the code
SELECT 
    COUNT(*) AS NonSystemProceduresAndFunctions
FROM 
    sys.objects
WHERE 
    (type IN ('P', 'FN', 'IF', 'TF')) -- P: Stored Procedure, FN: Scalar Function, IF: Inline Table-Valued Function, TF: Table-Valued Function
    AND is_ms_shipped = 0; -- Exclude system objects

Option 2: Using sys.procedures and sys.objects for functions
Copy the code
-- Count stored procedures
SELECT 
    COUNT(*) AS NonSystemProcedures
FROM 
    sys.procedures
WHERE 
    is_ms_shipped = 0;

-- Count functions
SELECT 
    COUNT(*) AS NonSystemFunctions
FROM 
    sys.objects
WHERE 
    type IN ('FN', 'IF', 'TF') -- FN: Scalar Function, IF: Inline Table-Valued Function, TF: Table-Valued Function
    AND is_ms_shipped = 0;

Option 3: Using INFORMATION_SCHEMA.ROUTINES
SELECT ROUTINE_TYPE, COUNT(*) AS NonSystemProceduresAndFunctions
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_TYPE IN ('PROCEDURE', 'FUNCTION')
GROUP BY ROUTINE_TYPE;


These queries ensure system objects are excluded and focus only on user-defined stored procedures and functions.