In **SQL Server Management Studio (SSMS) 22**, you can view the **SQL Server Agent logs** from **Object Explorer**:

1. Connect to your SQL Server instance.
2. Expand the server node.
3. Expand **SQL Server Agent**.
4. Expand **Error Logs**.
5. Double-click a log, or right-click it and select **View Agent Log**. [\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/ssms/agent/view-sql-server-agent-error-log-sql-server-management-studio)

The path is:

```text
Object Explorer
└── SQL Server Agent
    └── Error Logs
        ├── Current
        ├── Archive #1
        ├── Archive #2
        └── ...
```

If you don't see the **SQL Server Agent** node:

* Verify that the **SQL Server Agent service is running**.
* Ensure your login has permissions to view and manage SQL Server Agent. Object Explorer only displays the SQL Server Agent node when you have access to it. [\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/ssms/agent/view-sql-server-agent-error-log-sql-server-management-studio), [\[docs.rackspace.com\]](https://docs.rackspace.com/docs/review-mssql-server-agent-logs)

You can also view the underlying log file location with T-SQL:

```sql
EXEC msdb.dbo.sp_get_sqlagent_properties;
```

Look for the **errorlog\_file** value, which shows the physical Agent log file path.

For troubleshooting SQL Agent jobs, it's also useful to check:

```text
SQL Server Agent
└── Jobs
    └── <Job Name>
        └── View History
```

Job History often contains execution details that don't appear in the Agent error log.
