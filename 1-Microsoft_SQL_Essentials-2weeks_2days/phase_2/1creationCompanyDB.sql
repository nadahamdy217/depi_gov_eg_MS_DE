USE CompanyDB;
GO

-- Create the Staff schema and tables if they do not exist
CREATE PROCEDURE Staff.creation
AS
BEGIN
    -- Create the Staff schema if it does not exist
    IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Staff')
    BEGIN
        EXEC('CREATE SCHEMA Staff');
    END;

    -- Create tables if they do not exist
    IF OBJECT_ID(N'Staff.Employees', N'U') IS NULL
    BEGIN
        EXEC('
        CREATE TABLE Staff.Employees (
            EmployeeID INT PRIMARY KEY,
            FirstName NVARCHAR(50) NOT NULL,
            LastName NVARCHAR(50) NOT NULL,
            DepartmentID INT
        )');
    END;

    IF OBJECT_ID(N'Staff.Departments', N'U') IS NULL
    BEGIN
        EXEC('
        CREATE TABLE Staff.Departments (
            DepartmentID INT PRIMARY KEY,
            DepartmentName NVARCHAR(100) NOT NULL,
            Location NVARCHAR(100)
        )');
    END;

    IF OBJECT_ID(N'Staff.Projects', N'U') IS NULL
    BEGIN
        EXEC('
        CREATE TABLE Staff.Projects (
            ProjectID INT PRIMARY KEY,
            ProjectName NVARCHAR(100),
            StartDate DATE,
            EndDate DATE,
            Budget MONEY
        )');
    END;

    IF OBJECT_ID(N'Staff.Assignments', N'U') IS NULL
    BEGIN
        EXEC('
        CREATE TABLE Staff.Assignments (
            AssignmentID INT PRIMARY KEY,
            EmployeeID INT,
            ProjectID INT,
            [Role] NVARCHAR(50),
            StartDate DATE,
            EndDate DATE
        )');
    END;
END;
GO


