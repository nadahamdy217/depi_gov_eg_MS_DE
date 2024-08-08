USE CompanyDB;
GO

CREATE PROCEDURE Staff.setup_insertion
AS
BEGIN
    -- Create database scoped credential
    IF NOT EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'ExternalDBCredential')
    BEGIN
        EXEC('
        CREATE DATABASE SCOPED CREDENTIAL ExternalDBCredential
        WITH
            IDENTITY = ''Admin$$Trat0r'',
            SECRET = ''P@$sW0rd''
        ');
    END;

    -- Drop the existing external tables if they exist
    IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalEmployees')
    BEGIN
        DROP EXTERNAL TABLE Staff.ExternalEmployees;
    END;

    IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalDepartments')
    BEGIN
        DROP EXTERNAL TABLE Staff.ExternalDepartments;
    END;

    IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalProjects')
    BEGIN
        DROP EXTERNAL TABLE Staff.ExternalProjects;
    END;

    IF EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalAssignments')
    BEGIN
        DROP EXTERNAL TABLE Staff.ExternalAssignments;
    END;

    -- Drop the existing external data source if it exists
    IF EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'SourceDB')
    BEGIN
        EXEC('DROP EXTERNAL DATA SOURCE SourceDB');
    END;

    -- Create external data source
    EXEC('
    CREATE EXTERNAL DATA SOURCE SourceDB
    WITH
    (
        TYPE = RDBMS,
        LOCATION = ''companyservertest.database.windows.net'',
        DATABASE_NAME = ''SourceDB'',
        CREDENTIAL = ExternalDBCredential
    )');

    -- Create schema Staff if it doesn't exist
    IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Staff')
    BEGIN
        EXEC ('CREATE SCHEMA Staff');
    END;

    -- Create external tables referencing SourceDB
    IF NOT EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalEmployees')
    BEGIN
        EXEC('
        CREATE EXTERNAL TABLE Staff.ExternalEmployees
        (
            EmployeeID INT,
            FirstName NVARCHAR(50),
            LastName NVARCHAR(50),
            DepartmentID INT
        )
        WITH
        (
            DATA_SOURCE = SourceDB,
            SCHEMA_NAME = ''dbo'',
            OBJECT_NAME = ''Employees''
        )');
    END;

    IF NOT EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalDepartments')
    BEGIN
        EXEC('
        CREATE EXTERNAL TABLE Staff.ExternalDepartments
        (
            DepartmentID INT,
            DepartmentName NVARCHAR(50)
        )
        WITH
        (
            DATA_SOURCE = SourceDB,
            SCHEMA_NAME = ''dbo'',
            OBJECT_NAME = ''Departments''
        )');
    END;

    IF NOT EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalProjects')
    BEGIN
        EXEC('
        CREATE EXTERNAL TABLE Staff.ExternalProjects
        (
            ProjectID INT,
            ProjectName NVARCHAR(50)
        )
        WITH
        (
            DATA_SOURCE = SourceDB,
            SCHEMA_NAME = ''dbo'',
            OBJECT_NAME = ''Projects''
        )');
    END;

    IF NOT EXISTS (SELECT * FROM sys.external_tables WHERE name = 'ExternalAssignments')
    BEGIN
        EXEC('
        CREATE EXTERNAL TABLE Staff.ExternalAssignments
        (
            AssignmentID INT,
            EmployeeID INT,
            ProjectID INT,
            Role NVARCHAR(50),
            StartDate DATE,
            EndDate DATE
        )
        WITH
        (
            DATA_SOURCE = SourceDB,
            SCHEMA_NAME = ''dbo'',
            OBJECT_NAME = ''Assignments''
        )');
    END;
END;
GO
