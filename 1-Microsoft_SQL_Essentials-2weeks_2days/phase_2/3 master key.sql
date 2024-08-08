-- Connect to CompanyDB
USE CompanyDB;
GO

-- Create the stored procedure
CREATE PROCEDURE dbo.CreateMasterKeyIfNotExists
AS
BEGIN
    -- Check if the master key exists
    IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
    BEGIN
        -- Create the master key
        CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@$sW0rd';
    END
END;
GO

-- Execute the stored procedure
--EXEC dbo.CreateMasterKeyIfNotExists;
