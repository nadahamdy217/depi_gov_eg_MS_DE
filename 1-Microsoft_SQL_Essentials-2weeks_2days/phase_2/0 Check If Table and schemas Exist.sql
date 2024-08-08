-- Ensure CompanyDB exists
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'CompanyDB')
BEGIN
    EXEC('CREATE DATABASE CompanyDB');
END
GO

-- Switch to CompanyDB context
USE CompanyDB;
GO

-- Create the Staff schema if it does not exist
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Staff')
BEGIN
    EXEC('CREATE SCHEMA Staff');
END
GO
