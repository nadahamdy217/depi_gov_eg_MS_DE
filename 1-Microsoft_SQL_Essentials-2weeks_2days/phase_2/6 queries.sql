USE CompanyDB
GO

CREATE PROCEDURE Staff.PerformQueryTasks
AS
BEGIN
-- get employees table
select * from Staff.Employees

-- get projects table
SELECT * from Staff.Projects

-- get department info
select * from Staff.Departments

-- a summary of employees' names and positions within each department

select 
FirstName + ' ' + LastName as full_name,
DepartmentName
from Staff.Employees e 
join Staff.Departments d
on e.DepartmentID = d.DepartmentID


-- retrieve info about  empolyees and their assigned assignments
select 
FirstName + ' ' + LastName as full_name,
StartDate,
EndDate
from Staff.Employees e
join Staff.Assignments a
on e.EmployeeID = a.EmployeeID
where EndDate is not null
ORDER by StartDate DESC


-- get employees who are assgined to multible assignments
SELECT 
e.FirstName,
e.LastName,
COUNT(DISTINCT a.ProjectID) AS NumProjectsAssigned
FROM Staff.Employees e
JOIN Staff.Assignments a 
ON e.EmployeeID = a.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(DISTINCT a.ProjectID) > 1;


-- the project names in each department along with the count of projects in each department

SELECT 
d.DepartmentName,
COUNT(DISTINCT p.ProjectID) AS NumProjects
FROM Staff.Projects p
JOIN Staff.Assignments a 
ON p.ProjectID = a.ProjectID
JOIN Staff.Employees e 
ON a.EmployeeID = e.EmployeeID
JOIN Staff.Departments d 
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

END;
go

--EXEC PerformQueryTasks
-- Retrieve Employees and Their Current Projects

--go

 drop PROCEDURE Staff.PerformQueryTasks