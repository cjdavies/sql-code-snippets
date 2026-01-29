USE OctopusDeployITA
GO
    DECLARE @LastDemoDate DATE = '12/05/2025' --<-- put your date here. 
SELECT
    PROD.ProjectName,
    PROD.Version,
    Prod.ODDBLink,
    PROD.ProductionDeployment,
    PROD.PRODTaskState,
    DemoDeployment = ISNULL(DEMO.ProjectName, '*missing*') --, RowNum --, DEMO.DemoTaskState 
FROM
    (
        SELECT
            [project].[Name] AS ProjectName,
            [release].[Version] AS Version,
            'http://oddb.insperity.com/Octopus/app#/Spaces-1/projects/' + [project].[Slug] + '/deployments/releases/' + [release].[Version] AS ODDBLink,
            CONVERT(
                datetime,
                SWITCHOFFSET(
                    CONVERT(datetimeoffset, [task].[CompletedTime]),
                    DATENAME(TzOffset, SYSDATETIMEOFFSET())
                )
            ) AS ProductionDeployment,
            [task].[State] AS PRODTaskState,
            RowNum = ROW_NUMBER () OVER (
                PARTITION BY [project].[Name],
                [release].[Version]
                ORDER BY
                    CONVERT(
                        datetime,
                        SWITCHOFFSET(
                            CONVERT(datetimeoffset, [task].[CompletedTime]),
                            DATENAME(TzOffset, SYSDATETIMEOFFSET())
                        )
                    ) DESC
            )
        FROM
            [OctopusDeployITA].[dbo].[Release] release
            INNER JOIN [OctopusDeployITA].[dbo].[Project] project ON [release].[ProjectId] = [project].[Id]
            INNER JOIN [OctopusDeployITA].[dbo].[Deployment] deployment ON [release].[Id] = [deployment].[ReleaseId]
            AND [project].[Id] = [deployment].[ProjectId]
            INNER JOIN [OctopusDeployITA].[dbo].[ServerTask] task ON [deployment].[TaskId] = [task].[Id]
            INNER JOIN [OctopusDeployITA].[dbo].[DeploymentEnvironment] environment ON [environment].[Id] = [task].[EnvironmentId]
        WHERE
            [environment].NAME LIKE 'PROD_%'
            AND [project].[Name] NOT LIKE '%obsolete%'
            AND CONVERT(DATE, [task].[CompletedTime]) > @LastDemoDate ----last Demo deployment 
            --EXCLUDE All but TWO BI Projects 
            AND [project].[Name] NOT IN (
                SELECT
                    DISTINCT [project].[Name] AS ProjectName
                FROM
                    [OctopusDeployITA].[dbo].[Project] project
                WHERE
                    project.ProjectGroupId = 'ProjectGroups-141'
                    AND project.[Name] NOT IN ('DSS_RPTG_DATA_MART', 'stg_RDM')
            )
    ) Prod
    LEFT JOIN (
        SELECT
            [project].[Name] AS ProjectName,
            [release].[Version] AS Version,
            'http://oddb.insperity.com/Octopus/app#/Spaces-1/projects/' + [project].[Slug] + '/deployments/releases/' + [release].[Version] AS ODDBLink,
            CONVERT(
                datetime,
                SWITCHOFFSET(
                    CONVERT(datetimeoffset, [task].[CompletedTime]),
                    DATENAME(TzOffset, SYSDATETIMEOFFSET())
                )
            ) AS DemoDeployment,
            [task].[State] AS DemoTaskState
        FROM
            [OctopusDeployITA].[dbo].[Release] release
            INNER JOIN [OctopusDeployITA].[dbo].[Project] project ON [release].[ProjectId] = [project].[Id]
            INNER JOIN [OctopusDeployITA].[dbo].[Deployment] deployment ON [release].[Id] = [deployment].[ReleaseId]
            AND [project].[Id] = [deployment].[ProjectId]
            INNER JOIN [OctopusDeployITA].[dbo].[ServerTask] task ON [deployment].[TaskId] = [task].[Id]
            INNER JOIN [OctopusDeployITA].[dbo].[DeploymentEnvironment] environment ON [environment].[Id] = [task].[EnvironmentId]
        WHERE
            [environment].Name LIKE '%DEMO%'
            AND [project].[Name] NOT LIKE '%obsolete%'
            AND task.State = 'Success'
            AND CONVERT(DATE, [task].[CompletedTime]) > @LastDemoDate ----last Demo deployment 
    ) Demo ON PROD.ProjectName = DEMO.ProjectName
    AND Prod.[Version] = Demo.[Version]
WHERE
    DEMO.DemoDeployment IS NULL
    AND PROD.RowNum = 1
    AND PROD.PRODTaskState = 'Success'
    AND NOT (
        Prod.ProjectName = 'SLIS'
        AND PROD.[Version] IN ('1.0.749', '1.0.466')
    )
    AND NOT (
        Prod.ProjectName = 'ChcChangeAdmin'
        AND PROD.Version = '1.1.89'
    ) -- EXCLUDE environments without DEMO 
    AND Prod.ProjectName NOT IN (
        'South Caroline Benefit Option DataFix',
        'Blackbird',
        'SalesforceIntegration',
        'Salesforce',
        'TimeStarIntegration',
        'EnterpriseAudit_Archive',
        'NetSuite',
        'CodeAnalysis'
    )
    AND Prod.ProjectName NOT LIKE ('%_Direct')
ORDER BY
    Prod.ProjectName,
    PROD.ProductionDeployment;

GO