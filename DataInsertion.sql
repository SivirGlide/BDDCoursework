-- Testing Minimum employee Trigger

-- Create initial unassigned employees
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES
(NULL, 100000, NULL), -- Employee 1 (will be CEO/top manager)
(1, 85000, NULL),     -- Employee 2
(1, 82000, NULL),     -- Employee 3
(1, 81000, NULL),     -- Employee 4
(1, 80000, NULL),     -- Employee 5
(1, 79000, NULL),     -- Employee 6
(1, 78000, NULL),     -- Employee 7
(1, 77000, NULL),     -- Employee 8
(1, 76000, NULL),     -- Employee 9
(1, 75000, NULL);     -- Employee 10

-- Now create departments (using the first employee as the manager for all)
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES
('Engineering', 1),
('Marketing', 1),
('HR', 1);

UPDATE EMPLOYEE SET DepartmentName = 'Engineering' WHERE EmployeeID IN (2, 3, 4, 5);
UPDATE EMPLOYEE SET DepartmentName = 'Marketing' WHERE EmployeeID IN (6, 7, 8);
UPDATE EMPLOYEE SET DepartmentName = 'HR' WHERE EmployeeID IN (9, 10, 1);

SELECT * FROM EMPLOYEE

UPDATE EMPLOYEE
SET DepartmentName = 'Engineering'
WHERE EmployeeID IN (9, 10);

UPDATE EMPLOYEE SET Salary = 150000 WHERE EmployeeID = 1;