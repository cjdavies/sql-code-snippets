BEGIN
    WITH PruneEvents
      AS (
         SELECT TOP (@BatchSize)
                e.UserAuthorizationEventId
           FROM dbo.UserAuthorizationEvent AS e
          WHERE e.CreatedDate <= @MaxDeleteDate
          ORDER BY UpdatedDate ASC, e.PublishedDate ASC
         )
    DELETE FROM PruneEvents;
    SELECT @DeletedCount = @@ROWCOUNT;
END;