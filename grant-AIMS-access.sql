USE SLIS
GO

ALTER TABLE [dbo].[asiemp] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[dbuser] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[d_person] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[d_pos] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[emp_i9_data] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[emp_i9_document] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[pay] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[person] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[pos] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[usergrp] DISABLE TRIGGER ALL
ALTER TABLE [dbo].[w4fed] DISABLE TRIGGER ALL
GO


EXEC [dbo].[SetupAIMSContractor] '99sxdiaz', 271883950, 'SD','CONTRACTOR', 'F';  --Sterling Diaz
EXEC [dbo].[SetupAIMSContractor] '99cxmore', 271883951, 'CM','CONTRACTOR', 'F'; --Cleiry Moreno
EXEC [dbo].[SetupAIMSContractor] '99vxabda', 271883952, 'VA','CONTRACTOR', 'F'; --Victor Abdala
EXEC [dbo].[SetupAIMSContractor] '99fxmart', 271883956, 'FM','CONTRACTOR', 'F';   --Fryann Martinez
EXEC [dbo].[SetupAIMSContractor] '99fxgarc', 271883958, 'FG','CONTRACTOR', 'F';  --Felix Garcia
EXEC [dbo].[SetupAIMSContractor] '99bxgarz', 271883959, 'BG','CONTRACTOR', 'F';  --Breyner Garzon
EXEC [dbo].[SetupAIMSContractor] '99axdelg', 271883960, 'AD','CONTRACTOR', 'F';  --Alejandro Del Genio
EXEC [dbo].[SetupAIMSContractor] '99exonai', 271883964, 'EO','CONTRACTOR', 'F'; --Erick Onaindia

--QAs: HD 721627 
EXEC [dbo].[SetupAIMSContractor] '99axbote', 271883961, 'AB','CONTRACTOR', 'F'; --Alejandro Botero
EXEC [dbo].[SetupAIMSContractor] '99lxjime', 271883962, 'LJ','CONTRACTOR', 'F';    --Lisseth Jimenez
EXEC [dbo].[SetupAIMSContractor] '99jxorte', 271883963, 'JO','CONTRACTOR', 'F';   --Jhonatan Ortega
EXEC [dbo].[SetupAIMSContractor] '99axgarc', 271883955, 'AG','CONTRACTOR', 'F'; --Andres Garcia

--QA's added 1/08/2024 HD 749157
EXEC [dbo].[SetupAIMSContractor] '99axllam', 271883965, 'ALV','CONTRACTOR', 'F';  --Angie Llamocca Vidal 
EXEC [dbo].[SetupAIMSContractor] '99jxgonz', 271883966, 'JGM','CONTRACTOR', 'F';  --Joaquin Gonzales Mosquera 

--request from James Navaira on 6/6/2024
EXEC [dbo].[SetupAIMSContractor] '99jxsabo', 271883967, 'JS','CONTRACTOR', 'F';  --Jeison Saborio
EXEC [dbo].[SetupAIMSContractor] '99jxrosa', 271883968, 'JR','CONTRACTOR', 'F';  --Jean Rosario

--request from Gotham Kodavatikanti on 6/24
EXEC [dbo].[SetupAIMSContractor] '99lxmora', 271883969, 'LM','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99gxtala', 271883970, 'GTA','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99bxshim', 271883971, 'BSS','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99ixramx', 271883972, 'IR','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99vspamu', 271883973, 'VSP','CONTRACTOR', 'F';

--request from Gotham Kodavatikanti on 6/27
EXEC [dbo].[SetupAIMSContractor] '99rxshiv', 271883974, 'RS','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99pxmyla', 271883975, 'PBM','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99cxmadd', 271883976, 'CKM','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99gxgose', 271883977, 'GG','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99hxmulp', 271883978, 'HSM','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99sxkumb', 271883979, 'SK','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99cxkoni', 271883980, 'CK','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99sxmann', 271883981, 'SR','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99nxkoda', 271883982, 'NK','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99pxdala', 271883983, 'PD','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99bxchen', 271883984, 'BC','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99sxnamb', 271883985, 'SSN','CONTRACTOR', 'F'; 
EXEC [dbo].[SetupAIMSContractor] '99kxdhin', 271883986, 'KKD','CONTRACTOR', 'F';
EXEC [dbo].[SetupAIMSContractor] '99axtall', 271883987, 'AKT','CONTRACTOR', 'F';
EXEC [dbo].[SetupAIMSContractor] '99akvitt', 271883988, 'AKV','CONTRACTOR', 'F';
EXEC [dbo].[SetupAIMSContractor] '99nxkoth', 271883989, 'NSK','CONTRACTOR', 'F';
EXEC [dbo].[SetupAIMSContractor] '99kxkond', 271883990, 'KK','CONTRACTOR', 'F';	
EXEC [dbo].[SetupAIMSContractor] '99cxfern', 271883991, 'CF','CONTRACTOR', 'F';
EXEC [dbo].[SetupAIMSContractor] '99axdani', 271883992, 'AD','CONTRACTOR', 'F';

--request from James Navaira Ticket 979478 2025-06-17
EXEC [dbo].[SetupAIMSContractor] '99exsoza ', 271883888, 'JANE','CONTRACTOR', 'F';

-- requests from week of 6/30/2025 -7/3/2025
EXEC [dbo].[SetupAIMSContractor] '99jxfebr', 271883993, 'JF','CONTRACTOR', 'F';

 --Ticket 922830
EXEC [dbo].[SetupAIMSContractor] '99lxguti', 271883994, 'LGA','CONTRACTOR', 'F';

--Ticket 922865  (also  refer the ticket # 837569 or 795436 for reference. )
ALTER TABLE [dbo].[asiemp] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[dbuser] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[d_person] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[d_pos] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[emp_i9_data] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[emp_i9_document] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[pay] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[person] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[pos] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[usergrp] ENABLE TRIGGER ALL
ALTER TABLE [dbo].[w4fed] ENABLE TRIGGER ALL
GO
