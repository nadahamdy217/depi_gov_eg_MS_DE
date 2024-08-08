use companyDB
GO

CREATE PROCEDURE Staff.CreateConstraintsAndRelationships 
AS 
BEGIN
    ALTER TABLE Staff.Employees
     ADD
         CONSTRAINT employees_fk FOREIGN KEY (DepartmentID)
               REFERENCES Staff.Departments(DepartmentID)
         

    ALTER TABLE Staff.Assignments
     ADD
            CONSTRAINT assignments_fk1 FOREIGN KEY (EmployeeID)
                       REFERENCES Staff.Employees(EmployeeID),

            CONSTRAINT assignments_fk2 FOREIGN KEY (ProjectID)
                        REFERENCES Staff.Projects(ProjectID),

            CONSTRAINT CHK_Dates CHECK (StartDate < EndDate)

End;
go

exec Staff.CreateConstraintsAndRelationships 
--drop PROCEDURE Staff.CreateConstraintsAndRelationships;