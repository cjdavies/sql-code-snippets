EXEC sp_msforeachdb 
    'IF EXISTS
    (
        SELECT 1 
        FROM   [?].sys.objects 
        WHERE  [name] LIKE ''add_sub_client''
    )
    SELECT 
        ''?''     AS Database, 
        [name]    AS Name, 
        type_desc AS Type 
    FROM [?].sys.objects 
    WHERE [name] LIKE ''add_sub_client''';

--sp_MSforeachdb 'SELECT db_name(), * FROM ?..sysobjects WHERE [xtype] IN (''FN'', ''IF'', ''P'') AND [name] = ''add_sub_client''';

/*
TYPE TYPE_DESC
C 	 CHECK_CONSTRAINT
D 	 DEFAULT_CONSTRAINT
F 	 FOREIGN_KEY_CONSTRAINT
FN	 SQL_SCALAR_FUNCTION
IF	 SQL_INLINE_TABLE_VALUED_FUNCTION
IT	 INTERNAL_TABLE
P 	 SQL_STORED_PROCEDURE
PK	 PRIMARY_KEY_CONSTRAINT
S 	 SYSTEM_TABLE
SN	 SYNONYM
SQ	 SERVICE_QUEUE
TF	 SQL_TABLE_VALUED_FUNCTION
TR	 SQL_TRIGGER
TT	 TYPE_TABLE
U 	 USER_TABLE
UQ	 UNIQUE_CONSTRAINT
V 	 VIEW
*/