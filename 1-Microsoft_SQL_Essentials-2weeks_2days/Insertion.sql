USE CompanyDB;

--Inserting into the database as two transactions 
--First, staff side
BEGIN TRANSACTION;

INSERT INTO staff.Departments (DepartmentID, DepartmentName, Location)
VALUES 
    (1, 'IT Department', 'Headquarters'),
    (2, 'Sales Department', 'Branch Office'),
    (3, 'Marketing Department', 'Headquarters');

INSERT INTO staff.Employees (EmployeeID, FirstName, LastName, DepartmentID, HireDate, Position, Salary)
VALUES
    (1, 'John', 'Doe', 1, '2020-01-15', 'Software Engineer', 75000.00),
    (2, 'Jane', 'Smith', 1, '2019-05-20', 'Database Administrator', 80000.00),
    (3, 'Michael', 'Johnson', 2, '2021-03-10', 'Sales Manager', 90000.00),
    (4, 'Emily', 'Williams', 2, '2022-02-28', 'Sales Representative', 60000.00),
    (5, 'David', 'Brown', 3, '2020-11-15', 'Marketing Specialist', 70000.00);

INSERT INTO staff.Projects (ProjectID, ProjectName, StartDate, EndDate, Budget)
VALUES
    (1, 'Database Migration', '2023-01-01', '2023-06-30', 100000.00),
    (2, 'Sales Campaign 2024', '2024-03-01', '2024-06-30', 80000.00),
    (3, 'Website Redesign', '2023-07-01', '2023-12-31', 120000.00);

INSERT INTO staff.Assignments (AssignmentID, EmployeeID, ProjectID, Role, AssignmentDate)
VALUES
    (1, 1, 1, 'Lead Developer', '2023-01-01'),
    (2, 2, 1, 'Database Administrator', '2023-01-01'),
    (3, 3, 2, 'Project Manager', '2024-03-01'),
    (4, 4, 2, 'Sales Representative', '2024-03-01'),
    (5, 5, 3, 'Marketing Coordinator', '2023-07-01');

--Commit transaction
COMMIT;


--Second, sales side
BEGIN TRANSACTION;

INSERT INTO sales.Customers (CustomerID, CustomerName, ContactNumber, Email, Address)
VALUES
    (1, 'Tech Solutions Inc.', '123-456-7890', 'info@techsolutions.com', '123 Main St, Anytown, USA'),
    (2, 'Global Marketing Group', '555-123-4567', 'contact@globalmarketing.com', '456 Market Ave, Big City, USA'),
    (3, 'Super Retail Corp.', '789-321-6540', 'support@superretail.com', '789 Oak Blvd, Smalltown, USA');

INSERT INTO sales.Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (1, 1, '2023-02-15', 25000.00),
    (2, 1, '2023-05-20', 35000.00),
    (3, 2, '2024-04-01', 18000.00),
    (4, 3, '2023-08-10', 50000.00),
    (5, 3, '2024-01-05', 42000.00);

INSERT INTO sales.Products (ProductID, ProductName, Category, Price, StockQuantity)
VALUES
    (1, 'Laptop Computer', 'Electronics', 1200.00, 50),
    (2, 'Office Desk', 'Furniture', 400.00, 20),
    (3, 'Printer', 'Office Supplies', 300.00, 30),
    (4, 'Smartphone', 'Electronics', 800.00, 100),
    (5, 'Office Chair', 'Furniture', 150.00, 25);

INSERT INTO Sales.OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 1, 3, 1200.00),
    (2, 1, 2, 2, 400.00),
    (3, 2, 4, 4, 800.00),
    (4, 3, 3, 1, 300.00),
    (5, 4, 5, 2, 150.00),
    (6, 5, 1, 2, 1200.00);

--Commit transaction
COMMIT;
