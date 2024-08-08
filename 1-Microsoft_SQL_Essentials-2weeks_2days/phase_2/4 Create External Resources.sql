USE CompanyDB;
GO

-- Drop the procedure if it already exists
IF OBJECT_ID('Staff.CreateExternalResources', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE Staff.CreateExternalResources;
END
GO

-- Create the procedure
CREATE PROCEDURE Staff.CreateExternalResources
AS
BEGIN
    -- Create database scoped credential if it does not exist
    IF NOT EXISTS (SELECT * FROM sys.database_scoped_credentials WHERE name = 'ExternalDBCredential')
    BEGIN
        EXEC('
        CREATE DATABASE SCOPED CREDENTIAL ExternalDBCredential
        WITH
            IDENTITY = ''Admin$$Trat0r'',
            SECRET = ''P@$sW0rd''
        ');
    END;

    -- Drop the external data source if it exists
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
    )
    ');
END;
GO
drop PROCEDURE Staff.CreateExternalResources;
