-- Create initial employees with unassigned departments

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

-- Creating Departments

INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES
('Engineering', 1),
('Marketing', 1),
('HR', 1);

-- Assigning Employees to Departments

UPDATE EMPLOYEE SET DepartmentName = 'Engineering' WHERE EmployeeID IN (2, 3, 4, 5);
UPDATE EMPLOYEE SET DepartmentName = 'Marketing' WHERE EmployeeID IN (6, 7, 8);
UPDATE EMPLOYEE SET DepartmentName = 'HR' WHERE EmployeeID IN (9, 10, 1);


--Machine Creation

-- Insert test machines
INSERT INTO PRODUCTION_MACHINE
    (Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status, Is_New)
VALUES
    ('Engineering', 'Lathe', '2022-01-15', 1, 'Operational', 0),
    ('Engineering', 'Drill Press', '2022-02-20', 1, 'Operational', 0),
    ('Engineering', 'CNC Machine', '2022-03-25', 1, 'Operational', 0),
    ('Marketing', 'Printer', '2022-04-10', 0, 'Operational', 0),
    ('HR', 'Scanner', '2022-05-05', 0, 'Operational', 0);

-- Insert service history for the machines
-- Machine 1: 3 regular services + 2 special services = 5 total
INSERT INTO SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (1, NULL, '2023-01-10', 'Regular maintenance', 'Resolved'),
    (1, NULL, '2023-02-10', 'Oil change', 'Resolved'),
    (1, NULL, '2023-03-10', 'Belt replacement', 'Resolved');

INSERT INTO SPECIAL_SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (1, NULL, '2023-01-20', 'Motor overhaul', 'Resolved'),
    (1, NULL, '2023-02-20', 'Control system upgrade', 'Resolved');

-- Machine 2: 4 regular services = 4 total
INSERT INTO SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (2, NULL, '2023-01-15', 'Regular maintenance', 'Resolved'),
    (2, NULL, '2023-02-15', 'Lubrication', 'Resolved'),
    (2, NULL, '2023-03-15', 'Calibration', 'Resolved'),
    (2, NULL, '2023-04-15', 'Chuck replacement', 'Resolved');

-- Machine 3: 2 regular services + 1 special service = 3 total (below threshold)
INSERT INTO SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (3, NULL, '2023-01-20', 'Regular maintenance', 'Resolved'),
    (3, NULL, '2023-03-20', 'Gear inspection', 'Resolved');

INSERT INTO SPECIAL_SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (3, NULL, '2023-02-05', 'Software update', 'Resolved');

-- Machine 4: 0 services (below threshold)
-- No services added

-- Machine 5: 1 regular service + 3 special services = 4 total
INSERT INTO SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (5, NULL, '2023-01-25', 'Regular maintenance', 'Resolved');

INSERT INTO SPECIAL_SERVICE_HISTORY
    (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (5, NULL, '2023-02-10', 'Hardware upgrade', 'Resolved'),
    (5, NULL, '2023-03-15', 'Sensor replacement', 'Resolved'),
    (5, NULL, '2023-04-20', 'Network connectivity issue', 'Resolved');
