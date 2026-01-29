USE OctopusDeployITA;
GO

DECLARE @start_date DATETIMEOFFSET(7) = DATEADD(DAY, -8, SYSUTCDATETIME());

SELECT LEFT(LTRIM(
                RTRIM(
                    RIGHT(JSON_VALUE(ngp.[JSON], N'$.Description'), LEN(JSON_VALUE(ngp.[JSON], N'$.Description'))
                                                                    - (CHARINDEX(
                                                                       'RFC', JSON_VALUE(ngp.[JSON], N'$.Description'))
                                                                       + LEN('RFC'))))), 50) AS RFC,
       p.Name                                                                                AS ProjectName,
       p.Slug                                                                                AS ProjectSlug,
       st.CompletedTime,
       st.[State]                                                                            AS TaskState,
       LEFT(st.[Description], 50)                                                            AS TaskDescription,
       LEFT(JSON_VALUE(JSON_QUERY(r.[JSON], '$."SelectedPackages"[0]'), N'$.Version'), 50)   AS PackageVersion
  FROM dbo.Release               AS r
  JOIN Project                   AS p
    ON r.ProjectId = p.Id
  JOIN dbo.Deployment            AS d
    ON r.Id = d.ReleaseId
       AND p.Id = d.ProjectId
  JOIN dbo.DeploymentProcess     AS dp
    ON p.DeploymentProcessId = dp.Id
  JOIN dbo.ServerTask            AS st
    ON d.TaskId = st.Id
  JOIN dbo.DeploymentEnvironment AS de
    ON st.EnvironmentId = de.Id
  LEFT JOIN dbo.NuGetPackage     AS ngp
    ON p.Name = ngp.PackageId
       AND LEFT(JSON_VALUE(JSON_QUERY(r.[JSON], '$."SelectedPackages"[0]'), N'$.Version'), 50) = ngp.[Version]
 WHERE CompletedTime >= @start_date
       AND r.SpaceId = 'Spaces-2'
       AND st.[State] = N'Success'
       AND st.[Description] LIKE CONCAT(N'Deploy ', p.Name, N' release%')
       AND de.[Name] LIKE 'Prod%';
