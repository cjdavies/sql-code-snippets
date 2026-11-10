If your database is the source of truth and your Git repository is out of sync, the general process is:

Extract the current database schema.
Compare it to the repository.
Generate scripts for missing changes.
Commit the updated schema to Git.

The exact steps depend on how the repository was created and which tooling you're using.

## Option 1: SQL Server Database Projects (SSDT / Azure Data Studio SQL Projects)

This is the most common approach.

Import the database into the project

In Visual Studio:

Open the existing database project.
Right-click the project.
Select Schema Compare.
Set:
Source = Database
Target = Database Project
Click Compare.
Review differences.
Click Update to update the project files from the database.

Alternatively, if the project is badly out of date:

Create a new SQL Database Project.
Import the database schema:
Right-click project
Import > Database
Replace the schema files in the repository.
Commit the changes.

## Option 2: Generate Scripts from the Database

If the repository contains .sql object files:

Using SSMS
Right-click database.
Tasks → Generate Scripts.
Choose:
Schema only
Script entire database or selected objects
Save scripts.

Then:

Replace/update the corresponding files in Git.
Commit the changes.

Be careful because generated scripts often differ in formatting from hand-maintained scripts and may create a large diff.

## Option 3: Use Schema Compare

This is usually the safest method.

Tools:

Visual Studio SSDT
Azure Data Studio SQL Database Projects extension
Redgate SQL Compare
ApexSQL Diff

Workflow:

Production Database
        |
        v
 Schema Compare
        |
        v
 Git Repository


The tool identifies:

New tables
Missing columns
Modified constraints
Index differences
Stored procedure changes
View changes

You can then synchronize the repository from the database.

## Option 4: Rebuild a DACPAC-Based Repository

If your deployment process uses DACPACs:

SqlPackage /Action:Extract `
           /SourceServerName:MyServer `
           /SourceDatabaseName:MyDatabase `
           /TargetFile:MyDatabase.dacpac


Then:

Import the DACPAC into a SQL Database Project.
Generate project files.
Commit the updated files.
Recommended Approach

As a Database Architect, I'd generally recommend:

Create a backup of the database.
Perform a Schema Compare between:
Actual database
Git project
Review all differences manually.
Update the project.
Commit the resulting changes.
Investigate why changes were made directly in the database instead of through source control.

If direct database changes have occurred, it's often valuable to create migration scripts representing those changes so the repository preserves the change history rather than simply replacing files with the current state. This keeps future deployments reproducible and auditable.
