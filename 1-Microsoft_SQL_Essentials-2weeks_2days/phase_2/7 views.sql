-- Stored procedure for EmployeeCurrentProject view
CREATE PROCEDURE Staff.CreateView
AS
BEGIN
    -- Drop the view if it already exists (optional, depending on your needs)
    IF OBJECT_ID('EmployeeCurrentProject', 'V') IS NOT NULL
    BEGIN
        DROP VIEW EmployeeCurrentProject;
    END

    -- Create the view about a list of currently assigned employees along with their project details
    exec('
    CREATE VIEW EmployeeCurrentProject AS
    SELECT 
    e.EmployeeID, 
    e.FirstName, 
    e.LastName, 
    p.ProjectName, 
    a.Role
    FROM 
    staff.Employees e
    JOIN staff.Assignments a 
    ON e.EmployeeID = a.EmployeeID
    JOIN staff.Projects p 
    ON a.ProjectID = p.ProjectID
    WHERE 
    a.EndDate IS NULL; -- Assuming NULL EndDate means currently assigned
    ');

    -- Create the view about a list of currently assigned employees along with their project details
    exec('
    CREATE VIEW EmployeeDepartmentDetails AS
    SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
    FROM 
    staff.Employees e
    JOIN 
    staff.Departments d ON e.DepartmentID = d.DepartmentID;
    ');
END;

GO 

-- drop procedure CreateView