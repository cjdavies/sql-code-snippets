/* List Completed Releases */
USE OctopusDeployITA;
GO

DECLARE @start_date DATETIMEOFFSET(7) = '2025-07-14 00:00:00.0000000 +00:00';

SELECT      LEFT(LTRIM(
                 RTRIM(
                 RIGHT(JSON_VALUE(ngp.[JSON], N'$.Description'), LEN(JSON_VALUE(ngp.[JSON], N'$.Description'))
                                                                 - (CHARINDEX(
                                                                    'RFC',
                                                               JSON_VALUE(ngp.[JSON], N'$.Description'))
                                                                    + LEN('RFC'))))), 50)                                       AS RFC,
			p.name                                                                      AS ProjectName,
            p.slug                                                                      AS ProjectSlug,
            st.CompletedTime,
            st.[State]                                                                          AS TaskState,
            LEFT(st.[Description], 50)                                                          AS TaskDescription,
            LEFT(JSON_VALUE(JSON_QUERY(r.[JSON], '$."SelectedPackages"[0]'), N'$.Version'), 50) AS PackageVersion
       FROM dbo.Release               AS r
       JOIN Project                  AS p
         ON r.ProjectId = p.id
       JOIN dbo.Deployment            AS d
         ON r.Id = d.ReleaseId
            AND p.id = d.ProjectId
       JOIN dbo.DeploymentProcess     AS dp
         ON p.DeploymentProcessId = dp.Id
       JOIN dbo.ServerTask            AS st
         ON d.TaskId = st.Id
       JOIN dbo.DeploymentEnvironment AS de
         ON st.EnvironmentId = de.Id
		LEFT JOIN dbo.NuGetPackage AS ngp
      ON p.Name = ngp.PackageId
       AND LEFT(JSON_VALUE(JSON_QUERY(r.[JSON], '$."SelectedPackages"[0]'), N'$.Version'), 50) = ngp.[Version]
      WHERE CompletedTime >= @start_date
			AND r.SpaceId = 'Spaces-2'
            AND st.[State] = N'Success'
            AND st.[Description] LIKE CONCAT(N'Deploy ', p.name, N' release%')
            AND de.[Name] LIKE 'Prod%'
      ORDER BY ProjectName, CompletedTime;