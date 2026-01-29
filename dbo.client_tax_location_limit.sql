USE SLIS;
GO

CREATE TABLE dbo.client_tax_location_limit (
    cpny_id             INT             NOT NULL,
    tax_location_limit  SMALLINT        NOT NULL,
    enter_time          DATETIME2(0)    NOT NULL,
    change_time         DATETIME2(0),
    CONSTRAINT pk_client_tax_location_limit PRIMARY KEY CLUSTERED (cpny_id ASC)
);

ALTER TABLE dbo.client_tax_location_limit ADD CONSTRAINT DF01_client_tax_location_limit DEFAULT (40) FOR tax_location_limit;
GO

ALTER TABLE dbo.client_tax_location_limit ADD CONSTRAINT DF02_client_tax_location_limit_enter_time DEFAULT (CAST(GETDATE() as DATETIME2(0))) FOR enter_time;
GO

ALTER TABLE dbo.client_tax_location_limit ADD CONSTRAINT CK01_tax_location_limit CHECK ((tax_location_limit > 10 AND tax_location_limit < 41));
GO

ALTER TABLE dbo.client_tax_location_limit ADD CONSTRAINT FK01_clnt_tax_loc_lim_company FOREIGN KEY(cpny_id)
REFERENCES dbo.company (cpny_id);
GO
