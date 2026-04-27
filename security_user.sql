/* Toggle security policy for viewing test results 
ALTER SECURITY POLICY security_user_policy WITH (STATE = OFF);
ALTER SECURITY POLICY security_user_policy WITH (STATE = ON);
*/
USE [DEMO]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[security_user](
	[tenant_id] [dbo].[dtID] NOT NULL,
    [user_id] [dbo].[dtID] IDENTITY(1,1) NOT NULL,
	[any_company_flag] [dbo].[dtFLAG] NOT NULL,
	[auto_exception_flag] [dbo].[dtFLAG] NOT NULL,
	[change_pwd_flag] [dbo].[dtFLAG] NOT NULL,
	[company_id] [dbo].[dtID] NOT NULL,
	[disabled_flag] [dbo].[dtFLAG] NOT NULL,
	[email_address] [dbo].[dtEMAIL] NOT NULL,
	[employee_filter] [dbo].[dtFILTER] NOT NULL,
	[employee_id] [dbo].[dtID] NOT NULL,
	[ip_address_flag] [dbo].[dtFLAG] NOT NULL,
	[mandatory_filter_flag] [dbo].[dtFLAG] NOT NULL,
	[max_period_future] [smallint] NULL,
	[max_period_past] [smallint] NULL,
	[password] [dbo].[dtPASSWORD] NOT NULL,
	[timeout] [dbo].[dtNUMBER] NOT NULL,
	[user_name] [varchar](32) NOT NULL,
	[autolock_timestamp] [dbo].[dtTIMESTAMP] NOT NULL,
	[login_attempts] [dbo].[dtNUMBER] NOT NULL,
	[security_type_id] [dbo].[dtID] NOT NULL,
	[lockout_status] [dbo].[dtSTATUS] NOT NULL,
	[filter_node_id] [dbo].[dtID] NOT NULL,
	[encryption_factor] [dbo].[dtNUMBER] NOT NULL,
	[lockdown_flag] [dbo].[dtFLAG] NOT NULL,
	[mobile_profile_id] [dbo].[dtID] NOT NULL
 CONSTRAINT [pk_security_user] PRIMARY KEY CLUSTERED 
(
	[tenant_id] ASC,
    [user_id] ASC
) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[security_user] ON 
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, -3, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'ITA_INTEGRATION', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, -2, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'NSP_SUPER', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 5, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, -1, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'ServiceViewOnlyAdmin', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 5, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 0, 0, 0, 0, 0, 0, N'', N'', 0, 0, 0, 0, 0, N'c4ca4238a0b923820dcc509a6f75849b', 0, N'NO USER', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 1, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'MASTER', CAST(N'2025-02-13T16:58:55.597' AS DateTime), 1, 2, N'U', 0, 5, 1, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 2, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'Xx3kKjGWtdiGYBoATvLeyhEAAEZoSh.', 9999, N'ADMIN', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 1, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 3, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 99, 99, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'BatchLogin4HistoricalDataRefresh', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 4, 0, 0, 0, 1, 0, N'', N'', 4, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'ANDYA', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 5, 0, 0, 0, 1, 0, N'', N'', 1, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'BOBE', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 6, 0, 0, 0, 1, 0, N'', N'', 2, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'JOHNE', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 7, 0, 0, 0, 1, 0, N'', N'', 3, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'SARAS', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1001, 8, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 99, 99, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'TE_BATCH_REPORTS', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
GO
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, -3, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'ITA_INTEGRATION', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, -2, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'NSP_SUPER', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 5, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, -1, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'ServiceViewOnlyAdmin', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 5, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 0, 0, 0, 0, 0, 0, N'', N'', 0, 0, 0, 0, 0, N'c4ca4238a0b923820dcc509a6f75849b', 0, N'NO USER', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 1, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'MASTER', CAST(N'2025-02-13T16:58:55.597' AS DateTime), 1, 2, N'U', 0, 5, 1, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 2, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 9999, 9999, N'Xx3kKjGWtdiGYBoATvLeyhEAAEZoSh.', 9999, N'ADMIN', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 1, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 3, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 99, 99, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'BatchLogin4HistoricalDataRefresh', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 4, 0, 0, 0, 1, 0, N'', N'', 4, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'ANDYA', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 5, 0, 0, 0, 1, 0, N'', N'', 1, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'BOBE', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 6, 0, 0, 0, 1, 0, N'', N'', 2, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'JOHNE', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 7, 0, 0, 0, 1, 0, N'', N'', 3, 0, 0, -99, -99, N'c4ca4238a0b923820dcc509a6f75849b', -99, N'SARAS', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
INSERT [dbo].[security_user] ([tenant_id], [user_id], [any_company_flag], [auto_exception_flag], [change_pwd_flag], [company_id], [disabled_flag], [email_address], [employee_filter], [employee_id], [ip_address_flag], [mandatory_filter_flag], [max_period_future], [max_period_past], [password], [timeout], [user_name], [autolock_timestamp], [login_attempts], [security_type_id], [lockout_status], [filter_node_id], [encryption_factor], [lockdown_flag], [mobile_profile_id]) VALUES (1002, 8, 1, 0, 0, 0, 0, N'', N'', 0, 0, 0, 99, 99, N'c4ca4238a0b923820dcc509a6f75849b', 9999, N'TE_BATCH_REPORTS', CAST(N'1900-01-01T00:00:00.000' AS DateTime), 0, 2, N'U', 0, 5, 0, 0)
GO
SET IDENTITY_INSERT [dbo].[security_user] OFF
GO

ALTER TABLE [dbo].[security_user]
    ADD CONSTRAINT df_tenant_id_security_user
    DEFAULT CAST(SESSION_CONTEXT(N'tenant_id') AS INT) FOR tenant_id;
GO

ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_AutoLckTs]  DEFAULT ('1900-01-01') FOR [autolock_timestamp]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_LgnAtmps]  DEFAULT ((0)) FOR [login_attempts]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_SecTypId]  DEFAULT ((2)) FOR [security_type_id]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_LckOStat]  DEFAULT ('U') FOR [lockout_status]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_FiltNdId]  DEFAULT ((0)) FOR [filter_node_id]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_NcrptFctr]  DEFAULT ((5)) FOR [encryption_factor]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_LokdwnFlg]  DEFAULT ((0)) FOR [lockdown_flag]
GO
ALTER TABLE [dbo].[security_user] ADD  CONSTRAINT [df_SecUsr_MobProflId]  DEFAULT ((0)) FOR [mobile_profile_id]
GO
ALTER TABLE [dbo].[security_user]  WITH CHECK ADD  CONSTRAINT [fk_SecUsr_MobProfl] FOREIGN KEY([mobile_profile_id])
REFERENCES [dbo].[mobile_profile] ([mobile_profile_id])
GO
ALTER TABLE [dbo].[security_user] CHECK CONSTRAINT [fk_SecUsr_MobProfl]
GO
ALTER TABLE [dbo].[security_user]  WITH CHECK ADD  CONSTRAINT [fk_SecUsr_RefLkOStat] FOREIGN KEY([lockout_status])
REFERENCES [dbo].[ref_lockout_status] ([lockout_status])
GO
ALTER TABLE [dbo].[security_user] CHECK CONSTRAINT [fk_SecUsr_RefLkOStat]
GO
ALTER TABLE [dbo].[security_user]  WITH CHECK ADD  CONSTRAINT [fk_SecUsr_RefSecTyp] FOREIGN KEY([security_type_id])
REFERENCES [dbo].[ref_security_type] ([security_type_id])
GO
ALTER TABLE [dbo].[security_user] CHECK CONSTRAINT [fk_SecUsr_RefSecTyp]
GO
ALTER TABLE [dbo].[security_user]  WITH CHECK ADD  CONSTRAINT [security_user_FK1_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[security_user] CHECK CONSTRAINT [security_user_FK1_company]
GO
ALTER TABLE [dbo].[security_user]  WITH CHECK ADD  CONSTRAINT [security_user_FK2_employee] FOREIGN KEY([employee_id])
REFERENCES [dbo].[employee] ([employee_id])
GO
ALTER TABLE [dbo].[security_user] CHECK CONSTRAINT [security_user_FK2_employee]
GO
