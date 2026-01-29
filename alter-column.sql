/* Increase column size from 65 to 130 */
ALTER TABLE SLIS.dbo.d_garnish
    ALTER COLUMN description VARCHAR(130);
    
ALTER TABLE SLIS.dbo.d_garnish_audit
    ALTER COLUMN description VARCHAR(130);

/* Rollback code for above */
-- Step 1: Check for oversized data
IF EXISTS (
    SELECT 1
    FROM SLIS.dbo.d_garnish
    WHERE LEN(description) > 65
) 
BEGIN
    PRINT 'Warning: Some data in d_garnish.description exceeds 65 characters and will be truncated.';
END

-- Step 2: Truncate data if necessary
UPDATE SLIS.dbo.d_garnish
SET description = LEFT(description, 65)
WHERE LEN(description) > 65;

-- Step 3: Alter the column size
ALTER TABLE SLIS.dbo.d_garnish
    ALTER COLUMN description VARCHAR(65);

-- Step 1: Check for oversized data
IF EXISTS (
    SELECT 1
    FROM SLIS.dbo.d_garnish_audit
    WHERE LEN(description) > 65
) 
BEGIN
    PRINT 'Warning: Some data in d_garnish_audit.description exceeds 65 characters and will be truncated.';
END

-- Step 2: Truncate data if necessary
UPDATE SLIS.dbo.d_garnish_audit
SET description = LEFT(description, 65)
WHERE LEN(description) > 65;

-- Step 3: Alter the column size
ALTER TABLE SLIS.dbo.d_garnish_audit
    ALTER COLUMN description VARCHAR(65);
