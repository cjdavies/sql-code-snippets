/* Example of history table and triggers to track changes in source data */
CREATE TABLE [dbo].[employee_occupation_history]
(
    [employee_occupation_history_id] [bigint]       IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [employee_occupation_id]         [bigint]       NOT NULL,
    [per_id]                         [int]          NOT NULL,
    [cpny_id]                        [int]          NOT NULL,
    [soc_id]                         [int]          NOT NULL,
    [effective_start_date]           [datetime2](7) NOT NULL,
    [effective_end_date]             [datetime2](7) NOT NULL,
    [created_on]                     [datetime2](7) NOT NULL,
    [created_by]                     [varchar](50)  NOT NULL,
    [last_modified_on]               [datetime2](7) NOT NULL,
    [last_modified_by]               [varchar](50)  NOT NULL,
    [enter_time]                     [datetime2](7) NOT NULL,
    [action]                         [char](1)      NOT NULL,
    CONSTRAINT [PK_employee_occupation_history] PRIMARY KEY CLUSTERED 
    (
    	[employee_occupation_history_id] ASC
    )
);
GO

CREATE TABLE [dbo].[employee_occupation]
(
    [employee_occupation_id] [bigint]       IDENTITY(1,1) NOT NULL,
    [per_id]                 [int]          NOT NULL,
    [cpny_id]                [int]          NOT NULL,
    [soc_id]                 [int]          NOT NULL,
    [effective_start_date]   [datetime2](7) NOT NULL,
    [effective_end_date]     [datetime2](7) NOT NULL,
    [created_on]             [datetime2](7) NOT NULL,
    [created_by]             [varchar](50)  NOT NULL,
    [last_modified_on]       [datetime2](7) NOT NULL,
    [last_modified_by]       [varchar](50)  NOT NULL,
    CONSTRAINT [PK_employee_occupation] PRIMARY KEY CLUSTERED 
    (
    	[employee_occupation_id] ASC
    )
);
GO

/* DELETE trigger */
CREATE TRIGGER [dbo].[employee_occupation_delete_trig]
ON [dbo].[employee_occupation]
AFTER DELETE
AS
BEGIN

    INSERT [dbo].[employee_occupation_history]
        ([employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], [enter_time], [action])
    SELECT [employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], SYSDATETIME(), 'D'
    FROM deleted;

END;
GO

ALTER TABLE [dbo].[employee_occupation] ENABLE TRIGGER [employee_occupation_delete_trig];
GO

/* INSERT trigger */
CREATE TRIGGER [dbo].[employee_occupation_insert_trig]
ON [dbo].[employee_occupation]
AFTER INSERT
AS
BEGIN

    INSERT [dbo].[employee_occupation_history]
        ([employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], [enter_time], [action])
    SELECT [employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], SYSDATETIME(), 'I'
    FROM inserted;

END;
GO

ALTER TABLE [dbo].[employee_occupation] ENABLE TRIGGER [employee_occupation_insert_trig];
GO

/* UPDATE trigger */
CREATE TRIGGER [dbo].[employee_occupation_update_trig]
ON [dbo].[employee_occupation]
AFTER UPDATE
AS
BEGIN

    INSERT [dbo].[employee_occupation_history]
        ([employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], [enter_time], [action])
    SELECT [employee_occupation_id], [per_id], [cpny_id], [soc_id], [effective_start_date], [effective_end_date], [created_on], [created_by], [last_modified_on], [last_modified_by], SYSDATETIME(), 'U'
    FROM inserted;

END;
GO

ALTER TABLE [dbo].[employee_occupation] ENABLE TRIGGER [employee_occupation_update_trig];
GO
