USE CompanyDB;
GO

CREATE PROCEDURE Staff.InsertDataFromAnotherDatabase 
AS 
BEGIN
    -- Create temporary tables and insert data
    SELECT DepartmentID, DepartmentName
    INTO #TempDepartments
    FROM Staff.ExternalDepartments;

    SELECT EmployeeID, FirstName, LastName, DepartmentID
    INTO #TempEmployees
    FROM Staff.ExternalEmployees;

    SELECT ProjectID, ProjectName
    INTO #TempProjects
    FROM Staff.ExternalProjects;

    SELECT AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate
    INTO #TempAssignments
    FROM Staff.ExternalAssignments;

    -- Merge data into Staff.Departments
    MERGE Staff.Departments AS target
    USING #TempDepartments AS source
    ON target.DepartmentID = source.DepartmentID
    WHEN MATCHED THEN 
        UPDATE SET 
            target.DepartmentName = source.DepartmentName
    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (DepartmentID, DepartmentName)
        VALUES (source.DepartmentID, source.DepartmentName);

    -- Merge data into Staff.Employees
    MERGE Staff.Employees AS target
    USING #TempEmployees AS source
    ON target.EmployeeID = source.EmployeeID
    WHEN MATCHED THEN 
        UPDATE SET 
            target.FirstName = source.FirstName, 
            target.LastName = source.LastName, 
            target.DepartmentID = source.DepartmentID
    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (EmployeeID, FirstName, LastName, DepartmentID)
        VALUES (source.EmployeeID, source.FirstName, source.LastName, source.DepartmentID);

    -- Merge data into Staff.Projects
    MERGE Staff.Projects AS target
    USING #TempProjects AS source
    ON target.ProjectID = source.ProjectID
    WHEN MATCHED THEN 
        UPDATE SET 
            target.ProjectName = source.ProjectName
    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (ProjectID, ProjectName)
        VALUES (source.ProjectID, source.ProjectName);

    -- Merge data into Staff.Assignments
    MERGE Staff.Assignments AS target
    USING #TempAssignments AS source
    ON target.AssignmentID = source.AssignmentID
    WHEN MATCHED THEN 
        UPDATE SET 
            target.EmployeeID = source.EmployeeID, 
            target.ProjectID = source.ProjectID, 
            target.Role = source.Role, 
            target.StartDate = source.StartDate, 
            target.EndDate = source.EndDate
    WHEN NOT MATCHED BY TARGET THEN 
        INSERT (AssignmentID, EmployeeID, ProjectID, Role, StartDate, EndDate)
        VALUES (source.AssignmentID, source.EmployeeID, source.ProjectID, source.Role, source.StartDate, source.EndDate);

    -- Drop temporary tables
    DROP TABLE #TempDepartments;
    DROP TABLE #TempEmployees;
    DROP TABLE #TempProjects;
    DROP TABLE #TempAssignments;
END;
GO

-- Execute the stored procedure
EXEC Staff.InsertDataFromAnotherDatabase;
GO

-- Drop the stored procedure
DROP PROCEDURE Staff.InsertDataFromAnotherDatabase;
GO
