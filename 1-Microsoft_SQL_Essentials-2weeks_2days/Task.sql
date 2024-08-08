 USE CompanyDB;
 
 -- 1
 SELECT UPPER(E.FirstName) AS UpperFirstName, 
 LOWER(E.LastName) AS LowerLastName, 
 LEN(E.Position) AS PositionLength, 
 D.DepartmentName 
FROM Employees E 
JOIN Departments D ON E.DepartmentID = D.DepartmentID; 

-- 2
SELECT D.DepartmentName, 
 ROUND(SUM(E.Salary), -3) AS TotalSalaryExpenditure, 
 COUNT(E.EmployeeID) AS NumberOfEmployees 
FROM Employees E 
JOIN Departments D ON E.DepartmentID = D.DepartmentID 
GROUP BY D.DepartmentName 
ORDER BY TotalSalaryExpenditure DESC; 

-- 3
SELECT UPPER(P.ProjectName) AS ProjectName, 
 CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName, 
 A.Role 
FROM Projects P 
JOIN Assignments A ON P.ProjectID = A.ProjectID 
JOIN Employees E ON A.EmployeeID = E.EmployeeID; 

-- 4
SELECT LOWER(C.CustomerName) AS CustomerName, 
 COUNT(O.OrderID) AS NumberOfOrders, 
 SUM(O.TotalAmount) AS TotalSpent 
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID 
GROUP BY C.CustomerName; 

-- 5
SELECT LEFT(P.ProductName, 10) AS ShortProductName, 
 LEFT(P.ProductName, 2) AS ProductCategory, 
 SUM(OD.Quantity) AS TotalQuantityOrdered 
FROM Products P 
JOIN OrderDetails OD ON P.ProductID = OD.ProductID 
GROUP BY P.ProductName; 

-- 6
SELECT E.FirstName, E.LastName, E.Salary, D.DepartmentName 
FROM Employees E 
JOIN Departments D ON E.DepartmentID = D.DepartmentID 
WHERE E.Salary > ( 
 SELECT AVG(E2.Salary) 
 FROM Employees E2 
 WHERE E2.DepartmentID = E.DepartmentID 
); 
