/* Searches all columns in every table of a database 
   Looks for PII PHI data if you know the columns name to look for...

   *** You must put the columns names into the WHERE clause below. ***
*/

SELECT s.[name]        AS [SchemaName],
       t.[name]        AS [TableName],
       c.[name]        AS [ColumnName],
       t2.[name]       AS [DataType]--,
--       c.[max_length]  AS [MaxLength],
--       c.[precision]   AS [Precision],
--       c.[scale]       AS [Scale],
--       c.[is_nullable] AS [IsNullable]
FROM sys.[columns] c
    INNER JOIN sys.[tables] t  ON [c].[object_id] = [t].[object_id]
    INNER JOIN sys.[types] t2  ON c.[system_type_id] = t2.[system_type_id]
    INNER JOIN sys.[schemas] s ON t.[schema_id] = s.[schema_id]
WHERE t.[is_ms_shipped] = 0
    AND t2.[name] <> 'SYSNAME'
    AND c.[name] IN  (
    'dateofBirth', 'DOB', 'birthdate', 'birth_date', 'date_of_birth','PerID', 'Per_ID', 'EmployeePerID', 'ContactPerID', 'PersonId', 'AimsPersonID', 'AimsID', 'NSPEmployeeID','SSN', 'emp_ssn', 'emp_new_ssn', 'SSNO', 'SS_Number', 'primer_ssno', 'SocialSecurityNumber', 'PersonLegalId',
    'passport_number','alien_number', 'alien_card_number', 'USCIS_number', 'USCIS_receipt_number', 'green_card_number',
    'cdl_number','dhs_case_number', ', i94_number', 'Drivers_License', 
    'EmailAddr', 'EmailAddress', 'ContactEmail', 'Email', 'mail', 'CreatedByEmail', 'enrollmentdata',
    'AccountName','AccountFullName','401KAccountID','401KAmount','AccountID','AccountLabel','AccountName','AccountNumber', 'ACHAcct', 'actno_rtno', 'rtno', 'actno', 'employeeAccountNumber', 'RoutingNumber',
    'cardHolderName', 'cardNumber', 'CCNumber','CreditCard','CreditCardID',
    'employeeName', 'employee', 'employeeRoutingNumber', 
    'UserName',  'userPrincipalName', 'NetworkUserID', 
    'FName', 'FirstName', 'first_name', 'emp_fname', 'Legal_FName',
    'middle_name', 'MName', 'MiddleName', 
    'last_name', 'Lname',  'Lastname', 'GivenName', 'FamilyName', 'emp_lname', 'Legal_LName', 'Name', 'OneForceName','PreferredName', 'NickName','Nick_Name',
    'other names','NickName', 'Nick_Name', 'PreferredName', 
    'ProxyFirstName', 'ProxyLastName','ProxyMiddleName', 'ContactFirstName', 'ContactLastName', 'ContactEmail',
    'Password', 'PWD',  
    'cell','CellPhone','clt_contact_phone','ContactPhone','fxphone','home_phone','HomePhone','HomePhoneNumber','mobile', 'mobile_phone','office_phone','phone','phone2','PhoneNumber','work_phone','WorkPhone','WorkPhoneNumber',
    'a_c_phone','a_c_phone','c_phone','l_c_eephone','l_c_fxphone','l_c_phone','l_c_phone_extn','l_faxphone','l_i_phone_id_new','l_phone','l_str_ee_address_record_fxphone',
    'l_str_ee_address_record_phone','m_c_cpny_phone','m_c_new_cpny_phone','m_faxphone','m_phone','m_str_nbid_record_phone','m_str_null_nbid_record_phone','r_faxphone',
    't_clt_address_record_fxphone','t_clt_address_record_phone','t_nbid_record_PHONE',
    'Address', 'Address1', 'Street',  'City', 'ZipCode', 'zip',
    'JobTitle', 
    'Gender', 'Sex', 
    'Religion', 
    'Race', 'Ethnicity',
    'IP_Address', 'IPAddress', 'IP',
    'Wage','PayAmount','netpay','GrossWage', 'Salary','TaxableWage', 'Taxes', 'Tax','Commission', 'Bonus',
    '401KAmount','AmountPerUnit','GroPay', 'pay_rate', 'debamt', 'rate_ext','Rec_Rate', 'Rec_Amt','Rec_Units', 'Units_ext'
     )
ORDER BY SchemaName, TableName, ColumnName;