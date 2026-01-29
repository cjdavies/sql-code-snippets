-- The context key is case sensitive.

CREATE TABLE Test (
    TestId   INT NOT NULL CONSTRAINT PK_test PRIMARY KEY,
    TenantId INT NOT NULL
);
GO
ALTER TABLE Test
    ADD CONSTRAINT df_TenantId_Test
    DEFAULT CAST(SESSION_CONTEXT(N'TenantId') AS INT) FOR TenantId;
GO

EXEC sp_set_session_context @key = 'TenantId', @value = 1234;

INSERT INTO Test (TestId) VALUES (1);
GO

SELECT * FROM Test;

TestId	TenantId
1	    1234