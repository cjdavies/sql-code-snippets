DECLARE @Remainder INT
DECLARE @ChunkSize INT
SET @Remainder = (SELECT COUNT(id) FROM BigTable WHERE dtmtimestamp < DateAdd(month, -2, getdate()))
SET @ChunkSize = CEILING(@Remainder/100) /* Divide the total into 100 parts, whole integers only */
WHILE @Remainder BEGIN
    BEGIN TRANSACTION deletehistorical
    DELETE TOP (@ChunkSize)
    FROM BigTable
    WHERE dtmtimestamp < DateAdd(month, -2, getdate());
    SET @Remainder = @@ROWCOUNT;
    COMMIT TRANSACTION deletehistorical
END
