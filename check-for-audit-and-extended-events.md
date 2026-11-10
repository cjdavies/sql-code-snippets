Use these checks at the server level.

For SQL Server Audit:

    -- 1) Is any server audit defined, and is it enabled?
    SELECT
        a.name,
        a.is_state_enabled,         -- 1 = enabled, 0 = disabled
        a.type_desc,
        a.queue_delay,
        a.on_failure_desc
    FROM sys.server_audits AS a
    ORDER BY a.name;

    -- 2) Is the audit actually running right now?
    SELECT
        s.name,
        s.status_desc,              -- STARTED / STOPPED / FAILED
        s.status_time,
        s.audit_file_path
    FROM sys.dm_server_audit_status AS s
    ORDER BY s.name;

    -- 3) What is being audited at server scope?
    SELECT
        sas.name AS server_audit_spec_name,
        sa.name  AS audit_name,
        sas.is_state_enabled,
        sad.audit_action_name,
        sad.class_desc,
        sad.major_id,
        sad.principal_id
    FROM sys.server_audit_specifications AS sas
    JOIN sys.server_audits AS sa
      ON sas.audit_guid = sa.audit_guid
    JOIN sys.server_audit_specification_details AS sad
      ON sas.server_specification_id = sad.server_specification_id
    ORDER BY sas.name, sad.audit_action_name;

    -- 4) What is being audited at database scope (run in each DB you care about)?
    SELECT
        das.name AS db_audit_spec_name,
        sa.name  AS audit_name,
        das.is_state_enabled,
        dad.audit_action_name,
        dad.class_desc,
        dad.major_id
    FROM sys.database_audit_specifications AS das
    JOIN sys.server_audits AS sa
      ON das.audit_guid = sa.audit_guid
    JOIN sys.database_audit_specification_details AS dad
      ON das.database_specification_id = dad.database_specification_id
    ORDER BY das.name, dad.audit_action_name;

For Extended Events:

    -- 1) Defined XE sessions
    SELECT
        es.name,
        es.startup_state,           -- starts automatically with SQL Server
        es.create_time
    FROM sys.server_event_sessions AS es
    ORDER BY es.name;

    -- 2) Currently running XE sessions
    SELECT
        xs.name,
        xs.create_time
    FROM sys.dm_xe_sessions AS xs
    ORDER BY xs.name;

    -- 3) Session status in one view (running vs not running)
    SELECT
        es.name,
        es.startup_state,
        CASE WHEN xs.name IS NULL THEN 'NOT RUNNING' ELSE 'RUNNING' END AS run_state
    FROM sys.server_event_sessions AS es
    LEFT JOIN sys.dm_xe_sessions AS xs
      ON es.name = xs.name
    ORDER BY es.name;

If your goal is specifically “who inserted rows,” then in Audit/XE results look for actions/events tied to INSERT on your target table and capture fields like server_principal_name, session_id, client_hostname, application_name.

If you want, I can give you a single ready-to-run script that checks both features and flags whether they currently capture INSERT activity for one table.