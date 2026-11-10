DECLARE @env VARCHAR(10) = (SELECT cast(value AS varchar(10)) FROM [master].[sys].fn_listextendedproperty('environment', default, default, default, default, default, default));
IF @env <> 'prod'
    BEGIN
        PRINT @env
    END;
GO