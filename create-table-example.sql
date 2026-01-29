CREATE TABLE [dbo].[InvoiceIntegrationBatch] (
    [Id]                 INT            IDENTITY (1, 1) NOT NULL,
    [IntegrationEventId] INT            NOT NULL,
    [Url]                NVARCHAR (256) NOT NULL,
    [FileName]           NVARCHAR (256) NULL,
    [Status]             NVARCHAR (20)  NOT NULL,
    [FileSize]           BIGINT         NOT NULL,
    [UploadDate]         DATETIME2      NOT NULL,
    [ContentType]        NVARCHAR (100) NOT NULL,
    [DocumentNumber]     NVARCHAR (100) NOT NULL,
    [EventWID]           NVARCHAR (100) NOT NULL,
    [EventFileName]      NVARCHAR (100) NOT NULL,
    [IsFinalBatch]       BIT            NOT NULL,
    [IsReposted]         BIT            NOT NULL,
    [CreateDate]         DATETIME2      CONSTRAINT [DF01_InvoiceIntegrationBatch] DEFAULT (sysdatetime()) NOT NULL,
    [UpdateDate]         DATETIME2      CONSTRAINT [DF02_InvoiceIntegrationBatch] DEFAULT (sysdatetime()) NOT NULL,
    CONSTRAINT [PK_InvoiceIntegrationBatch]   PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK01_InvoiceIntegrationBatch] FOREIGN KEY ([IntegrationEventId]) REFERENCES [dbo].[InvoiceIntegrationEvent] ([Id]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [IX01_InvoiceIntegrationBatch]
    ON [dbo].[InvoiceIntegrationBatch]([IntegrationEventId] ASC);
