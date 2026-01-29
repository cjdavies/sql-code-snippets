ALTER TABLE [dbo].[exception_attendance] WITH CHECK ADD CONSTRAINT [exception_attendance_FK1_exception] FOREIGN KEY([exception_id]) 
REFERENCES [dbo].[exception] ([exception_id]) 
GO
ALTER TABLE [dbo].[calc_punch] WITH CHECK ADD CONSTRAINT [fk_CalcPnch_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[time_other_hours] WITH CHECK ADD CONSTRAINT [fk_TmOH_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[schedule_group_employee] WITH CHECK ADD CONSTRAINT [fk_SchdGrpEmp_SchdGrp] FOREIGN KEY([schedule_group_id]) 
REFERENCES [dbo].[schedule_group] ([schedule_group_id]) 
GO
ALTER TABLE [dbo].[ref_filter_operator] WITH CHECK ADD CONSTRAINT [fk_RefFiltOp_RefFiltNdTyp] FOREIGN KEY([node_type]) 
REFERENCES [dbo].[ref_filter_node_type] ([node_type]) 
GO
ALTER TABLE [dbo].[exception_attendance] WITH CHECK ADD CONSTRAINT [fk_ExcpAtt_TmPnch] FOREIGN KEY([punch_id]) 
REFERENCES [dbo].[time_punch] ([punch_id]) 
GO
ALTER TABLE [dbo].[calc_punch] WITH CHECK ADD CONSTRAINT [fk_CalcPnch_RefPnchCat] FOREIGN KEY([punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[time_other_hours] WITH CHECK ADD CONSTRAINT [fk_TmOH_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[schedule_group_employee] WITH CHECK ADD CONSTRAINT [sch_grp_emp_FK2_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[ref_holiday] WITH CHECK ADD CONSTRAINT [fk_RefHol_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[exception_attendance] WITH CHECK ADD CONSTRAINT [fk_ExcpAtt_TmPnch2] FOREIGN KEY([resolved_id]) 
REFERENCES [dbo].[time_punch] ([punch_id]) 
GO
ALTER TABLE [dbo].[calc_punch] WITH CHECK ADD CONSTRAINT [fk_CalcPnch_RefRndSrc] FOREIGN KEY([round_source]) 
REFERENCES [dbo].[ref_round_source] ([round_source]) 
GO
ALTER TABLE [dbo].[time_other_hours_over] WITH CHECK ADD CONSTRAINT [fk_TmOHOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[schedule_group_schedule] WITH CHECK ADD CONSTRAINT [fk_SchdGrpSchd_SchdGrp] FOREIGN KEY([schedule_group_id]) 
REFERENCES [dbo].[schedule_group] ([schedule_group_id]) 
GO
ALTER TABLE [dbo].[ref_input_device] WITH CHECK ADD CONSTRAINT [fk_RefInpDev_RefSrcCd] FOREIGN KEY([source_code]) 
REFERENCES [dbo].[ref_source_code] ([source_code]) 
GO
ALTER TABLE [dbo].[export_data_map] WITH CHECK ADD CONSTRAINT [exp_dta_map_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[calc_punch_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcPnchOL_CalcPnch] FOREIGN KEY([calc_punch_id]) 
REFERENCES [dbo].[calc_punch] ([calc_punch_id]) 
GO
ALTER TABLE [dbo].[time_other_hours_over] WITH CHECK ADD CONSTRAINT [fk_TmOHOvr_TmOH] FOREIGN KEY([other_hours_id]) 
REFERENCES [dbo].[time_other_hours] ([other_hours_id]) 
GO
ALTER TABLE [dbo].[schedule_group_schedule] WITH CHECK ADD CONSTRAINT [fk_SchdGrpSchd_SchdRul] FOREIGN KEY([schedule_rule_id]) 
REFERENCES [dbo].[schedule_rule] ([schedule_rule_id]) 
GO
ALTER TABLE [dbo].[ref_map_accrual_pay_type] WITH CHECK ADD CONSTRAINT [fk_RefMapAcrPayTyp_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[export_data_map] WITH CHECK ADD CONSTRAINT [exp_dta_map_FK2_ref_exp_dta_map] FOREIGN KEY([mapping_type]) 
REFERENCES [dbo].[ref_export_data_map] ([mapping_type]) 
GO
ALTER TABLE [dbo].[calc_schedule] WITH CHECK ADD CONSTRAINT [fk_CalcSchd_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[time_other_hours_script] WITH CHECK ADD CONSTRAINT [tim_oth_hrs_scr_FK1_tim_oth_hrs] FOREIGN KEY([other_hours_id]) 
REFERENCES [dbo].[time_other_hours] ([other_hours_id]) 
GO
ALTER TABLE [dbo].[schedule_rule] WITH CHECK ADD CONSTRAINT [fk_SchdRul_RefSchdTyp] FOREIGN KEY([schedule_type]) 
REFERENCES [dbo].[ref_schedule_type] ([schedule_type]) 
GO
ALTER TABLE [dbo].[ref_parameter] WITH CHECK ADD CONSTRAINT [fk_RefParm_RefParmCd] FOREIGN KEY([parameter_code]) 
REFERENCES [dbo].[ref_parameter_code] ([parameter_code]) 
GO
ALTER TABLE [dbo].[export_employee] WITH CHECK ADD CONSTRAINT [fk_ExpEmp_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_schedule_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcSchdOL_CalcSchd] FOREIGN KEY([calc_sched_id]) 
REFERENCES [dbo].[calc_schedule] ([calc_sched_id]) 
GO
ALTER TABLE [dbo].[time_other_hours_script] WITH CHECK ADD CONSTRAINT [time_oth_hrs_scr_FK2_ref_scr_typ] FOREIGN KEY([script_type]) 
REFERENCES [dbo].[ref_script_type] ([script_type]) 
GO
ALTER TABLE [dbo].[schedule_rule_over] WITH CHECK ADD CONSTRAINT [fk_SchdRulOvr_SchdRul] FOREIGN KEY([schedule_rule_id]) 
REFERENCES [dbo].[schedule_rule] ([schedule_rule_id]) 
GO
ALTER TABLE [dbo].[ref_parameter] WITH CHECK ADD CONSTRAINT [fk_RefParm_RefParmGetCd] FOREIGN KEY([parameter_get_code]) 
REFERENCES [dbo].[ref_parameter_get_code] ([parameter_get_code]) 
GO
ALTER TABLE [dbo].[export_event_info] WITH CHECK ADD CONSTRAINT [fk_ExportEventInfo_SecurityUser] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[calendar] WITH CHECK ADD CONSTRAINT [cal_FK1_ref_cal_cod] FOREIGN KEY([calendar_code]) 
REFERENCES [dbo].[ref_calendar_code] ([calendar_code]) 
GO
ALTER TABLE [dbo].[time_other_hours_script] WITH CHECK ADD CONSTRAINT [time_other_hours_script_FK3_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[script] WITH CHECK ADD CONSTRAINT [script_FK1_ref_script_type] FOREIGN KEY([script_type]) 
REFERENCES [dbo].[ref_script_type] ([script_type]) 
GO
ALTER TABLE [dbo].[ref_parameter] WITH CHECK ADD CONSTRAINT [fk_RefParm_RefParmSbct] FOREIGN KEY([category], [sub_category]) 
REFERENCES [dbo].[ref_parameter_subcategory] ([category], [sub_category]) 
GO
ALTER TABLE [dbo].[export_event_pay_group] WITH CHECK ADD CONSTRAINT [export_event_pay_group_FK1_export_event_info] FOREIGN KEY([export_event_info_id]) 
REFERENCES [dbo].[export_event_info] ([export_event_info_id]) 
GO
ALTER TABLE [dbo].[calendar] WITH CHECK ADD CONSTRAINT [cal_FK2_ref_cal_per_cod] FOREIGN KEY([calendar_period_code]) 
REFERENCES [dbo].[ref_calendar_period_code] ([calendar_period_code]) 
GO
ALTER TABLE [dbo].[time_punch] WITH CHECK ADD CONSTRAINT [fk_TmPnch_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[script_formula_log] WITH CHECK ADD CONSTRAINT [scr_frm_log_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[ref_parameter_list] WITH CHECK ADD CONSTRAINT [fk_RefParmLst_Parm] FOREIGN KEY([parameter]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[export_event_pay_group] WITH CHECK ADD CONSTRAINT [export_event_pay_group_FK2_pay_group] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[calendar] WITH CHECK ADD CONSTRAINT [cal_FK3_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[time_punch] WITH CHECK ADD CONSTRAINT [fk_TmPnch_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[script_line] WITH CHECK ADD CONSTRAINT [script_line_FK1_script] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[ref_parameter_list] WITH CHECK ADD CONSTRAINT [fk_RefParmLst_RefParmGetCd] FOREIGN KEY([parameter_get_code]) 
REFERENCES [dbo].[ref_parameter_get_code] ([parameter_get_code]) 
GO
ALTER TABLE [dbo].[export_history_ted] WITH CHECK ADD CONSTRAINT [FK_Export_History_Ted_Metadata_Export_Id] FOREIGN KEY([export_id]) 
REFERENCES [dbo].[export_history_ted_metadata] ([export_id]) 
GO
ALTER TABLE [dbo].[calendar_attendance] WITH CHECK ADD CONSTRAINT [cal_att_FK1_cal] FOREIGN KEY([calendar_id]) 
REFERENCES [dbo].[calendar] ([calendar_id]) 
GO
ALTER TABLE [dbo].[time_punch] WITH CHECK ADD CONSTRAINT [fk_TmPnch_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[script_line] WITH CHECK ADD CONSTRAINT [script_line_FK2_script_action] FOREIGN KEY([script_action]) 
REFERENCES [dbo].[script_action] ([script_action]) 
GO
ALTER TABLE [dbo].[ref_parameter_list] WITH CHECK ADD CONSTRAINT [ref_prm_lst_FK2_ref_prm_cod] FOREIGN KEY([parameter_code]) 
REFERENCES [dbo].[ref_parameter_code] ([parameter_code]) 
GO
ALTER TABLE [dbo].[export_history_ted_metadata_pay_group] WITH CHECK ADD CONSTRAINT [FK_Metadata_Export_Id] FOREIGN KEY([export_id]) 
REFERENCES [dbo].[export_history_ted_metadata] ([export_id]) 
GO
ALTER TABLE [dbo].[calendar_attendance] WITH CHECK ADD CONSTRAINT [cal_att_FK2_ref_att_cat] FOREIGN KEY([company_id], [attendance_category]) 
REFERENCES [dbo].[ref_attendance_category] ([company_id], [attendance_category]) 
GO
ALTER TABLE [dbo].[time_punch] WITH CHECK ADD CONSTRAINT [fk_TmPnch_RefPnchCat] FOREIGN KEY([punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[security_group] WITH CHECK ADD CONSTRAINT [fk_SecGrp_MobProfl] FOREIGN KEY([mobile_profile_id]) 
REFERENCES [dbo].[mobile_profile] ([mobile_profile_id]) 
GO
ALTER TABLE [dbo].[ref_parameter_map] WITH CHECK ADD CONSTRAINT [fk_RefParmMap_RefParm] FOREIGN KEY([parameter]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[export_mapping] WITH CHECK ADD CONSTRAINT [fk_ExpMap_RefExp] FOREIGN KEY([export_id]) 
REFERENCES [dbo].[ref_export] ([export_id]) 
GO
ALTER TABLE [dbo].[calendar_attendance] WITH CHECK ADD CONSTRAINT [cal_att_FK3_ref_col] FOREIGN KEY([color_id]) 
REFERENCES [dbo].[ref_color] ([color_id]) 
GO
ALTER TABLE [dbo].[time_punch] WITH CHECK ADD CONSTRAINT [fk_TmPnch_RefRndSrc] FOREIGN KEY([round_source]) 
REFERENCES [dbo].[ref_round_source] ([round_source]) 
GO
ALTER TABLE [dbo].[security_group] WITH CHECK ADD CONSTRAINT [fk_SecGrp_RefLkOStat] FOREIGN KEY([lockout_status]) 
REFERENCES [dbo].[ref_lockout_status] ([lockout_status]) 
GO
ALTER TABLE [dbo].[ref_parameter_notes] WITH CHECK ADD CONSTRAINT [fk_RefParmNotes_RefParm] FOREIGN KEY([parameter]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[export_mapping] WITH CHECK ADD CONSTRAINT [fk_ExpMap_RefExpDatMap] FOREIGN KEY([mapping_type]) 
REFERENCES [dbo].[ref_export_data_map] ([mapping_type]) 
GO
ALTER TABLE [dbo].[calendar_attendance] WITH CHECK ADD CONSTRAINT [cal_att_FK4_ref_dis_cod] FOREIGN KEY([display_code]) 
REFERENCES [dbo].[ref_display_code] ([display_code]) 
GO
ALTER TABLE [dbo].[time_punch_geolocation] WITH CHECK ADD CONSTRAINT [fk_TmPnchGloc_TmPnch] FOREIGN KEY([punch_id]) 
REFERENCES [dbo].[time_punch] ([punch_id]) 
GO
ALTER TABLE [dbo].[security_group] WITH CHECK ADD CONSTRAINT [security_group_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[ref_parameter_subcategory] WITH CHECK ADD CONSTRAINT [fk_RefParmSbct_RefParmCat] FOREIGN KEY([category]) 
REFERENCES [dbo].[ref_parameter_category] ([category]) 
GO
ALTER TABLE [dbo].[export_payroll_xmit_log] WITH CHECK ADD CONSTRAINT [fk_ExpPayrXmitLog_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[calendar_other_hours] WITH CHECK ADD CONSTRAINT [cal_oth_hrs_FK1_cal] FOREIGN KEY([calendar_id]) 
REFERENCES [dbo].[calendar] ([calendar_id]) 
GO
ALTER TABLE [dbo].[time_punch_over] WITH CHECK ADD CONSTRAINT [fk_TmPnchOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_group_dns] WITH CHECK ADD CONSTRAINT [fk_SecGrpDns_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[ref_parameter_type] WITH CHECK ADD CONSTRAINT [ref_prm_typ_FK1_ref_prm_cod] FOREIGN KEY([parameter_code]) 
REFERENCES [dbo].[ref_parameter_code] ([parameter_code]) 
GO
ALTER TABLE [dbo].[filter_left_operand_operator] WITH CHECK ADD CONSTRAINT [fk_FiltLtOpOp_FiltLtOp] FOREIGN KEY([left_operand_id]) 
REFERENCES [dbo].[filter_left_operand] ([left_operand_id]) 
GO
ALTER TABLE [dbo].[calendar_other_hours] WITH CHECK ADD CONSTRAINT [cal_oth_hrs_FK2_ref_pay_typ] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[time_punch_over] WITH CHECK ADD CONSTRAINT [fk_TmPnchOvr_TmPnch] FOREIGN KEY([punch_id]) 
REFERENCES [dbo].[time_punch] ([punch_id]) 
GO
ALTER TABLE [dbo].[security_group_dns] WITH CHECK ADD CONSTRAINT [fk_SecGrpDns_RefSecDns] FOREIGN KEY([company_id], [dns_name]) 
REFERENCES [dbo].[ref_security_dns] ([company_id], [dns_name]) 
GO
ALTER TABLE [dbo].[ref_parameter_value] WITH CHECK ADD CONSTRAINT [fk_RefParmVal_RefParmTyp] FOREIGN KEY([parameter_type]) 
REFERENCES [dbo].[ref_parameter_type] ([parameter_type]) 
GO
ALTER TABLE [dbo].[filter_left_operand_operator] WITH CHECK ADD CONSTRAINT [fk_FiltLtOpOp_RefFiltOp] FOREIGN KEY([operator]) 
REFERENCES [dbo].[ref_filter_operator] ([operator]) 
GO
ALTER TABLE [dbo].[calendar_other_hours] WITH CHECK ADD CONSTRAINT [cal_oth_hrs_FK3_ref_col] FOREIGN KEY([color_id]) 
REFERENCES [dbo].[ref_color] ([color_id]) 
GO
ALTER TABLE [dbo].[time_punch_script] WITH CHECK ADD CONSTRAINT [fk_TmPnchScr_TmPnch] FOREIGN KEY([punch_id]) 
REFERENCES [dbo].[time_punch] ([punch_id]) 
GO
ALTER TABLE [dbo].[security_group_dns] WITH CHECK ADD CONSTRAINT [fk_SecGrpDns_SecGrp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_password_rule] WITH CHECK ADD CONSTRAINT [fk_RefPwdRul_RefSecTyp] FOREIGN KEY([default_security_type_id]) 
REFERENCES [dbo].[ref_security_type] ([security_type_id]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[calendar_other_hours] WITH CHECK ADD CONSTRAINT [cal_oth_hrs_FK4_ref_dis_cod] FOREIGN KEY([display_code]) 
REFERENCES [dbo].[ref_display_code] ([display_code]) 
GO
ALTER TABLE [dbo].[time_punch_script] WITH CHECK ADD CONSTRAINT [time_punch_script_FK2_ref_script_type] FOREIGN KEY([script_type]) 
REFERENCES [dbo].[ref_script_type] ([script_type]) 
GO
ALTER TABLE [dbo].[security_group_filter] WITH CHECK ADD CONSTRAINT [sec_grp_fil_FK1_sec_grp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_pay_type] WITH CHECK ADD CONSTRAINT [ref_pay_typ_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_FiltLtOp] FOREIGN KEY([left_operand_id]) 
REFERENCES [dbo].[filter_left_operand] ([left_operand_id]) 
GO
ALTER TABLE [dbo].[calendar_pay_exclude] WITH CHECK ADD CONSTRAINT [cal_pay_exc_FK1_cal] FOREIGN KEY([calendar_id]) 
REFERENCES [dbo].[calendar] ([calendar_id]) 
GO
ALTER TABLE [dbo].[time_punch_script] WITH CHECK ADD CONSTRAINT [time_punch_script_FK3_script] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[security_group_group] WITH CHECK ADD CONSTRAINT [security_grp_grp_FK1_sec_grp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_performance_test] WITH CHECK ADD CONSTRAINT [fk_RefPerfTst_RefPerfUnit] FOREIGN KEY([unit_of_measurement_code]) 
REFERENCES [dbo].[ref_performance_unit] ([unit_of_measurement_code]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_FiltNd1] FOREIGN KEY([left_node_id]) 
REFERENCES [dbo].[filter_node] ([filter_node_id]) 
GO
ALTER TABLE [dbo].[calendar_pay_exclude] WITH CHECK ADD CONSTRAINT [cal_pay_exc_FK2_ref_pay_typ] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[unit] WITH CHECK ADD CONSTRAINT [fk_Unit_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[security_group_group] WITH CHECK ADD CONSTRAINT [security_grp_grp_FK2_sec_grp] FOREIGN KEY([parent_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_report_parameter_type] WITH CHECK ADD CONSTRAINT [ref_rpt_prm_typ_FK1_ref_rpt_cat] FOREIGN KEY([ui_category]) 
REFERENCES [dbo].[ref_report_category] ([ui_category]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_FiltNd2] FOREIGN KEY([right_node_id]) 
REFERENCES [dbo].[filter_node] ([filter_node_id]) 
GO
ALTER TABLE [dbo].[calendar_time_off] WITH CHECK ADD CONSTRAINT [cal_tim_of_FK2_ref_cal_emp_cod] FOREIGN KEY([display_code]) 
REFERENCES [dbo].[ref_calendar_employee_code] ([display_code]) 
GO
ALTER TABLE [dbo].[unit] WITH CHECK ADD CONSTRAINT [fk_Unit_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[security_group_ip_address] WITH CHECK ADD CONSTRAINT [fk_SecGrpIpAddr_SecGrp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_request_type] WITH CHECK ADD CONSTRAINT [fk_RefReqTyp_AlrtTyp] FOREIGN KEY([alert_type]) 
REFERENCES [dbo].[alert_type] ([alert_type]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_RefFiltNdTyp] FOREIGN KEY([node_type]) 
REFERENCES [dbo].[ref_filter_node_type] ([node_type]) 
GO
ALTER TABLE [dbo].[calendar_time_off] WITH CHECK ADD CONSTRAINT [cal_tim_off_FK3_ref_col] FOREIGN KEY([color_id]) 
REFERENCES [dbo].[ref_color] ([color_id]) 
GO
ALTER TABLE [dbo].[unit] WITH CHECK ADD CONSTRAINT [fk_Unit_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[security_group_mask] WITH CHECK ADD CONSTRAINT [group_security_FK1_sec_grp_mask] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_request_type_status] WITH CHECK ADD CONSTRAINT [fk_RefReqTypStat_RefReqStat] FOREIGN KEY([request_status]) 
REFERENCES [dbo].[ref_request_status] ([request_status]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_RefFiltOp] FOREIGN KEY([operator]) 
REFERENCES [dbo].[ref_filter_operator] ([operator]) 
GO
ALTER TABLE [dbo].[calendar_time_off] WITH CHECK ADD CONSTRAINT [cal_tim_off_PK1_cal] FOREIGN KEY([calendar_id]) 
REFERENCES [dbo].[calendar] ([calendar_id]) 
GO
ALTER TABLE [dbo].[unit] WITH CHECK ADD CONSTRAINT [fk_Unit_TmOD] FOREIGN KEY([other_dollars_id]) 
REFERENCES [dbo].[time_other_dollars] ([other_dollars_id]) 
GO
ALTER TABLE [dbo].[security_group_mask] WITH CHECK ADD CONSTRAINT [sec_grp_mask_FK3_ref_acc_cod] FOREIGN KEY([access_code]) 
REFERENCES [dbo].[ref_access_code] ([access_code]) 
GO
ALTER TABLE [dbo].[ref_request_type_status] WITH CHECK ADD CONSTRAINT [fk_RefReqTypStat_RefReqTyp] FOREIGN KEY([request_type]) 
REFERENCES [dbo].[ref_request_type] ([request_type]) 
GO
ALTER TABLE [dbo].[filter_node] WITH CHECK ADD CONSTRAINT [fk_FiltNd_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[census_data] WITH CHECK ADD CONSTRAINT [fk_CnsusDat_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[unit] WITH CHECK ADD CONSTRAINT [fk_Unit_TmOH] FOREIGN KEY([other_hours_id]) 
REFERENCES [dbo].[time_other_hours] ([other_hours_id]) 
GO
ALTER TABLE [dbo].[security_group_mask] WITH CHECK ADD CONSTRAINT [security_group_mask_FK2_sec_mask] FOREIGN KEY([security_mask_id]) 
REFERENCES [dbo].[security_mask] ([security_mask_id]) 
GO
ALTER TABLE [dbo].[ref_script_parameter] WITH CHECK ADD CONSTRAINT [fk_RefScrParm_RefScrFrm] FOREIGN KEY([script_formula_id]) 
REFERENCES [dbo].[ref_script_formula] ([script_formula_id]) 
GO
ALTER TABLE [dbo].[gimbal_application] WITH CHECK ADD CONSTRAINT [fk_GmblApp_RefMobApp] FOREIGN KEY([mobile_application_id]) 
REFERENCES [dbo].[ref_mobile_application] ([mobile_application_id]) 
GO
ALTER TABLE [dbo].[census_data] WITH CHECK ADD CONSTRAINT [fk_CnsusDat_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[unit_over] WITH CHECK ADD CONSTRAINT [fk_UnitOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_group_org_level] WITH CHECK ADD CONSTRAINT [fk_SecGrpOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[ref_script_parameter] WITH CHECK ADD CONSTRAINT [ref_scr_prm_FK2_ref_prm_cod] FOREIGN KEY([parameter_code]) 
REFERENCES [dbo].[ref_parameter_code] ([parameter_code]) 
GO
ALTER TABLE [dbo].[gimbal_application] WITH CHECK ADD CONSTRAINT [fk_GmblApp_RefMobPltfm] FOREIGN KEY([mobile_platform_id]) 
REFERENCES [dbo].[ref_mobile_platform] ([mobile_platform_id]) 
GO
ALTER TABLE [dbo].[comment] WITH CHECK ADD CONSTRAINT [comment_FK1_comment_source] FOREIGN KEY([comment_source]) 
REFERENCES [dbo].[comment_source] ([comment_source]) 
GO
ALTER TABLE [dbo].[unit_over] WITH CHECK ADD CONSTRAINT [fk_UnitOvr_Unit] FOREIGN KEY([unit_id]) 
REFERENCES [dbo].[unit] ([unit_id]) 
GO
ALTER TABLE [dbo].[security_group_org_level] WITH CHECK ADD CONSTRAINT [fk_SecGrpOL_SecGrp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_script_parameter_value] WITH CHECK ADD CONSTRAINT [fk_RefScrParmVal_RefScrParm] FOREIGN KEY([script_formula_id], [sequence]) 
REFERENCES [dbo].[ref_script_parameter] ([script_formula_id], [sequence]) 
GO
ALTER TABLE [dbo].[gimbal_place] WITH CHECK ADD CONSTRAINT [fk_GmblPlc_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[company] WITH CHECK ADD CONSTRAINT [fk_Co_ReqWrkflGrp] FOREIGN KEY([dflt_req_wrkfl_grp_id]) 
REFERENCES [dbo].[request_workflow_group] ([request_workflow_group_id]) 
GO
ALTER TABLE [dbo].[widget] WITH CHECK ADD CONSTRAINT [fk_Wdgt_RefWdgtCat] FOREIGN KEY([widget_category]) 
REFERENCES [dbo].[ref_widget_category] ([widget_category]) 
GO
ALTER TABLE [dbo].[security_group_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_SecGrpOLRqrCmnt_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[ref_security_dns] WITH CHECK ADD CONSTRAINT [fk_RefSecDns_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[history_pay_periods] WITH CHECK ADD CONSTRAINT [fk_HstPayPd_PayPd] FOREIGN KEY([pay_period_id]) 
REFERENCES [dbo].[pay_period] ([pay_period_id]) 
GO
ALTER TABLE [dbo].[company_address] WITH CHECK ADD CONSTRAINT [fk_CoAddr_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[widget_data] WITH CHECK ADD CONSTRAINT [fk_WdgtDat_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[security_group_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_SecGrpOLRqrCmnt_SecGrp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_security_domain] WITH CHECK ADD CONSTRAINT [fk_RefSecDmn_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[history_schedule_org_levels] WITH CHECK ADD CONSTRAINT [fk_HstSchdOL_HstSchd] FOREIGN KEY([hst_schedule_id]) 
REFERENCES [dbo].[history_schedules] ([hst_schedule_id]) 
GO
ALTER TABLE [dbo].[company_address] WITH CHECK ADD CONSTRAINT [fk_CoAddr_RefAddrTyp] FOREIGN KEY([address_type]) 
REFERENCES [dbo].[ref_address_type] ([address_type]) 
GO
ALTER TABLE [dbo].[widget_data] WITH CHECK ADD CONSTRAINT [fk_WdgtDat_Wdgt] FOREIGN KEY([widget_id]) 
REFERENCES [dbo].[widget] ([widget_id]) 
GO
ALTER TABLE [dbo].[security_group_pay_type] WITH CHECK ADD CONSTRAINT [sec_grp_pay_typ_FK2_ref_pay_typ] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[ref_state] WITH CHECK ADD CONSTRAINT [fk_RefState_RefCty] FOREIGN KEY([country]) 
REFERENCES [dbo].[ref_country] ([country]) 
GO
ALTER TABLE [dbo].[history_schedules] WITH CHECK ADD CONSTRAINT [fk_HstSchd_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[company_address] WITH CHECK ADD CONSTRAINT [fk_CoAddr_RefState] FOREIGN KEY([country], [state]) 
REFERENCES [dbo].[ref_state] ([country], [state]) 
GO
ALTER TABLE [dbo].[wizard] WITH CHECK ADD CONSTRAINT [fk_Wiz_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_group_pay_type] WITH CHECK ADD CONSTRAINT [sec_grp_pay_type_FK1_sec_grp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_template_tag] WITH CHECK ADD CONSTRAINT [ref_tmp_tag_FK1_ref_frm_typ] FOREIGN KEY([format_type]) 
REFERENCES [dbo].[ref_format_type] ([format_type]) 
GO
ALTER TABLE [dbo].[history_schedules] WITH CHECK ADD CONSTRAINT [fk_HstSchd_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[company_device] WITH CHECK ADD CONSTRAINT [fk_CoDev_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[wizard] WITH CHECK ADD CONSTRAINT [fk_Wiz_RefWizTyp] FOREIGN KEY([wizard_type]) 
REFERENCES [dbo].[ref_wizard_type] ([wizard_type]) 
GO
ALTER TABLE [dbo].[security_group_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_SecGrpPayTypRstrctFutr_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[ref_template_tag] WITH CHECK ADD CONSTRAINT [ref_tmp_tag_FK2_ref_tmp_typ] FOREIGN KEY([template_type]) 
REFERENCES [dbo].[ref_template_type] ([template_type]) 
GO
ALTER TABLE [dbo].[history_schedules] WITH CHECK ADD CONSTRAINT [fk_HstSchd_HstPayPd] FOREIGN KEY([hst_pay_period_id]) 
REFERENCES [dbo].[history_pay_periods] ([hst_pay_period_id]) 
GO
ALTER TABLE [dbo].[company_device] WITH CHECK ADD CONSTRAINT [fk_CoDev_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[wizard_tab] WITH CHECK ADD CONSTRAINT [fk_WizTab_RefWizTabCd] FOREIGN KEY([wizard_tab_code]) 
REFERENCES [dbo].[ref_wizard_tab_code] ([wizard_tab_code]) 
GO
ALTER TABLE [dbo].[security_group_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_SecGrpPayTypRstrctFutr_SecGrp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_template_tag_format] WITH CHECK ADD CONSTRAINT [ref_tmp_tag_frm_FK1_ref_frm_typ] FOREIGN KEY([format_type]) 
REFERENCES [dbo].[ref_format_type] ([format_type]) 
GO
ALTER TABLE [dbo].[history_timeblock_org_levels] WITH CHECK ADD CONSTRAINT [fk_HstTmBlkOL_HstTmBlk] FOREIGN KEY([hst_timeblock_id]) 
REFERENCES [dbo].[history_timeblocks] ([hst_timeblock_id]) 
GO
ALTER TABLE [dbo].[company_holiday] WITH CHECK ADD CONSTRAINT [cmp_hol_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[wizard_tab] WITH CHECK ADD CONSTRAINT [fk_WizTab_Wiz] FOREIGN KEY([wizard_id]) 
REFERENCES [dbo].[wizard] ([wizard_id]) 
GO
ALTER TABLE [dbo].[security_group_script] WITH CHECK ADD CONSTRAINT [sec_grp_scr_FK1_sec_grp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[ref_unit_type] WITH CHECK ADD CONSTRAINT [fk_RefUnitTyp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[history_timeblocks] WITH CHECK ADD CONSTRAINT [fk_HstTmBlk_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[company_holiday] WITH CHECK ADD CONSTRAINT [fk_CoHol_RefHol] FOREIGN KEY([company_id], [description]) 
REFERENCES [dbo].[ref_holiday] ([company_id], [description]) 
GO
ALTER TABLE [dbo].[worksheet] WITH CHECK ADD CONSTRAINT [fk_Wkst_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_group_script] WITH CHECK ADD CONSTRAINT [sec_grp_scr_FK2_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[reference_table_field] WITH CHECK ADD CONSTRAINT [ref_table_field_FK1_ref_table] FOREIGN KEY([table_dbname]) 
REFERENCES [dbo].[reference_table] ([table_dbname]) 
GO
ALTER TABLE [dbo].[history_timeblocks] WITH CHECK ADD CONSTRAINT [fk_HstTmBlk_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[company_org_level] WITH CHECK ADD CONSTRAINT [company_org_level_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[worksheet_org_level] WITH CHECK ADD CONSTRAINT [fk_WkstOL_Wkst] FOREIGN KEY([worksheet_id]) 
REFERENCES [dbo].[worksheet] ([worksheet_id]) 
GO
ALTER TABLE [dbo].[security_group_user] WITH CHECK ADD CONSTRAINT [security_group_user_FK1_sec_user] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report] WITH CHECK ADD CONSTRAINT [fk_Rep_RefCalcCat] FOREIGN KEY([calc_category]) 
REFERENCES [dbo].[ref_calc_category] ([calc_category]) 
GO
ALTER TABLE [dbo].[history_timeblocks] WITH CHECK ADD CONSTRAINT [fk_HstTmBlk_HstPayPd] FOREIGN KEY([hst_pay_period_id]) 
REFERENCES [dbo].[history_pay_periods] ([hst_pay_period_id]) 
GO
ALTER TABLE [dbo].[company_org_level_item] WITH CHECK ADD CONSTRAINT [company_org_level_item_FK1_comp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[worksheet_timeblock] WITH CHECK ADD CONSTRAINT [fk_WkstTmBlk_RefPnchCat] FOREIGN KEY([in_punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[security_group_user] WITH CHECK ADD CONSTRAINT [security_group_user_FK2_sec_grp] FOREIGN KEY([security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[report] WITH CHECK ADD CONSTRAINT [fk_Rep_RefFeature] FOREIGN KEY([feature]) 
REFERENCES [dbo].[ref_feature] ([feature]) 
GO
ALTER TABLE [dbo].[import_data_map] WITH CHECK ADD CONSTRAINT [fk_ImpDatMap_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[company_org_level_item_date] WITH CHECK ADD CONSTRAINT [fk_CoOLIDate_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[worksheet_timeblock] WITH CHECK ADD CONSTRAINT [fk_WkstTmBlk_Wkst] FOREIGN KEY([worksheet_id]) 
REFERENCES [dbo].[worksheet] ([worksheet_id]) 
GO
ALTER TABLE [dbo].[security_password_history] WITH CHECK ADD CONSTRAINT [fk_SecPwdHst_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report] WITH CHECK ADD CONSTRAINT [fk_Rep_RefRptCd] FOREIGN KEY([report_code]) 
REFERENCES [dbo].[ref_report_code] ([report_code]) 
GO
ALTER TABLE [dbo].[import_data_map] WITH CHECK ADD CONSTRAINT [fk_ImpDatMap_RefImpMap] FOREIGN KEY([import_map_id]) 
REFERENCES [dbo].[ref_import_map] ([import_map_id]) 
GO
ALTER TABLE [dbo].[company_org_level_item_pay_type] WITH CHECK ADD CONSTRAINT [fk_CoOLIPayTyp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_subtoken] WITH CHECK ADD CONSTRAINT [fk_SecSbtok_SecTok] FOREIGN KEY([token_string]) 
REFERENCES [dbo].[security_token] ([token_string]) 
GO
ALTER TABLE [dbo].[report_break] WITH CHECK ADD CONSTRAINT [fk_RptBrk_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_accrual] WITH CHECK ADD CONSTRAINT [input_accrual_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_org_level_item_pay_type] WITH CHECK ADD CONSTRAINT [fk_CoOLIPayTyp_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_token] WITH CHECK ADD CONSTRAINT [fk_SecTok_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_exception] WITH CHECK ADD CONSTRAINT [fk_RptExcp_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_accrual_group_employee] WITH CHECK ADD CONSTRAINT [fk_InpAcrGrpEmp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[company_org_level_item_pay_type] WITH CHECK ADD CONSTRAINT [fk_CoOLIPayTyp_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[security_user] WITH CHECK ADD CONSTRAINT [fk_SecUsr_MobProfl] FOREIGN KEY([mobile_profile_id]) 
REFERENCES [dbo].[mobile_profile] ([mobile_profile_id]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_RefParm_1] FOREIGN KEY([parameter_1]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[input_accrual_group_employee] WITH CHECK ADD CONSTRAINT [fk_InpAcrGrpEmp_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[company_org_level_item_structure] WITH CHECK ADD CONSTRAINT [fk_CoOLIStr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_user] WITH CHECK ADD CONSTRAINT [fk_SecUsr_RefLkOStat] FOREIGN KEY([lockout_status]) 
REFERENCES [dbo].[ref_lockout_status] ([lockout_status]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_RefParm_2] FOREIGN KEY([parameter_2]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[input_accrual_group_employee] WITH CHECK ADD CONSTRAINT [fk_InpAcrGrpEmp_RefEditCd] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_org_level_struct] WITH CHECK ADD CONSTRAINT [cmp_org_lvl_str_FK1_cm_or_lv_it] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_user] WITH CHECK ADD CONSTRAINT [fk_SecUsr_RefSecTyp] FOREIGN KEY([security_type_id]) 
REFERENCES [dbo].[ref_security_type] ([security_type_id]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_RefParm_3] FOREIGN KEY([parameter_3]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[input_address] WITH CHECK ADD CONSTRAINT [inp_adr_FK1_ref_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_org_level_struct] WITH CHECK ADD CONSTRAINT [cmp_org_lvl_str_FK2_cm_or_lv_it] FOREIGN KEY([parent_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[security_user] WITH CHECK ADD CONSTRAINT [security_user_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_RefParm_4] FOREIGN KEY([parameter_4]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[input_badge] WITH CHECK ADD CONSTRAINT [input_badge_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_org_level_struct] WITH CHECK ADD CONSTRAINT [company_org_lvl_struct_FK3_comp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user] WITH CHECK ADD CONSTRAINT [security_user_FK2_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_RefParm_5] FOREIGN KEY([parameter_5]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[input_company_org_level] WITH CHECK ADD CONSTRAINT [inp_cmp_org_lvl_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_parameter] WITH CHECK ADD CONSTRAINT [company_parameter_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_company] WITH CHECK ADD CONSTRAINT [security_user_comp_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_file_alternate] WITH CHECK ADD CONSTRAINT [fk_RptFlAlt_Rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[input_demographic] WITH CHECK ADD CONSTRAINT [input_demog_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_parameter] WITH CHECK ADD CONSTRAINT [fk_CoParm_RefParmTyp] FOREIGN KEY([parameter_type]) 
REFERENCES [dbo].[ref_parameter_type] ([parameter_type]) 
GO
ALTER TABLE [dbo].[security_user_company] WITH CHECK ADD CONSTRAINT [security_user_company_FK2_comp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_filter_type] WITH CHECK ADD CONSTRAINT [fk_RptFiltTyp_RefRptFiltTyp] FOREIGN KEY([filter_type]) 
REFERENCES [dbo].[ref_report_filter_type] ([filter_type]) 
GO
ALTER TABLE [dbo].[input_dollars] WITH CHECK ADD CONSTRAINT [fk_InpD_RefEditCd] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_parameter_value] WITH CHECK ADD CONSTRAINT [cmp_prm_val_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_data] WITH CHECK ADD CONSTRAINT [sec_usr_dat_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_filter_type] WITH CHECK ADD CONSTRAINT [fk_RptFiltTyp_Rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[input_dollars] WITH CHECK ADD CONSTRAINT [fk_InpD_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[company_parameter_value] WITH CHECK ADD CONSTRAINT [cmp_prm_val_FK3_ref_prm_cod] FOREIGN KEY([parameter_code]) 
REFERENCES [dbo].[ref_parameter_code] ([parameter_code]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_instance] WITH CHECK ADD CONSTRAINT [fk_RptInst_Sess] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[input_earning_group_employee] WITH CHECK ADD CONSTRAINT [inp_earn_grp_emp_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_parameter_value] WITH CHECK ADD CONSTRAINT [fk_CoParmVal_RefParmCd] FOREIGN KEY([parameter]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_FiltNd] FOREIGN KEY([filter_node_id]) 
REFERENCES [dbo].[filter_node] ([filter_node_id]) 
GO
ALTER TABLE [dbo].[report_instance_employee] WITH CHECK ADD CONSTRAINT [fk_RptInstEmp_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_email] WITH CHECK ADD CONSTRAINT [input_email_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_phone] WITH CHECK ADD CONSTRAINT [cmp_phon_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_MobProfl] FOREIGN KEY([mobile_profile_id]) 
REFERENCES [dbo].[mobile_profile] ([mobile_profile_id]) 
GO
ALTER TABLE [dbo].[report_instance_filter] WITH CHECK ADD CONSTRAINT [fk_RptInstFilt_RefRptFiltTyp] FOREIGN KEY([filter_type]) 
REFERENCES [dbo].[ref_report_filter_type] ([filter_type]) 
GO
ALTER TABLE [dbo].[input_email] WITH CHECK ADD CONSTRAINT [input_email_FK2_ref_email_type] FOREIGN KEY([email_type]) 
REFERENCES [dbo].[ref_email_type] ([email_type]) 
GO
ALTER TABLE [dbo].[company_phone] WITH CHECK ADD CONSTRAINT [cmp_phon_FK2_ref_phon_typ] FOREIGN KEY([phone_type]) 
REFERENCES [dbo].[ref_phone_type] ([phone_type]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_RefAlgrtmCd] FOREIGN KEY([algorithm_code]) 
REFERENCES [dbo].[ref_algorithm_code] ([algorithm_code]) 
GO
ALTER TABLE [dbo].[report_instance_filter] WITH CHECK ADD CONSTRAINT [fk_RptInstFilt_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_employee] WITH CHECK ADD CONSTRAINT [input_employee_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_script] WITH CHECK ADD CONSTRAINT [company_script_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_RefCnflRsltnTyp] FOREIGN KEY([conflict_resolution_type]) 
REFERENCES [dbo].[ref_conflict_resolution_type] ([conflict_resolution_type]) 
GO
ALTER TABLE [dbo].[report_instance_parameter] WITH CHECK ADD CONSTRAINT [rpt_inst_prm_FK1_rpt_inst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_employee_emergency_contact] WITH CHECK ADD CONSTRAINT [inp_emp_emr_con_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_script] WITH CHECK ADD CONSTRAINT [company_script_FK2_ref_scr_type] FOREIGN KEY([script_type]) 
REFERENCES [dbo].[ref_script_type] ([script_type]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_RefLkOStat] FOREIGN KEY([lockout_status]) 
REFERENCES [dbo].[ref_lockout_status] ([lockout_status]) 
GO
ALTER TABLE [dbo].[report_other_dollars] WITH CHECK ADD CONSTRAINT [fk_RptOD_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[input_employee_org_level] WITH CHECK ADD CONSTRAINT [inp_emp_org_lvl_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[company_script] WITH CHECK ADD CONSTRAINT [company_script_FK3_script] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[security_user_default] WITH CHECK ADD CONSTRAINT [fk_SecUsrDflt_RefSecTyp] FOREIGN KEY([security_type_id]) 
REFERENCES [dbo].[ref_security_type] ([security_type_id]) 
GO
ALTER TABLE [dbo].[report_other_dollars] WITH CHECK ADD CONSTRAINT [fk_RptOD_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_employment] WITH CHECK ADD CONSTRAINT [input_employ_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_active_employee] WITH CHECK ADD CONSTRAINT [con_act_emp_FK1_con_act_scr] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[console_active_script] ([session_guid]) 
GO
ALTER TABLE [dbo].[security_user_dns] WITH CHECK ADD CONSTRAINT [fk_SecUsrDns_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_other_dollars_over] WITH CHECK ADD CONSTRAINT [fk_RptODOvr_RptOD] FOREIGN KEY([report_instance_id], [other_dollars_id]) 
REFERENCES [dbo].[report_other_dollars] ([report_instance_id], [other_dollars_id]) 
GO
ALTER TABLE [dbo].[input_hours] WITH CHECK ADD CONSTRAINT [fk_InpH_RefEditCd] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_active_employee] WITH CHECK ADD CONSTRAINT [con_act_emp_FK2_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[security_user_dns] WITH CHECK ADD CONSTRAINT [fk_SecUsrDns_RefSecDns] FOREIGN KEY([company_id], [dns_name]) 
REFERENCES [dbo].[ref_security_dns] ([company_id], [dns_name]) 
GO
ALTER TABLE [dbo].[report_other_hours] WITH CHECK ADD CONSTRAINT [fk_RptOH_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[input_hours] WITH CHECK ADD CONSTRAINT [fk_InpH_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[console_active_script] WITH CHECK ADD CONSTRAINT [con_act_scr_FK2_con_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[console_script] ([script_id]) 
GO
ALTER TABLE [dbo].[security_user_dns] WITH CHECK ADD CONSTRAINT [fk_SecUsrDns_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_other_hours] WITH CHECK ADD CONSTRAINT [fk_RptOH_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_hours_control] WITH CHECK ADD CONSTRAINT [fk_InpHCtrl_RefInpCtrlStat] FOREIGN KEY([in_ctrl_stat_code]) 
REFERENCES [dbo].[ref_input_control_status] ([in_ctrl_stat_code]) 
GO
ALTER TABLE [dbo].[console_active_script] WITH CHECK ADD CONSTRAINT [fk_ConsActScr_ConsScr] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[security_user_domain] WITH CHECK ADD CONSTRAINT [fk_SecUsrDmn_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_other_hours_over] WITH CHECK ADD CONSTRAINT [fk_RptOHOvr_RptOH] FOREIGN KEY([report_instance_id], [other_hours_id]) 
REFERENCES [dbo].[report_other_hours] ([report_instance_id], [other_hours_id]) 
GO
ALTER TABLE [dbo].[input_pay_group_employee] WITH CHECK ADD CONSTRAINT [inp_pay_grp_emp_FK1_ref_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_column] WITH CHECK ADD CONSTRAINT [con_col_FK1_con_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[console_script] ([script_id]) 
GO
ALTER TABLE [dbo].[security_user_domain] WITH CHECK ADD CONSTRAINT [fk_SecUsrDmn_RefSecDmn] FOREIGN KEY([company_id], [domain_name]) 
REFERENCES [dbo].[ref_security_domain] ([company_id], [domain_name]) 
GO
ALTER TABLE [dbo].[report_parameter_type] WITH CHECK ADD CONSTRAINT [fk_RptParmTyp_RefRptParmTyp] FOREIGN KEY([parameter_type]) 
REFERENCES [dbo].[ref_report_parameter_type] ([parameter_type]) 
GO
ALTER TABLE [dbo].[input_phone] WITH CHECK ADD CONSTRAINT [input_phone_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_column] WITH CHECK ADD CONSTRAINT [con_col_FK2_ref_col_typ] FOREIGN KEY([column_type]) 
REFERENCES [dbo].[ref_column_type] ([column_type]) 
GO
ALTER TABLE [dbo].[security_user_domain] WITH CHECK ADD CONSTRAINT [fk_SecUsrDmn_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_parameter_type] WITH CHECK ADD CONSTRAINT [fk_RptParmTyp_Rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[input_phone] WITH CHECK ADD CONSTRAINT [input_phone_FK2_ref_phone_type] FOREIGN KEY([phone_type]) 
REFERENCES [dbo].[ref_phone_type] ([phone_type]) 
GO
ALTER TABLE [dbo].[console_filter] WITH CHECK ADD CONSTRAINT [con_fltr_FK1_con_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[console_script] ([script_id]) 
GO
ALTER TABLE [dbo].[security_user_filter] WITH CHECK ADD CONSTRAINT [sec_usr_fil_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_payroll] WITH CHECK ADD CONSTRAINT [fk_RptPayr_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[input_piecework] WITH CHECK ADD CONSTRAINT [inp_pce_FK1_ref_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_filter] WITH CHECK ADD CONSTRAINT [con_fltr_FK2_ref_fltr_typ] FOREIGN KEY([filter_type]) 
REFERENCES [dbo].[ref_filter_type] ([filter_type]) 
GO
ALTER TABLE [dbo].[security_user_ip_address] WITH CHECK ADD CONSTRAINT [fk_SecUsrIpAddr_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_payroll] WITH CHECK ADD CONSTRAINT [fk_RptPayr_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_punch] WITH CHECK ADD CONSTRAINT [fk_InpPnch_RefEditCd] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[console_notify] WITH CHECK ADD CONSTRAINT [con_ntfy_FK1_con_act_scr] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[console_active_script] ([session_guid]) 
GO
ALTER TABLE [dbo].[security_user_mask] WITH CHECK ADD CONSTRAINT [sec_usr_msk_FK3_ref_acc_cod] FOREIGN KEY([access_code]) 
REFERENCES [dbo].[ref_access_code] ([access_code]) 
GO
ALTER TABLE [dbo].[report_payroll_over] WITH CHECK ADD CONSTRAINT [fk_RptPayrOvr_RptPayr] FOREIGN KEY([report_instance_id], [payroll_id]) 
REFERENCES [dbo].[report_payroll] ([report_instance_id], [payroll_id]) 
GO
ALTER TABLE [dbo].[input_punch] WITH CHECK ADD CONSTRAINT [fk_InpPnch_RefPnchCat] FOREIGN KEY([punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[console_script] WITH CHECK ADD CONSTRAINT [con_scr_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_mask] WITH CHECK ADD CONSTRAINT [security_user_mask_FK1_sec_user] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_process_type] WITH CHECK ADD CONSTRAINT [fk_RptProcTyp_RefRptProcTyp] FOREIGN KEY([process_type]) 
REFERENCES [dbo].[ref_report_process_type] ([process_type]) 
GO
ALTER TABLE [dbo].[input_punch_control] WITH CHECK ADD CONSTRAINT [fk_InpPnchCtrl_RefInpCtrlStat] FOREIGN KEY([in_ctrl_stat_code]) 
REFERENCES [dbo].[ref_input_control_status] ([in_ctrl_stat_code]) 
GO
ALTER TABLE [dbo].[custom_shift] WITH CHECK ADD CONSTRAINT [cus_shf_FK1_ref_loc] FOREIGN KEY([location_id]) 
REFERENCES [dbo].[ref_location] ([location_id]) 
GO
ALTER TABLE [dbo].[security_user_mask] WITH CHECK ADD CONSTRAINT [security_user_mask_FK2_sec_mask] FOREIGN KEY([security_mask_id]) 
REFERENCES [dbo].[security_mask] ([security_mask_id]) 
GO
ALTER TABLE [dbo].[report_process_type] WITH CHECK ADD CONSTRAINT [fk_RptProcTyp_Rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[input_schedule_deviation_control] WITH CHECK ADD CONSTRAINT [fk_InpSchdDvtnCtrl_RefInpCtrlStat] FOREIGN KEY([in_ctrl_stat_code]) 
REFERENCES [dbo].[ref_input_control_status] ([in_ctrl_stat_code]) 
GO
ALTER TABLE [dbo].[earning_group] WITH CHECK ADD CONSTRAINT [ern_grp_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[abra_hours_worked] WITH CHECK ADD CONSTRAINT [fk_AbraHWrkd_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_org_level] WITH CHECK ADD CONSTRAINT [fk_SecUsrOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[report_punch] WITH CHECK ADD CONSTRAINT [fk_RptPnch_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[input_schedule_group] WITH CHECK ADD CONSTRAINT [inp_sch_grp_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[earning_group_earning_code] WITH CHECK ADD CONSTRAINT [fk_ErnGrpErnCd_ErnGrp] FOREIGN KEY([earning_group_id]) 
REFERENCES [dbo].[earning_group] ([earning_group_id]) 
GO
ALTER TABLE [dbo].[accrual_employee_plan] WITH CHECK ADD CONSTRAINT [acc_emp_pln_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[security_user_org_level] WITH CHECK ADD CONSTRAINT [fk_SecUsrOL_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_punch] WITH CHECK ADD CONSTRAINT [fk_RptPnch_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_schedule_group_employee] WITH CHECK ADD CONSTRAINT [inp_sch_grp_emp_FK1_edt_cod] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[earning_group_employee] WITH CHECK ADD CONSTRAINT [ern_grp_emp_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_employee_plan] WITH CHECK ADD CONSTRAINT [acc_emp_pln_FK2_acc_pln] FOREIGN KEY([accrual_plan_id]) 
REFERENCES [dbo].[accrual_plan] ([accrual_plan_id]) 
GO
ALTER TABLE [dbo].[security_user_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_SecUsrOLRqrCmnt_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[report_punch_over] WITH CHECK ADD CONSTRAINT [fk_RptPnchOvr_RptPnch] FOREIGN KEY([report_instance_id], [punch_id]) 
REFERENCES [dbo].[report_punch] ([report_instance_id], [punch_id]) 
GO
ALTER TABLE [dbo].[input_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_InpScndRate_RefEditCd] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[earning_group_employee] WITH CHECK ADD CONSTRAINT [fk_ErnGrpEmp_ErnGrp] FOREIGN KEY([earning_group_id]) 
REFERENCES [dbo].[earning_group] ([earning_group_id]) 
GO
ALTER TABLE [dbo].[accrual_group] WITH CHECK ADD CONSTRAINT [acc_grp_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_SecUsrOLRqrCmnt_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_schedule] WITH CHECK ADD CONSTRAINT [fk_RptSchd_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[input_security_user_filter] WITH CHECK ADD CONSTRAINT [fk_InpSecUsrFilt_InpSecUsr] FOREIGN KEY([in_security_user_id]) 
REFERENCES [dbo].[input_security_user] ([in_security_user_id]) 
GO
ALTER TABLE [dbo].[employee] WITH CHECK ADD CONSTRAINT [employee_FK3_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[accrual_group_employee] WITH CHECK ADD CONSTRAINT [acc_grp_emp_Fk1_acc_grp] FOREIGN KEY([accrual_group_id]) 
REFERENCES [dbo].[accrual_group] ([accrual_group_id]) 
GO
ALTER TABLE [dbo].[security_user_pay_type] WITH CHECK ADD CONSTRAINT [sec_usr_pay_typ_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_schedule_over] WITH CHECK ADD CONSTRAINT [fk_RptSchdOvr_RptSchd] FOREIGN KEY([report_instance_id], [schedule_id]) 
REFERENCES [dbo].[report_schedule] ([report_instance_id], [schedule_id]) 
GO
ALTER TABLE [dbo].[input_supervisor] WITH CHECK ADD CONSTRAINT [input_supervisor_FK1_ref_edit_code] FOREIGN KEY([edit_code]) 
REFERENCES [dbo].[ref_edit_code] ([edit_code]) 
GO
ALTER TABLE [dbo].[employee] WITH CHECK ADD CONSTRAINT [fk_Emp_RefLangCd] FOREIGN KEY([language_code]) 
REFERENCES [dbo].[ref_language_code] ([language_code]) 
GO
ALTER TABLE [dbo].[accrual_group_employee] WITH CHECK ADD CONSTRAINT [acc_grp_emp_FK2_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[security_user_pay_type] WITH CHECK ADD CONSTRAINT [sec_usr_pay_typ_FK2_ref_pay_typ] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[report_sort_order] WITH CHECK ADD CONSTRAINT [fk_RptSortOrd_Rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[input_table_update] WITH CHECK ADD CONSTRAINT [fk_InpTblUpd_RefInpTblName] FOREIGN KEY([input_table_name]) 
REFERENCES [dbo].[ref_input_table_name] ([input_table_name]) 
GO
ALTER TABLE [dbo].[employee] WITH CHECK ADD CONSTRAINT [fk_Emp_RefTz] FOREIGN KEY([timezone]) 
REFERENCES [dbo].[ref_timezone] ([timezone]) 
GO
ALTER TABLE [dbo].[accrual_group_plan] WITH CHECK ADD CONSTRAINT [acc_grp_pln_FK1_acc_grp] FOREIGN KEY([accrual_group_id]) 
REFERENCES [dbo].[accrual_group] ([accrual_group_id]) 
GO
ALTER TABLE [dbo].[security_user_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_SecUsrPayTypRstrctFutr_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[report_template] WITH CHECK ADD CONSTRAINT [rpt_tmp_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[input_table_update] WITH CHECK ADD CONSTRAINT [inp_tbl_up_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_accrual] WITH CHECK ADD CONSTRAINT [employee_accrual_FK1_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_group_plan] WITH CHECK ADD CONSTRAINT [acc_grp_pln_FK2_acc_pln] FOREIGN KEY([accrual_plan_id]) 
REFERENCES [dbo].[accrual_plan] ([accrual_plan_id]) 
GO
ALTER TABLE [dbo].[security_user_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_SecUsrPayTypRstrctFutr_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template] WITH CHECK ADD CONSTRAINT [rpt_tmp_FK2_rpt] FOREIGN KEY([report_id]) 
REFERENCES [dbo].[report] ([report_id]) 
GO
ALTER TABLE [dbo].[mobile_device] WITH CHECK ADD CONSTRAINT [fk_MobDev_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[employee_address] WITH CHECK ADD CONSTRAINT [fk_EmpAddr_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_plan] WITH CHECK ADD CONSTRAINT [acc_pln_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[security_user_script] WITH CHECK ADD CONSTRAINT [sec_usr_scr_FK1_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template] WITH CHECK ADD CONSTRAINT [rpt_tmp_FK3_ref_rpt_tmp_scp] FOREIGN KEY([scope_code]) 
REFERENCES [dbo].[ref_report_template_scope] ([scope_code]) 
GO
ALTER TABLE [dbo].[mobile_profile_feature] WITH CHECK ADD CONSTRAINT [fk_MobProflFeat_MobFeat] FOREIGN KEY([feature_code]) 
REFERENCES [dbo].[mobile_feature] ([feature_code]) 
GO
ALTER TABLE [dbo].[employee_address] WITH CHECK ADD CONSTRAINT [fk_EmpAddr_RefAddrTyp] FOREIGN KEY([address_type]) 
REFERENCES [dbo].[ref_address_type] ([address_type]) 
GO
ALTER TABLE [dbo].[accrual_plan] WITH CHECK ADD CONSTRAINT [acc_pln_Fk2_ref_acc_bkt] FOREIGN KEY([accrual_id]) 
REFERENCES [dbo].[ref_accrual_bucket] ([accrual_id]) 
GO
ALTER TABLE [dbo].[security_user_script] WITH CHECK ADD CONSTRAINT [sec_usr_scr_FK2_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[report_template] WITH CHECK ADD CONSTRAINT [rpt_tmp_FK4_sec_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[mobile_profile_feature] WITH CHECK ADD CONSTRAINT [fk_MobProflFeat_MobProfl] FOREIGN KEY([mobile_profile_id]) 
REFERENCES [dbo].[mobile_profile] ([mobile_profile_id]) 
GO
ALTER TABLE [dbo].[employee_address] WITH CHECK ADD CONSTRAINT [fk_EmpAddr_RefState] FOREIGN KEY([country], [state]) 
REFERENCES [dbo].[ref_state] ([country], [state]) 
GO
ALTER TABLE [dbo].[accrual_plan] WITH CHECK ADD CONSTRAINT [acc_pln_FK3_ref_acc_yr_cod] FOREIGN KEY([accrual_year_code]) 
REFERENCES [dbo].[ref_accrual_year_code] ([accrual_year_code]) 
GO
ALTER TABLE [dbo].[secuser_persistent] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstnt_RefLkOStat] FOREIGN KEY([lockout_status]) 
REFERENCES [dbo].[ref_lockout_status] ([lockout_status]) 
GO
ALTER TABLE [dbo].[report_template_parameters] WITH CHECK ADD CONSTRAINT [rpt_tmp_prm_FK1_rpt_tmp] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[report_template] ([template_id]) 
GO
ALTER TABLE [dbo].[navigation_tree] WITH CHECK ADD CONSTRAINT [fk_NavTree_RefUrlNavTyp] FOREIGN KEY([url_nav_type]) 
REFERENCES [dbo].[ref_url_nav_type] ([url_nav_type]) 
GO
ALTER TABLE [dbo].[employee_attendance] WITH CHECK ADD CONSTRAINT [emp_att_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_plan] WITH CHECK ADD CONSTRAINT [acc_pln_FK4_ref_acc_bas_cod] FOREIGN KEY([accrual_base_code]) 
REFERENCES [dbo].[ref_accrual_base_code] ([accrual_base_code]) 
GO
ALTER TABLE [dbo].[secuser_persistent] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstnt_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template_parameters] WITH CHECK ADD CONSTRAINT [rpt_tmp_prm_FK2_ref_prm] FOREIGN KEY([parameter]) 
REFERENCES [dbo].[ref_parameter] ([parameter]) 
GO
ALTER TABLE [dbo].[org_level_defaults] WITH CHECK ADD CONSTRAINT [fk_OLDef_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[employee_attendance] WITH CHECK ADD CONSTRAINT [emp_att_FK2_com] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[accrual_plan_script] WITH CHECK ADD CONSTRAINT [acc_pln_scr_FK1_acc_pln] FOREIGN KEY([accrual_plan_id]) 
REFERENCES [dbo].[accrual_plan] ([accrual_plan_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_dns] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntDns_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_template_sched] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchd_RefNthOcrnc] FOREIGN KEY([nth_occurrence_id]) 
REFERENCES [dbo].[ref_nth_occurrence] ([nth_occurrence_id]) 
GO
ALTER TABLE [dbo].[parameterized_query_parameter] WITH CHECK ADD CONSTRAINT [fk_ParmzdQryParm_ParmzdQry] FOREIGN KEY([parameterized_query_id]) 
REFERENCES [dbo].[parameterized_query] ([parameterized_query_id]) 
GO
ALTER TABLE [dbo].[employee_attendance] WITH CHECK ADD CONSTRAINT [fk_EmpAtt_RefRsnCd] FOREIGN KEY([reason_code]) 
REFERENCES [dbo].[ref_reason_code] ([reason_code]) 
GO
ALTER TABLE [dbo].[accrual_plan_script] WITH CHECK ADD CONSTRAINT [acc_pln_scr_FK2_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_dns] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntDns_RefSecDns] FOREIGN KEY([company_id], [dns_name]) 
REFERENCES [dbo].[ref_security_dns] ([company_id], [dns_name]) 
GO
ALTER TABLE [dbo].[report_template_sched] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchd_RefPtrnStyle] FOREIGN KEY([pattern_style_id]) 
REFERENCES [dbo].[ref_pattern_style] ([pattern_style_id]) 
GO
ALTER TABLE [dbo].[parameterized_query_parameter] WITH CHECK ADD CONSTRAINT [fk_ParmzdQryParm_RefParmzdQryParm] FOREIGN KEY([query_parameter_type_id]) 
REFERENCES [dbo].[ref_query_parameter_type] ([query_parameter_type_id]) 
GO
ALTER TABLE [dbo].[employee_badge] WITH CHECK ADD CONSTRAINT [employee_badge_FK1_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_suspend] WITH CHECK ADD CONSTRAINT [acc_sus_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_dns] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntDns_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template_sched] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchd_RptSchdFiltTyp] FOREIGN KEY([rep_sched_filter_type]) 
REFERENCES [dbo].[report_schedule_filter_type] ([rep_sched_filter_type]) 
GO
ALTER TABLE [dbo].[pay_group] WITH CHECK ADD CONSTRAINT [fk_PayGrp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_condition] WITH CHECK ADD CONSTRAINT [emp_con_FK2_ref_con_cod] FOREIGN KEY([condition_code]) 
REFERENCES [dbo].[ref_condition_code] ([condition_code]) 
GO
ALTER TABLE [dbo].[accrual_suspend] WITH CHECK ADD CONSTRAINT [acc_sus_FK2_acc_pln] FOREIGN KEY([accrual_plan_id]) 
REFERENCES [dbo].[accrual_plan] ([accrual_plan_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_feature_code] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntFeatCd_MobFeat] FOREIGN KEY([feature_code]) 
REFERENCES [dbo].[mobile_feature] ([feature_code]) 
GO
ALTER TABLE [dbo].[report_template_sched] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchd_RptTmp] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[report_template] ([template_id]) 
GO
ALTER TABLE [dbo].[pay_group] WITH CHECK ADD CONSTRAINT [fk_PayGrp_PayPd] FOREIGN KEY([pay_period_id]) 
REFERENCES [dbo].[pay_period] ([pay_period_id]) 
GO
ALTER TABLE [dbo].[employee_condition] WITH CHECK ADD CONSTRAINT [emp_cond_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_suspend] WITH CHECK ADD CONSTRAINT [acc_sus_FK3_com] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_feature_code] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntFeatCd_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template_sched] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchd_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[pay_group] WITH CHECK ADD CONSTRAINT [fk_PayGrp_Wkst] FOREIGN KEY([worksheet_id]) 
REFERENCES [dbo].[worksheet] ([worksheet_id]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [empl_demog_FK2_ref_marital_st] FOREIGN KEY([marital_status]) 
REFERENCES [dbo].[ref_marital_status] ([marital_status]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK1_acc_pln] FOREIGN KEY([accrual_plan_id]) 
REFERENCES [dbo].[accrual_plan] ([accrual_plan_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_flags] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntFlg_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template_sched_emp_email] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchdEmpEmail_EmpEmail] FOREIGN KEY([employee_id], [email_type]) 
REFERENCES [dbo].[employee_email] ([employee_id], [email_type]) 
GO
ALTER TABLE [dbo].[pay_group_device] WITH CHECK ADD CONSTRAINT [fk_PayGrpDev_PayGrp] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [empl_demog_FK3_ref_race_code] FOREIGN KEY([race_code]) 
REFERENCES [dbo].[ref_race_code] ([race_code]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK2_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_ip_address] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntIpAddr_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_template_sched_emp_email] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchdEmpEmail_RptTmpSchd] FOREIGN KEY([template_sched_id]) 
REFERENCES [dbo].[report_template_sched] ([template_sched_id]) 
GO
ALTER TABLE [dbo].[pay_group_device] WITH CHECK ADD CONSTRAINT [fk_PayGrpDev_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [empl_demog_FK4_ref_filing_status] FOREIGN KEY([federal_filing_status]) 
REFERENCES [dbo].[ref_filing_status] ([filing_status]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK3_ref_acc_bkt] FOREIGN KEY([accrual_id]) 
REFERENCES [dbo].[ref_accrual_bucket] ([accrual_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_org_level] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntOL_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[report_template_sched_user_email] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchdUsrEmail_RptTmpSchd] FOREIGN KEY([template_sched_id]) 
REFERENCES [dbo].[report_template_sched] ([template_sched_id]) 
GO
ALTER TABLE [dbo].[pay_group_employee] WITH CHECK ADD CONSTRAINT [pay_group_employee_FK1_pay_group] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [empl_demog_FK5_ref_filing_status] FOREIGN KEY([state_filing_status]) 
REFERENCES [dbo].[ref_filing_status] ([filing_status]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK4_scr] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_org_level] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[report_template_sched_user_email] WITH CHECK ADD CONSTRAINT [fk_RptTmpSchdUsrEmail_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[pay_group_employee] WITH CHECK ADD CONSTRAINT [pay_group_employee_FK2_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [employee_demog_FK6_ref_gend_code] FOREIGN KEY([gender_code]) 
REFERENCES [dbo].[ref_gender_code] ([gender_code]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK5_tim_oth_hrs] FOREIGN KEY([other_hours_id]) 
REFERENCES [dbo].[time_other_hours] ([other_hours_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_org_level] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntOL_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[report_total] WITH CHECK ADD CONSTRAINT [fk_RptTot_RptInst] FOREIGN KEY([report_instance_id]) 
REFERENCES [dbo].[report_instance] ([report_instance_id]) 
GO
ALTER TABLE [dbo].[pay_group_premium] WITH CHECK ADD CONSTRAINT [pay_grp_prm_FK1_pay_grp] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[employee_demographic] WITH CHECK ADD CONSTRAINT [employee_demographic_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK7_com] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntOLRqrCmnt_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[report_total_over] WITH CHECK ADD CONSTRAINT [fk_RptTotOvr_RptTot] FOREIGN KEY([report_instance_id], [total_id]) 
REFERENCES [dbo].[report_total] ([report_instance_id], [total_id]) 
GO
ALTER TABLE [dbo].[pay_group_premium] WITH CHECK ADD CONSTRAINT [pay_grp_prm_FK2_prm_grp] FOREIGN KEY([premium_group_id]) 
REFERENCES [dbo].[premium_group] ([premium_group_id]) 
GO
ALTER TABLE [dbo].[employee_device] WITH CHECK ADD CONSTRAINT [fk_EmpDev_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acc_trn_FK8_ref_acc_cod] FOREIGN KEY([accrual_code]) 
REFERENCES [dbo].[ref_accrual_code] ([accrual_code]) 
GO
ALTER TABLE [dbo].[secuser_persistent_org_level_require_comment] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntOLRqrCmnt_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request] WITH CHECK ADD CONSTRAINT [fk_Req_RefReqStat] FOREIGN KEY([request_status]) 
REFERENCES [dbo].[ref_request_status] ([request_status]) 
GO
ALTER TABLE [dbo].[pay_group_script] WITH CHECK ADD CONSTRAINT [pay_group_script_FK1_pay_group] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[employee_device] WITH CHECK ADD CONSTRAINT [fk_EmpDev_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[accrual_tran] WITH CHECK ADD CONSTRAINT [acr_trn_FK6_ref_acc_trn_typ] FOREIGN KEY([accrual_tran_type]) 
REFERENCES [dbo].[ref_accrual_tran_type] ([accrual_tran_type]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTyp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[request] WITH CHECK ADD CONSTRAINT [fk_Req_RefReqTyp] FOREIGN KEY([request_type]) 
REFERENCES [dbo].[ref_request_type] ([request_type]) 
GO
ALTER TABLE [dbo].[pay_group_script] WITH CHECK ADD CONSTRAINT [pay_group_script_FK2_ref_scr_typ] FOREIGN KEY([script_type]) 
REFERENCES [dbo].[ref_script_type] ([script_type]) 
GO
ALTER TABLE [dbo].[employee_email] WITH CHECK ADD CONSTRAINT [employee_email_FK1_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[alert] WITH CHECK ADD CONSTRAINT [alert_FK1_alert_type] FOREIGN KEY([alert_type]) 
REFERENCES [dbo].[alert_type] ([alert_type]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTyp_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[request] WITH CHECK ADD CONSTRAINT [fk_Req_Req] FOREIGN KEY([cancelled_request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[pay_group_script] WITH CHECK ADD CONSTRAINT [pay_group_script_FK3_script] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[employee_email] WITH CHECK ADD CONSTRAINT [employee_email_FK2_ref_email_typ] FOREIGN KEY([email_type]) 
REFERENCES [dbo].[ref_email_type] ([email_type]) 
GO
ALTER TABLE [dbo].[alert] WITH CHECK ADD CONSTRAINT [alert_FK2_alert_severity_code] FOREIGN KEY([severity_code]) 
REFERENCES [dbo].[alert_severity_code] ([severity_code]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTyp_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request] WITH CHECK ADD CONSTRAINT [fk_Req_ReqWrkfl] FOREIGN KEY([request_workflow_id]) 
REFERENCES [dbo].[request_workflow] ([request_workflow_id]) 
GO
ALTER TABLE [dbo].[pay_group_worksheet] WITH CHECK ADD CONSTRAINT [fk_PayGrpWkst_PayGrp] FOREIGN KEY([pay_group_id]) 
REFERENCES [dbo].[pay_group] ([pay_group_id]) 
GO
ALTER TABLE [dbo].[employee_emergency_contact] WITH CHECK ADD CONSTRAINT [emp_emer_con_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[alert_recipient] WITH CHECK ADD CONSTRAINT [alert_recipient_FK1_alert] FOREIGN KEY([alert_id]) 
REFERENCES [dbo].[alert] ([alert_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTypeRstrctFutr_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[request] WITH CHECK ADD CONSTRAINT [fk_Req_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[pay_group_worksheet] WITH CHECK ADD CONSTRAINT [fk_PayGrpWkst_Wkst] FOREIGN KEY([worksheet_id]) 
REFERENCES [dbo].[worksheet] ([worksheet_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[alert_recipient] WITH CHECK ADD CONSTRAINT [alert_recipient_FK2_security_usr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTypeRstrctFutr_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[request_blackout] WITH CHECK ADD CONSTRAINT [fk_ReqBO_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[pay_period] WITH CHECK ADD CONSTRAINT [pay_period_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefAcaMbrCd] FOREIGN KEY([aca_member_code]) 
REFERENCES [dbo].[ref_aca_member_code] ([aca_member_code]) 
GO
ALTER TABLE [dbo].[alert_recipient_token] WITH CHECK ADD CONSTRAINT [fk_AltrRcptTkn_AlrtRcpt] FOREIGN KEY([alert_id], [user_id]) 
REFERENCES [dbo].[alert_recipient] ([alert_id], [user_id]) 
GO
ALTER TABLE [dbo].[secuser_persistent_pay_type_restrict_future] WITH CHECK ADD CONSTRAINT [fk_ScusrPrstntPayTypeRstrctFutr_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request_blackout_org_level] WITH CHECK ADD CONSTRAINT [fk_ReqBOOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[pay_period] WITH CHECK ADD CONSTRAINT [pay_period_FK2_ref_period_code] FOREIGN KEY([period_code]) 
REFERENCES [dbo].[ref_period_code] ([period_code]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefActCd] FOREIGN KEY([active_code]) 
REFERENCES [dbo].[ref_active_code] ([active_code]) 
GO
ALTER TABLE [dbo].[alert_recipient_token] WITH CHECK ADD CONSTRAINT [fk_AltrRcptTkn_SecTkn] FOREIGN KEY([token_string]) 
REFERENCES [dbo].[security_token] ([token_string]) 
GO
ALTER TABLE [dbo].[session] WITH CHECK ADD CONSTRAINT [fk_Sess_Emp1] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[request_blackout_org_level] WITH CHECK ADD CONSTRAINT [fk_ReqBOOL_ReqBO] FOREIGN KEY([blackout_id]) 
REFERENCES [dbo].[request_blackout] ([blackout_id]) 
GO
ALTER TABLE [dbo].[pay_period_close_date] WITH CHECK ADD CONSTRAINT [fk_PayPdClosDate_PayPdDate] FOREIGN KEY([pay_period_id], [calendar_year], [period_number]) 
REFERENCES [dbo].[pay_period_date] ([pay_period_id], [calendar_year], [period_number]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefCty] FOREIGN KEY([work_country]) 
REFERENCES [dbo].[ref_country] ([country]) 
GO
ALTER TABLE [dbo].[alert_type] WITH CHECK ADD CONSTRAINT [fk_AlrtTyp_AlrtSevCd] FOREIGN KEY([severity_code]) 
REFERENCES [dbo].[alert_severity_code] ([severity_code]) 
GO
ALTER TABLE [dbo].[session] WITH CHECK ADD CONSTRAINT [fk_Sess_Emp2] FOREIGN KEY([cur_employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[request_blackout_pay_type] WITH CHECK ADD CONSTRAINT [fk_ReqBOPayTyp_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[pay_period_close_date] WITH CHECK ADD CONSTRAINT [fk_PayPdClosDate_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefEmplStat] FOREIGN KEY([employment_status]) 
REFERENCES [dbo].[ref_employment_status] ([employment_status]) 
GO
ALTER TABLE [dbo].[alert_type] WITH CHECK ADD CONSTRAINT [fk_AlrtTyp_RefAlrtCat] FOREIGN KEY([category]) 
REFERENCES [dbo].[ref_alert_category] ([category]) 
GO
ALTER TABLE [dbo].[session] WITH CHECK ADD CONSTRAINT [fk_Sess_SecGrp] FOREIGN KEY([cur_security_group_id]) 
REFERENCES [dbo].[security_group] ([security_group_id]) 
GO
ALTER TABLE [dbo].[request_blackout_pay_type] WITH CHECK ADD CONSTRAINT [fk_ReqBOPayTyp_ReqBO] FOREIGN KEY([blackout_id]) 
REFERENCES [dbo].[request_blackout] ([blackout_id]) 
GO
ALTER TABLE [dbo].[pay_period_date] WITH CHECK ADD CONSTRAINT [pay_period_date_FK1_pay_period] FOREIGN KEY([pay_period_id]) 
REFERENCES [dbo].[pay_period] ([pay_period_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefPayStat] FOREIGN KEY([pay_status]) 
REFERENCES [dbo].[ref_pay_status] ([pay_status]) 
GO
ALTER TABLE [dbo].[alert_type] WITH CHECK ADD CONSTRAINT [fk_AlrtTyp_TmpMst] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[template_master] ([template_id]) 
GO
ALTER TABLE [dbo].[session] WITH CHECK ADD CONSTRAINT [fk_Sess_SecUsr1] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request_comment] WITH CHECK ADD CONSTRAINT [fk_ReqCmnt_Req] FOREIGN KEY([request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[pay_period_date_wrk] WITH CHECK ADD CONSTRAINT [pay_period_date_wrk_FK1_pay_per] FOREIGN KEY([pay_period_id]) 
REFERENCES [dbo].[pay_period] ([pay_period_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefShftTyp] FOREIGN KEY([shift_type]) 
REFERENCES [dbo].[ref_shift_type] ([shift_type]) 
GO
ALTER TABLE [dbo].[alert_type_recipient] WITH CHECK ADD CONSTRAINT [alert_user_FK1_alert_type] FOREIGN KEY([alert_type]) 
REFERENCES [dbo].[alert_type] ([alert_type]) 
GO
ALTER TABLE [dbo].[session] WITH CHECK ADD CONSTRAINT [fk_Sess_SecUsr2] FOREIGN KEY([cur_user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request_other_hours] WITH CHECK ADD CONSTRAINT [fk_ReqOH_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[payroll_history] WITH CHECK ADD CONSTRAINT [pay_hist_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefState] FOREIGN KEY([work_country], [work_state]) 
REFERENCES [dbo].[ref_state] ([country], [state]) 
GO
ALTER TABLE [dbo].[alert_type_recipient] WITH CHECK ADD CONSTRAINT [alert_user_FK2_security_user] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[session_data] WITH CHECK ADD CONSTRAINT [ses_dat_FK1_ses] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_other_hours] WITH CHECK ADD CONSTRAINT [fk_ReqOH_RefDvtnCd] FOREIGN KEY([deviation_code]) 
REFERENCES [dbo].[ref_deviation_code] ([deviation_code]) 
GO
ALTER TABLE [dbo].[payroll_history_over] WITH CHECK ADD CONSTRAINT [fk_PayrHstOvr_PayrHst] FOREIGN KEY([payroll_id]) 
REFERENCES [dbo].[payroll_history] ([payroll_id]) 
GO
ALTER TABLE [dbo].[employee_employment] WITH CHECK ADD CONSTRAINT [fk_EmpEmpl_RefTrmCd] FOREIGN KEY([termination_code]) 
REFERENCES [dbo].[ref_termination_code] ([termination_code]) 
GO
ALTER TABLE [dbo].[alert_type_worksheet] WITH CHECK ADD CONSTRAINT [fk_AlrtTypWkst_AlrtTyp] FOREIGN KEY([alert_type]) 
REFERENCES [dbo].[alert_type] ([alert_type]) 
GO
ALTER TABLE [dbo].[session_error] WITH CHECK ADD CONSTRAINT [session_error_FK1_session] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_other_hours] WITH CHECK ADD CONSTRAINT [fk_ReqOH_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[points_group_employee] WITH CHECK ADD CONSTRAINT [fk_PtsGrpEmp_PtsGrp] FOREIGN KEY([points_group_id]) 
REFERENCES [dbo].[points_group] ([points_group_id]) 
GO
ALTER TABLE [dbo].[employee_labor_allocation] WITH CHECK ADD CONSTRAINT [fk_EmpLbrAlc_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[alert_type_worksheet] WITH CHECK ADD CONSTRAINT [fk_AlrtTypWkst_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[session_filter] WITH CHECK ADD CONSTRAINT [ses_fil_FK1_ses] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_other_hours] WITH CHECK ADD CONSTRAINT [fk_ReqOH_Req] FOREIGN KEY([request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[premium_group_rule] WITH CHECK ADD CONSTRAINT [prm_grp_rul_FK1_prm_grp] FOREIGN KEY([premium_group_id]) 
REFERENCES [dbo].[premium_group] ([premium_group_id]) 
GO
ALTER TABLE [dbo].[employee_labor_allocation] WITH CHECK ADD CONSTRAINT [fk_EmpLbrAlc_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[alert_type_worksheet] WITH CHECK ADD CONSTRAINT [fk_AlrtTypWkst_Wkst] FOREIGN KEY([worksheet_id]) 
REFERENCES [dbo].[worksheet] ([worksheet_id]) 
GO
ALTER TABLE [dbo].[session_mobile_device] WITH CHECK ADD CONSTRAINT [fk_SessMobDev_MobDev] FOREIGN KEY([device_guid]) 
REFERENCES [dbo].[mobile_device] ([device_guid]) 
GO
ALTER TABLE [dbo].[request_punch] WITH CHECK ADD CONSTRAINT [fk_ReqPnch_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[premium_group_rule] WITH CHECK ADD CONSTRAINT [prm_grp_rul_FK2_prm_rul] FOREIGN KEY([premium_rule_id]) 
REFERENCES [dbo].[premium_rule] ([premium_rule_id]) 
GO
ALTER TABLE [dbo].[employee_labor_allocation_over] WITH CHECK ADD CONSTRAINT [fk_EmpLbrAlcOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[api_key] WITH CHECK ADD CONSTRAINT [fk_ApiKey_RefApiKeyType] FOREIGN KEY([api_key_type]) 
REFERENCES [dbo].[ref_api_key_type] ([api_key_type]) 
GO
ALTER TABLE [dbo].[session_mobile_device] WITH CHECK ADD CONSTRAINT [fk_SessMobDev_Sess] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_punch] WITH CHECK ADD CONSTRAINT [fk_ReqPnch_RefPnchCat] FOREIGN KEY([punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_labor_allocation_over] WITH CHECK ADD CONSTRAINT [fk_EmpLbrAlcOvr_EmpLbrAlc] FOREIGN KEY([employee_labor_id]) 
REFERENCES [dbo].[employee_labor_allocation] ([employee_labor_id]) 
GO
ALTER TABLE [dbo].[api_key] WITH CHECK ADD CONSTRAINT [fk_ApiKey_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[sso_session] WITH CHECK ADD CONSTRAINT [fk_SsoSess_Sess] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_punch] WITH CHECK ADD CONSTRAINT [fk_ReqPnch_Req] FOREIGN KEY([request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[employee_org_level] WITH CHECK ADD CONSTRAINT [fk_EmpOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[approval_column] WITH CHECK ADD CONSTRAINT [fk_ApprCol_ApprTmp] FOREIGN KEY([approval_template_id]) 
REFERENCES [dbo].[approval_template] ([approval_template_id]) 
GO
ALTER TABLE [dbo].[supervisor_level] WITH CHECK ADD CONSTRAINT [supr_lvl_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[request_punch_over] WITH CHECK ADD CONSTRAINT [fk_ReqPnchOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_RefCompCod] FOREIGN KEY([compare_code]) 
REFERENCES [dbo].[ref_compare_code] ([compare_code]) 
GO
ALTER TABLE [dbo].[employee_org_level] WITH CHECK ADD CONSTRAINT [fk_EmpOL_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[approval_column] WITH CHECK ADD CONSTRAINT [fk_ApprCol_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[supervisor_level_employee] WITH CHECK ADD CONSTRAINT [fk_SuprLEmp_SuprL] FOREIGN KEY([supervisor_level_id]) 
REFERENCES [dbo].[supervisor_level] ([supervisor_level_id]) 
GO
ALTER TABLE [dbo].[request_punch_over] WITH CHECK ADD CONSTRAINT [fk_ReqPnchOvr_ReqPnch] FOREIGN KEY([request_punch_id]) 
REFERENCES [dbo].[request_punch] ([request_punch_id]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_RefEarnCod] FOREIGN KEY([earning_code]) 
REFERENCES [dbo].[ref_earning_code] ([earning_code]) 
GO
ALTER TABLE [dbo].[employee_phone] WITH CHECK ADD CONSTRAINT [emp_phon_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[approval_column] WITH CHECK ADD CONSTRAINT [fk_ApprCol_RefApprColTyp] FOREIGN KEY([approval_column_type]) 
REFERENCES [dbo].[ref_approval_column_type] ([approval_column_type]) 
GO
ALTER TABLE [dbo].[supervisor_level_employee] WITH CHECK ADD CONSTRAINT [supr_lvl_emp_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[request_response] WITH CHECK ADD CONSTRAINT [fk_ReqResp_RefReqStat] FOREIGN KEY([request_status]) 
REFERENCES [dbo].[ref_request_status] ([request_status]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[employee_phone] WITH CHECK ADD CONSTRAINT [emp_phon_FK2_ref_phon_typ] FOREIGN KEY([phone_type]) 
REFERENCES [dbo].[ref_phone_type] ([phone_type]) 
GO
ALTER TABLE [dbo].[approval_column_pay_type] WITH CHECK ADD CONSTRAINT [fk_ApprColPayTyp_ApprCol] FOREIGN KEY([approval_column_id], [company_id]) 
REFERENCES [dbo].[approval_column] ([approval_column_id], [company_id]) 
GO
ALTER TABLE [dbo].[template] WITH CHECK ADD CONSTRAINT [fk_Tmp_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[request_response] WITH CHECK ADD CONSTRAINT [fk_ReqResp_Req] FOREIGN KEY([request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_RefPremTyp] FOREIGN KEY([premium_type]) 
REFERENCES [dbo].[ref_premium_type] ([premium_type]) 
GO
ALTER TABLE [dbo].[employee_points] WITH CHECK ADD CONSTRAINT [fk_EmpPts_EmpAtt] FOREIGN KEY([employee_attendance_id]) 
REFERENCES [dbo].[employee_attendance] ([employee_attendance_id]) 
GO
ALTER TABLE [dbo].[approval_column_pay_type] WITH CHECK ADD CONSTRAINT [fk_ApprColPayTyp_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[template] WITH CHECK ADD CONSTRAINT [tmpl_FK2_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[request_response] WITH CHECK ADD CONSTRAINT [fk_ReqResp_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[premium_rule] WITH CHECK ADD CONSTRAINT [fk_PrmRul_RefShftType] FOREIGN KEY([shift_type]) 
REFERENCES [dbo].[ref_shift_type] ([shift_type]) 
GO
ALTER TABLE [dbo].[employee_request_workflow_group] WITH CHECK ADD CONSTRAINT [fk_EmpReqWrkflGrp_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[approval_template] WITH CHECK ADD CONSTRAINT [fk_ApprTmp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[template_filter] WITH CHECK ADD CONSTRAINT [fk_TmpFilt_RefFiltTyp] FOREIGN KEY([filter_type]) 
REFERENCES [dbo].[ref_filter_type] ([filter_type]) 
GO
ALTER TABLE [dbo].[request_response_comment] WITH CHECK ADD CONSTRAINT [fk_ReqRespCmnt_ReqResp] FOREIGN KEY([request_response_id]) 
REFERENCES [dbo].[request_response] ([request_response_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_request_workflow_group] WITH CHECK ADD CONSTRAINT [fk_EmpReqWrkflGrp_ReqWrkflGrp] FOREIGN KEY([request_workflow_group_id]) 
REFERENCES [dbo].[request_workflow_group] ([request_workflow_group_id]) 
GO
ALTER TABLE [dbo].[approval_template] WITH CHECK ADD CONSTRAINT [fk_ApprTmp_RefApprDfltSort] FOREIGN KEY([default_sort_id]) 
REFERENCES [dbo].[ref_approval_default_sort] ([default_sort_id]) 
GO
ALTER TABLE [dbo].[template_filter] WITH CHECK ADD CONSTRAINT [fk_TmpFilt_Tmp] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[template] ([template_id]) 
GO
ALTER TABLE [dbo].[request_schedule_deviation] WITH CHECK ADD CONSTRAINT [fk_ReqSchdDvtn_RefDvtnCd] FOREIGN KEY([deviation_code]) 
REFERENCES [dbo].[ref_deviation_code] ([deviation_code]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[employee_schedule] WITH CHECK ADD CONSTRAINT [emp_sch_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[approval_template] WITH CHECK ADD CONSTRAINT [fk_ApprTmp_RefApprTyp] FOREIGN KEY([approval_type]) 
REFERENCES [dbo].[ref_approval_type] ([approval_type]) 
GO
ALTER TABLE [dbo].[template_instance] WITH CHECK ADD CONSTRAINT [fk_TmpInst_Sess] FOREIGN KEY([session_guid]) 
REFERENCES [dbo].[session] ([session_guid]) 
GO
ALTER TABLE [dbo].[request_schedule_deviation] WITH CHECK ADD CONSTRAINT [fk_ReqSchdDvtn_Req] FOREIGN KEY([request_id]) 
REFERENCES [dbo].[request] ([request_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_PayPd] FOREIGN KEY([pay_period_id]) 
REFERENCES [dbo].[pay_period] ([pay_period_id]) 
GO
ALTER TABLE [dbo].[employee_schedule] WITH CHECK ADD CONSTRAINT [fk_EmpSchd_SchdRul] FOREIGN KEY([schedule_rule_id]) 
REFERENCES [dbo].[schedule_rule] ([schedule_rule_id]) 
GO
ALTER TABLE [dbo].[attendance_accrual_request] WITH CHECK ADD CONSTRAINT [attendance_accr_req_FK1_empl] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[template_instance] WITH CHECK ADD CONSTRAINT [fk_TmpInst_Tmp] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[template] ([template_id]) 
GO
ALTER TABLE [dbo].[request_workflow] WITH CHECK ADD CONSTRAINT [fk_ReqWrkfl_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_RefCmprCd] FOREIGN KEY([compare_code]) 
REFERENCES [dbo].[ref_compare_code] ([compare_code]) 
GO
ALTER TABLE [dbo].[employee_script] WITH CHECK ADD CONSTRAINT [employee_script_FK1_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[audit_field] WITH CHECK ADD CONSTRAINT [aud_fld_FK1_aud_log] FOREIGN KEY([audit_id]) 
REFERENCES [dbo].[audit_log] ([audit_id]) 
GO
ALTER TABLE [dbo].[template_instance_employee] WITH CHECK ADD CONSTRAINT [tmp_inst_emp_FK1_tmp_inst] FOREIGN KEY([instance_id]) 
REFERENCES [dbo].[template_instance] ([instance_id]) 
GO
ALTER TABLE [dbo].[request_workflow_config] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflCfg_RefReqTyp] FOREIGN KEY([request_type]) 
REFERENCES [dbo].[ref_request_type] ([request_type]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_RefErnCd] FOREIGN KEY([earning_code]) 
REFERENCES [dbo].[ref_earning_code] ([earning_code]) 
GO
ALTER TABLE [dbo].[employee_script] WITH CHECK ADD CONSTRAINT [employee_script_FK3_script] FOREIGN KEY([script_id]) 
REFERENCES [dbo].[script] ([script_id]) 
GO
ALTER TABLE [dbo].[audit_log] WITH CHECK ADD CONSTRAINT [aud_log_FK1_ref_aud_act] FOREIGN KEY([audit_action]) 
REFERENCES [dbo].[ref_audit_action] ([audit_action]) 
GO
ALTER TABLE [dbo].[template_instance_employee] WITH CHECK ADD CONSTRAINT [tmp_inst_emp_FK2_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[request_workflow_config] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflCfg_ReqWrkfl] FOREIGN KEY([request_workflow_id]) 
REFERENCES [dbo].[request_workflow] ([request_workflow_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_EmpScndRate_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[audit_log] WITH CHECK ADD CONSTRAINT [aud_log_FK2_ref_aud_tbl] FOREIGN KEY([table_id]) 
REFERENCES [dbo].[ref_audit_table] ([table_id]) 
GO
ALTER TABLE [dbo].[template_instance_filter] WITH CHECK ADD CONSTRAINT [tmp_inst_flt_FK1_tmp_inst] FOREIGN KEY([instance_id]) 
REFERENCES [dbo].[template_instance] ([instance_id]) 
GO
ALTER TABLE [dbo].[request_workflow_config] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflCfg_ReqWrkflGrp] FOREIGN KEY([request_workflow_group_id]) 
REFERENCES [dbo].[request_workflow_group] ([request_workflow_group_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_RefPrmTyp] FOREIGN KEY([premium_type]) 
REFERENCES [dbo].[ref_premium_type] ([premium_type]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_EmpScndRate_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[audit_log] WITH CHECK ADD CONSTRAINT [aud_log_FK4_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[template_instance_filter] WITH CHECK ADD CONSTRAINT [tmp_isnt_flt_FK2_ref_flt_typ] FOREIGN KEY([filter_type]) 
REFERENCES [dbo].[ref_filter_type] ([filter_type]) 
GO
ALTER TABLE [dbo].[request_workflow_group] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflGrp_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[premium_rule_history] WITH CHECK ADD CONSTRAINT [fk_PrmRulHst_RefShftTyp] FOREIGN KEY([shift_type]) 
REFERENCES [dbo].[ref_shift_type] ([shift_type]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_EmpScndRate_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[audit_log] WITH CHECK ADD CONSTRAINT [fk_AudLog_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[template_master] WITH CHECK ADD CONSTRAINT [fk_TmpMst_RefTmpTyp] FOREIGN KEY([template_type]) 
REFERENCES [dbo].[ref_template_type] ([template_type]) 
GO
ALTER TABLE [dbo].[request_workflow_item] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflI_ReqWrkfl] FOREIGN KEY([request_workflow_id]) 
REFERENCES [dbo].[request_workflow] ([request_workflow_id]) 
GO
ALTER TABLE [dbo].[product_history] WITH CHECK ADD CONSTRAINT [prod_hist_FK1_ref_obj_typ] FOREIGN KEY([object_type]) 
REFERENCES [dbo].[ref_object_type] ([object_type]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_EmpScndRate_RefRateTyp] FOREIGN KEY([rate_type]) 
REFERENCES [dbo].[ref_rate_type] ([rate_type]) 
GO
ALTER TABLE [dbo].[calc_other_dollars] WITH CHECK ADD CONSTRAINT [fk_CalcOD_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[template_master_tag] WITH CHECK ADD CONSTRAINT [fk_TmpMstTag_RefTmpTag] FOREIGN KEY([tag_id]) 
REFERENCES [dbo].[ref_template_tag] ([tag_id]) 
GO
ALTER TABLE [dbo].[request_workflow_item_over] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflIOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[ref_accrual] WITH CHECK ADD CONSTRAINT [ref_accr_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate] WITH CHECK ADD CONSTRAINT [fk_EmpScndRate_RefShftTyp] FOREIGN KEY([shift_type]) 
REFERENCES [dbo].[ref_shift_type] ([shift_type]) 
GO
ALTER TABLE [dbo].[calc_other_dollars] WITH CHECK ADD CONSTRAINT [fk_CalcOD_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[template_master_tag] WITH CHECK ADD CONSTRAINT [fk_TmpMstTag_TmpMst] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[template_master] ([template_id]) 
GO
ALTER TABLE [dbo].[request_workflow_item_over] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflIOvr_ReqWrkflI] FOREIGN KEY([request_item_id], [request_item_type]) 
REFERENCES [dbo].[request_workflow_item] ([request_item_id], [request_item_type]) 
GO
ALTER TABLE [dbo].[ref_accrual_bucket] WITH CHECK ADD CONSTRAINT [ref_acc_bkt_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate_over] WITH CHECK ADD CONSTRAINT [fk_EmpScndRateOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[calc_other_dollars_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcODOL_CalcOD] FOREIGN KEY([calc_dollars_id]) 
REFERENCES [dbo].[calc_other_dollars] ([calc_dollars_id]) 
GO
ALTER TABLE [dbo].[template_process] WITH CHECK ADD CONSTRAINT [fk_TmpProc_TmpMst] FOREIGN KEY([template_id]) 
REFERENCES [dbo].[template_master] ([template_id]) 
GO
ALTER TABLE [dbo].[request_workflow_item_supervisor] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflISupr_ReqWrkflI] FOREIGN KEY([request_item_id], [request_item_type]) 
REFERENCES [dbo].[request_workflow_item] ([request_item_id], [request_item_type]) 
GO
ALTER TABLE [dbo].[ref_accrual_pay_type] WITH CHECK ADD CONSTRAINT [ref_acc_pay_typ_FK1_ref_acc_bkt] FOREIGN KEY([accrual_id]) 
REFERENCES [dbo].[ref_accrual_bucket] ([accrual_id]) 
GO
ALTER TABLE [dbo].[employee_secondary_rate_over] WITH CHECK ADD CONSTRAINT [fk_EmpScndRateOvr_EmpScndRate] FOREIGN KEY([rate_id]) 
REFERENCES [dbo].[employee_secondary_rate] ([rate_id]) 
GO
ALTER TABLE [dbo].[calc_other_dollars_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcODOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[template_process_parameter] WITH CHECK ADD CONSTRAINT [tmp_prc_prm_FK1_tmp_prc] FOREIGN KEY([template_process_id]) 
REFERENCES [dbo].[template_process] ([template_process_id]) 
GO
ALTER TABLE [dbo].[request_workflow_item_user] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflIUsr_ReqWrkflI] FOREIGN KEY([request_item_id], [request_item_type]) 
REFERENCES [dbo].[request_workflow_item] ([request_item_id], [request_item_type]) 
GO
ALTER TABLE [dbo].[ref_accrual_pay_type] WITH CHECK ADD CONSTRAINT [ref_acc_pay_typ_FK2_ref_pay_typ] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[employee_supervisor] WITH CHECK ADD CONSTRAINT [employee_supervisor_FK1_employee] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_other_hours] WITH CHECK ADD CONSTRAINT [fk_CalcOH_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[time_allocation] WITH CHECK ADD CONSTRAINT [fk_TmAlc_RefErnCd] FOREIGN KEY([earning_code]) 
REFERENCES [dbo].[ref_earning_code] ([earning_code]) 
GO
ALTER TABLE [dbo].[request_workflow_item_user] WITH CHECK ADD CONSTRAINT [fk_ReqWrkflIUsr_SecUsr] FOREIGN KEY([user_id]) 
REFERENCES [dbo].[security_user] ([user_id]) 
GO
ALTER TABLE [dbo].[ref_accrual_tran_type] WITH CHECK ADD CONSTRAINT [ref_acc_trn_type_FK1_ref_acc_cod] FOREIGN KEY([accrual_code]) 
REFERENCES [dbo].[ref_accrual_code] ([accrual_code]) 
GO
ALTER TABLE [dbo].[employee_supervisor] WITH CHECK ADD CONSTRAINT [employee_supervisor_FK2_employee] FOREIGN KEY([supervisor_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_other_hours] WITH CHECK ADD CONSTRAINT [fk_CalcOH_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[time_allocation] WITH CHECK ADD CONSTRAINT [tim_all_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[schedule_coverage] WITH CHECK ADD CONSTRAINT [sch_cov_FK1_company] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[ref_allowed_category] WITH CHECK ADD CONSTRAINT [ref_allow_cat_FK1_ref_hrs_type] FOREIGN KEY([hours_type]) 
REFERENCES [dbo].[ref_hours_type] ([hours_type]) 
GO
ALTER TABLE [dbo].[employee_time_allocation_comment] WITH CHECK ADD CONSTRAINT [emp_tim_all_com_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_other_hours_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcOHOL_CalcOH] FOREIGN KEY([calc_hours_id]) 
REFERENCES [dbo].[calc_other_hours] ([calc_hours_id]) 
GO
ALTER TABLE [dbo].[time_mileage] WITH CHECK ADD CONSTRAINT [tim_mil_FK1_tim_oth_dol] FOREIGN KEY([other_dollars_id]) 
REFERENCES [dbo].[time_other_dollars] ([other_dollars_id]) 
GO
ALTER TABLE [dbo].[schedule_coverage] WITH CHECK ADD CONSTRAINT [sch_cov_FK2_ref_sch_tim_inc] FOREIGN KEY([time_increment]) 
REFERENCES [dbo].[ref_schedule_time_increment] ([time_increment]) 
GO
ALTER TABLE [dbo].[ref_allowed_category] WITH CHECK ADD CONSTRAINT [ref_allow_typ_FK2_ref_pch_cat] FOREIGN KEY([punch_category]) 
REFERENCES [dbo].[ref_punch_category] ([punch_category]) 
GO
ALTER TABLE [dbo].[employee_time_approval] WITH CHECK ADD CONSTRAINT [emp_tim_appr_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_other_hours_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcOHOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[time_mileage] WITH CHECK ADD CONSTRAINT [tim_mil_FK2_ref_veh] FOREIGN KEY([vehicle_number]) 
REFERENCES [dbo].[ref_vehicle] ([vehicle_number]) 
GO
ALTER TABLE [dbo].[schedule_coverage_display] WITH CHECK ADD CONSTRAINT [sch_cov_dis_FK1_sch_cov] FOREIGN KEY([coverage_id]) 
REFERENCES [dbo].[schedule_coverage] ([coverage_id]) 
GO
ALTER TABLE [dbo].[ref_approval_column_type] WITH CHECK ADD CONSTRAINT [fk_RefApprColTyp_RefApprColPayTypCd] FOREIGN KEY([pay_types_code]) 
REFERENCES [dbo].[ref_approval_col_pay_types_code] ([pay_types_code]) 
GO
ALTER TABLE [dbo].[employee_time_approval] WITH CHECK ADD CONSTRAINT [emp_tim_appr_FK2_ref_appr_cod] FOREIGN KEY([approval_code]) 
REFERENCES [dbo].[ref_approval_code] ([approval_code]) 
GO
ALTER TABLE [dbo].[calc_payroll] WITH CHECK ADD CONSTRAINT [fk_CalcPayr_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[time_other_dollars] WITH CHECK ADD CONSTRAINT [fk_TmOD_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[schedule_coverage_display] WITH CHECK ADD CONSTRAINT [sch_cov_dis_FK2_ref_sch_dis] FOREIGN KEY([schedule_display_type]) 
REFERENCES [dbo].[ref_schedule_display] ([schedule_display_type]) 
GO
ALTER TABLE [dbo].[ref_attendance_cat_reason_code] WITH CHECK ADD CONSTRAINT [fk_RefAttCatRsnCd_RefAttCat] FOREIGN KEY([company_id], [attendance_category]) 
REFERENCES [dbo].[ref_attendance_category] ([company_id], [attendance_category]) 
GO
ALTER TABLE [dbo].[employee_vehicle] WITH CHECK ADD CONSTRAINT [emp_veh_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_payroll] WITH CHECK ADD CONSTRAINT [fk_CalcPayr_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[time_other_dollars] WITH CHECK ADD CONSTRAINT [fk_TmOD_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[schedule_coverage_display] WITH CHECK ADD CONSTRAINT [sch_cov_dis_FK3_ref_col] FOREIGN KEY([color_id]) 
REFERENCES [dbo].[ref_color] ([color_id]) 
GO
ALTER TABLE [dbo].[ref_attendance_cat_reason_code] WITH CHECK ADD CONSTRAINT [fk_RefAttCatRsnCd_RefRsnCd] FOREIGN KEY([reason_code]) 
REFERENCES [dbo].[ref_reason_code] ([reason_code]) 
GO
ALTER TABLE [dbo].[employee_vehicle] WITH CHECK ADD CONSTRAINT [emp_veh_FK2_ref_veh] FOREIGN KEY([vehicle_number]) 
REFERENCES [dbo].[ref_vehicle] ([vehicle_number]) 
GO
ALTER TABLE [dbo].[calc_payroll] WITH CHECK ADD CONSTRAINT [fk_CalcPayr_RefPayrSrcCd] FOREIGN KEY([source_code]) 
REFERENCES [dbo].[ref_payroll_source_code] ([source_code]) 
GO
ALTER TABLE [dbo].[time_other_dollars] WITH CHECK ADD CONSTRAINT [fk_TmOD_RefInpDev] FOREIGN KEY([device_num], [source_code]) 
REFERENCES [dbo].[ref_input_device] ([device_num], [source_code]) 
GO
ALTER TABLE [dbo].[schedule_deviation] WITH CHECK ADD CONSTRAINT [sch_dev_FK1_emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[ref_attendance_category] WITH CHECK ADD CONSTRAINT [ref_att_cat_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[employee_worktable] WITH CHECK ADD CONSTRAINT [fk_EmpWrk_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_payroll] WITH CHECK ADD CONSTRAINT [fk_CalcPayr_RefPayTyp] FOREIGN KEY([company_id], [pay_type]) 
REFERENCES [dbo].[ref_pay_type] ([company_id], [pay_type]) 
GO
ALTER TABLE [dbo].[time_other_dollars_over] WITH CHECK ADD CONSTRAINT [fk_TmODOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[schedule_deviation] WITH CHECK ADD CONSTRAINT [sch_dev_FK2_ref_dev_cod] FOREIGN KEY([deviation_code]) 
REFERENCES [dbo].[ref_deviation_code] ([deviation_code]) 
GO
ALTER TABLE [dbo].[ref_audit_field] WITH CHECK ADD CONSTRAINT [ref_aud_fld_FK1_ref_aud_tbl] FOREIGN KEY([table_id]) 
REFERENCES [dbo].[ref_audit_table] ([table_id]) 
GO
ALTER TABLE [dbo].[employee_worktable] WITH CHECK ADD CONSTRAINT [fk_EmpWrk_Emp2] FOREIGN KEY([supervisor_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[calc_payroll_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcPayrOL_CalcPayr] FOREIGN KEY([calc_payroll_id]) 
REFERENCES [dbo].[calc_payroll] ([calc_payroll_id]) 
GO
ALTER TABLE [dbo].[time_other_dollars_over] WITH CHECK ADD CONSTRAINT [fk_TmODOvr_TmOD] FOREIGN KEY([other_dollars_id]) 
REFERENCES [dbo].[time_other_dollars] ([other_dollars_id]) 
GO
ALTER TABLE [dbo].[schedule_deviation_over] WITH CHECK ADD CONSTRAINT [fk_SchdDvtnOvr_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[ref_error_severity] WITH CHECK ADD CONSTRAINT [fk_RefErrSev_Co] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[exception] WITH CHECK ADD CONSTRAINT [exception_FK1_ref_exception_type] FOREIGN KEY([exception_type]) 
REFERENCES [dbo].[ref_exception_type] ([exception_type]) 
GO
ALTER TABLE [dbo].[calc_payroll_org_level] WITH CHECK ADD CONSTRAINT [fk_CalcPayrOL_CoOLI] FOREIGN KEY([org_level_id]) 
REFERENCES [dbo].[company_org_level_item] ([org_level_id]) 
GO
ALTER TABLE [dbo].[time_other_dollars_script] WITH CHECK ADD CONSTRAINT [fk_TmODScr_TmOD] FOREIGN KEY([other_dollars_id]) 
REFERENCES [dbo].[time_other_dollars] ([other_dollars_id]) 
GO
ALTER TABLE [dbo].[schedule_deviation_over] WITH CHECK ADD CONSTRAINT [fk_SchdDvtnOvr_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[ref_error_severity] WITH CHECK ADD CONSTRAINT [fk_RefErrSev_ErrMsg] FOREIGN KEY([error_number]) 
REFERENCES [dbo].[error_message] ([error_number]) 
GO
ALTER TABLE [dbo].[exception] WITH CHECK ADD CONSTRAINT [exception_FK2_alert] FOREIGN KEY([alert_id]) 
REFERENCES [dbo].[alert] ([alert_id]) 
GO
ALTER TABLE [dbo].[calc_punch] WITH CHECK ADD CONSTRAINT [fk_CalcPnch_Emp] FOREIGN KEY([employee_id]) 
REFERENCES [dbo].[employee] ([employee_id]) 
GO
ALTER TABLE [dbo].[time_other_hours] WITH CHECK ADD CONSTRAINT [fk_TmOH_Cmnt] FOREIGN KEY([comment_id]) 
REFERENCES [dbo].[comment] ([comment_id]) 
GO
ALTER TABLE [dbo].[schedule_group] WITH CHECK ADD CONSTRAINT [sch_grp_FK1_cmp] FOREIGN KEY([company_id]) 
REFERENCES [dbo].[company] ([company_id]) 
GO
ALTER TABLE [dbo].[ref_error_severity] WITH CHECK ADD CONSTRAINT [fk_RefErrSev_RefSysCd] FOREIGN KEY([system_code]) 
REFERENCES [dbo].[ref_system_code] ([system_code]) 
GO
