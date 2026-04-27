/* Toggle security policy for viewing test results
ALTER SECURITY POLICY ref_access_code_policy WITH (STATE = OFF);
ALTER SECURITY POLICY ref_access_code_policy WITH (STATE = ON);
*/

USE [DEMO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ref_access_code](
    [tenant_id] [dbo].[dtID] NOT NULL,
    [access_code] [dbo].[dtCODE] NOT NULL,
	[description] [dbo].[dtSTRING] NOT NULL,
	[name] [dbo].[dtNAME] NOT NULL,

) ON [PRIMARY]
GO
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1001, N'A', N'Add/Edit/View', N'Add/Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1001, N'D', N'Delete/Add/Edit/View', N'Delete/Add/Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1001, N'E', N'Edit/View', N'Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1001, N'X', N'No Access', N'No Access')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1001, N'V', N'View data', N'View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1002, N'A', N'Add/Edit/View', N'Add/Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1002, N'D', N'Delete/Add/Edit/View', N'Delete/Add/Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1002, N'E', N'Edit/View', N'Edit/View')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1002, N'X', N'No Access', N'No Access')
INSERT [dbo].[ref_access_code] ([tenant_id], [access_code], [description], [name]) VALUES (1002, N'V', N'View data', N'View')
GO
SET ANSI_PADDING ON
GO

ALTER TABLE [dbo].[ref_access_code] ADD CONSTRAINT [pk_ref_access_code] PRIMARY KEY NONCLUSTERED 
(
	[tenant_id] ASC,
    [access_code] ASC
);
GO
ALTER TABLE [dbo].[ref_access_code]
    ADD CONSTRAINT df_tenant_id_ref_access_code
    DEFAULT CAST(SESSION_CONTEXT(N'tenant_id') AS INT) FOR tenant_id;
GO
