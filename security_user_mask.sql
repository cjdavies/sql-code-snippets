/* Toggle security policy for viewing test results 
ALTER SECURITY POLICY security_user_mask_policy WITH (STATE = OFF); -- Disable security policy
ALTER SECURITY POLICY security_user_mask_policy WITH (STATE = ON);  -- Enable security policy
*/
USE [DEMO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[security_user_mask](
	[tenant_id] [dbo].[dtID] NOT NULL,
    [user_id] [dbo].[dtID] NOT NULL,
	[security_mask_id] [dbo].[dtID] NOT NULL,
	[access_code] [dbo].[dtCODE] NOT NULL
 CONSTRAINT [pk_security_user_mask] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
    [user_id] ASC,
	[security_mask_id] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1001, -3, 0, N'V')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1001, -2, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1001, 1, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1001, 2, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1001, 8, 0, N'D')
GO
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1002, -3, 0, N'V')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1002, -2, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1002, 1, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1002, 2, 0, N'D')
INSERT [dbo].[security_user_mask] ([tenant_id], [user_id], [security_mask_id], [access_code]) VALUES (1002, 8, 0, N'D')
GO

ALTER TABLE [dbo].[security_user_mask]
    ADD CONSTRAINT df_tenant_id_security_user_mask
    DEFAULT CAST(SESSION_CONTEXT(N'tenant_id') AS INT) FOR tenant_id;
GO


/*
ALTER TABLE [dbo].[security_user_mask]  WITH CHECK ADD  CONSTRAINT [sec_usr_msk_FK3_ref_acc_cod] FOREIGN KEY([access_code])
REFERENCES [dbo].[ref_access_code] ([access_code])
GO
ALTER TABLE [dbo].[security_user_mask] CHECK CONSTRAINT [sec_usr_msk_FK3_ref_acc_cod]
GO
ALTER TABLE [dbo].[security_user_mask]  WITH CHECK ADD  CONSTRAINT [security_user_mask_FK1_sec_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[security_user] ([user_id])
GO
ALTER TABLE [dbo].[security_user_mask] CHECK CONSTRAINT [security_user_mask_FK1_sec_user]
GO
ALTER TABLE [dbo].[security_user_mask]  WITH CHECK ADD  CONSTRAINT [security_user_mask_FK2_sec_mask] FOREIGN KEY([security_mask_id])
REFERENCES [dbo].[security_mask] ([security_mask_id])
GO
ALTER TABLE [dbo].[security_user_mask] CHECK CONSTRAINT [security_user_mask_FK2_sec_mask]
GO
*/