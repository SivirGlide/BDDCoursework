-- First, we need to create a manager and department simultaneously
-- This requires a temporary disabling of constraints
ALTER TABLE DEPARTMENT NOCHECK CONSTRAINT ManagerFKEmployee;

-- Insert the first employee (who will be the CEO/top manager)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES (NULL, 150000, NULL);

-- Create the first department with this employee as manager
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES ('Engineering', 1);

-- Re-enable constraints
ALTER TABLE DEPARTMENT CHECK CONSTRAINT ManagerFKEmployee;

-- Now add at least 3 employees to Engineering department
-- (to satisfy the minimum 3 employees per department rule)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES
(1, 120000, 'Engineering'),  -- Employee 2
(1, 110000, 'Engineering'),  -- Employee 3
(1, 100000, 'Engineering');  -- Employee 4

-- Create Operations department (with required 3 employees)
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES ('Operations', 2);

INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES
(2, 95000, 'Operations'),  -- Employee 5
(2, 90000, 'Operations'),  -- Employee 6
(2, 85000, 'Operations');  -- Employee 7

-- Create HR department (with required 3 employees)
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES ('HR', 3);

INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES
(3, 80000, 'HR'),  -- Employee 8
(3, 75000, 'HR'),  -- Employee 9
(3, 72000, 'HR');  -- Employee 10

-- Create union for operators
INSERT INTO UNIONTABLE (Name)
VALUES ('Manufacturing Workers Union');

-- Make some employees operators
INSERT INTO OPERATOR (EmployeeID, UnionID)
VALUES
(4, 1),  -- Engineering employee
(5, 1),  -- Operations employee
(6, 1),  -- Operations employee
(7, 1);  -- Operations employee

-- Create certifications
INSERT INTO CERTIFICATION (Name)
VALUES
('Machine Safety Level 1'),
('CNC Operation'),
('Hydraulic Systems'),
('Quality Control');

-- Assign certifications to operators
INSERT INTO OPERATOR_CERTIFICATION (Employee_id, Certification_id, Date_awarded)
VALUES
(4, 1, '2024-01-10'),  -- Safety cert for employee 4
(4, 2, '2024-02-15'),  -- CNC cert for employee 4
(5, 1, '2024-01-15'),  -- Safety cert for employee 5
(5, 3, '2024-02-20'),  -- Hydraulic cert for employee 5
(6, 1, '2024-01-20'),  -- Safety cert for employee 6
(6, 4, '2024-02-25'),  -- Quality cert for employee 6
(7, 1, '2024-01-25'),  -- Safety cert for employee 7
(7, 3, '2024-03-01');  -- Hydraulic cert for employee 7

-- Create production machines
INSERT INTO PRODUCTION_MACHINE
(Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status, Is_New)
VALUES
('Engineering', 'CNC Milling Machine', '2024-01-15', 1, 'Operational', 0),
('Engineering', 'Laser Cutter', '2024-02-10', 1, 'Operational', 0),
('Operations', 'Assembly Line', '2024-01-20', 1, 'Operational', 0),
('Operations', 'Packaging System', '2024-02-15', 1, 'Operational', 0),
('Operations', 'Testing Apparatus', '2024-03-10', 0, 'Operational', 1);

-- Add maintenance history (only for non-new machines)
-- This will trigger the maintenance scheduling
UPDATE PRODUCTION_MACHINE
SET Last_Maintenance_Date = '2025-03-15 09:00:00'
WHERE Machine_id IN (1, 2, 3, 4);

-- Create service history records
INSERT INTO SERVICE_HISTORY
(Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
(1, 4, '2025-02-10 10:00:00', 'Regular calibration', 'Resolved'),
(1, 4, '2025-03-01 11:00:00', 'Tool replacement', 'Resolved'),
(2, 4, '2025-02-15 09:30:00', 'Lens cleaning', 'Resolved'),
(2, 4, '2025-03-05 14:00:00', 'Alignment check', 'Resolved'),
(3, 5, '2025-02-20 08:45:00', 'Belt replacement', 'Resolved'),
(3, 5, '2025-03-10 13:30:00', 'Motor inspection', 'Resolved'),
(4, 6, '2025-02-25 10:15:00', 'Sensor calibration', 'Resolved'),
(4, 6, '2025-03-15 15:45:00', 'Software update', 'Resolved');

-- Create special service history records
INSERT INTO SPECIAL_SERVICE_HISTORY
(Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
(1, 4, '2025-02-05', 'Control system upgrade', 'Resolved'),
(2, 4, '2025-02-07', 'Power supply replacement', 'Resolved'),
(3, 5, '2025-02-09', 'Conveyor system overhaul', 'Resolved'),
(4, 6, '2025-02-12', 'Full system diagnostic', 'Resolved');

INSERT INTO SPECIAL_SERVICE_HISTORY
(Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES (4, 6, '2025-02-13', 'Full system diagnostic', 'Resolved');

-- Create operator shifts data
INSERT INTO PRODUCTION_MACHINE_OPERATOR
(Shift_Date, Machine_id, Employee_id, Shift_End, Operator_Task)
VALUES
-- Previous month shifts
('2025-02-15 08:00:00', 1, 4, '2025-02-15 16:00:00', 'CNC operation and maintenance'),
('2025-02-16 08:00:00', 1, 4, '2025-02-16 16:00:00', 'CNC operation and maintenance'),
('2025-02-17 08:00:00', 2, 4, '2025-02-17 16:00:00', 'Laser cutting operations'),
('2025-02-18 08:00:00', 2, 4, '2025-02-18 16:00:00', 'Laser cutting operations'),
('2025-02-15 08:00:00', 3, 5, '2025-02-15 16:00:00', 'Assembly line oversight'),
('2025-02-16 08:00:00', 3, 6, '2025-02-16 16:00:00', 'Assembly line operation'),
('2025-02-17 08:00:00', 3, 7, '2025-02-17 16:00:00', 'Assembly line operation'),
('2025-02-18 08:00:00', 4, 5, '2025-02-18 16:00:00', 'Packaging system operation'),
('2025-02-19 08:00:00', 4, 6, '2025-02-19 16:00:00', 'Packaging system operation'),
('2025-02-20 08:00:00', 4, 7, '2025-02-20 16:00:00', 'Packaging system operation'),

-- Current month shifts
('2025-03-01 08:00:00', 1, 4, '2025-03-01 16:00:00', 'CNC operation and maintenance'),
('2025-03-02 08:00:00', 1, 4, '2025-03-02 16:00:00', 'CNC operation and maintenance'),
('2025-03-03 08:00:00', 2, 4, '2025-03-03 16:00:00', 'Laser cutting operations'),
('2025-03-04 08:00:00', 2, 4, '2025-03-04 16:00:00', 'Laser cutting operations'),
('2025-03-05 08:00:00', 2, 4, '2025-03-05 16:00:00', 'Laser cutting operations'),
('2025-03-01 08:00:00', 3, 5, '2025-03-01 16:00:00', 'Assembly line oversight'),
('2025-03-02 08:00:00', 3, 6, '2025-03-02 16:00:00', 'Assembly line operation'),
('2025-03-03 08:00:00', 3, 7, '2025-03-03 16:00:00', 'Assembly line operation'),
('2025-03-04 08:00:00', 4, 5, '2025-03-04 16:00:00', 'Packaging system operation'),
('2025-03-05 08:00:00', 4, 6, '2025-03-05 16:00:00', 'Packaging system operation'),
('2025-03-06 08:00:00', 4, 7, '2025-03-06 16:00:00', 'Packaging system operation'),
('2025-03-07 08:00:00', 5, 5, '2025-03-07 16:00:00', 'Testing apparatus setup'),
('2025-03-08 08:00:00', 5, 6, '2025-03-08 16:00:00', 'Testing apparatus operation'),
('2025-03-10 08:00:00', 5, 6, '2025-03-10 16:00:00', 'Testing apparatus operation'),
('2025-03-09 08:00:00', 5, 7, '2025-03-09 16:00:00', 'Testing apparatus operation');



-- Create products
INSERT INTO PRODUCT (Description, Production_Cost)
VALUES
('Precision Bearing', 25.50),
('Hydraulic Valve', 45.75),
('Control Circuit Board', 120.00),
('Machine Housing', 85.25),
('Complete Pump Assembly', 350.00);

-- Set up product components relationships
INSERT INTO COMPONENTS_IN_PRODUCT
(Assembly_Product_Number, Component_Product_Number, Quantity)
VALUES
(5, 1, 4),  -- Pump uses 4 bearings
(5, 2, 2),  -- Pump uses 2 valves
(5, 3, 1),  -- Pump uses 1 circuit board
(5, 4, 1);  -- Pump uses 1 housing

-- Set up machine-product relationships
INSERT INTO PRODUCTION_MACHINE_PRODUCT
(Machine_id, Product_Number)
VALUES
(1, 1),  -- CNC machine makes bearings
(1, 4),  -- CNC machine makes housings
(2, 4),  -- Laser cutter also works on housings
(3, 5),  -- Assembly line assembles pumps
(4, 5);  -- Packaging system packages pumps

-- Create production processes
INSERT INTO PRODUCTION_PROCESS
(Product_Number, Machine_id, Sequence_Number, Process_Type, Build_Time_In_Seconds)
VALUES
(1, 1, 1, 'Milling', 300),
(1, 1, 2, 'Polishing', 120),
(4, 1, 1, 'Rough Cut', 450),
(4, 1, 2, 'Precision Milling', 600),
(4, 2, 3, 'Edge Finishing', 300),
(5, 3, 1, 'Component Assembly', 1200),
(5, 3, 2, 'Testing', 600),
(5, 4, 3, 'Packaging', 300);

-- Create some product instances
INSERT INTO PRODUCT_INSTANCE
(Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(1, 1, '2025-03-01 10:30:00'),
(1, 1, '2025-03-01 10:40:00'),
(1, 1, '2025-03-01 10:50:00'),
(1, 1, '2025-03-01 11:00:00'),
(4, 1, '2025-03-02 09:15:00'),
(4, 2, '2025-03-02 14:30:00'),
(5, 3, '2025-03-03 13:45:00'),
(5, 4, '2025-03-03 16:30:00');

------------------------------

-- Updated test data script compatible with database triggers

-- Step 1: Create 4 employees with different salary levels
-- Note: We need at least 3 employees per department to satisfy the MinimumEmployeesPerDepartment trigger
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName)
VALUES
(NULL, 100000.00, NULL), -- Employee 1: Top manager
(NULL, 80000.00, NULL),  -- Employee 2
(NULL, 65000.00, NULL),  -- Employee 3
(NULL, 55000.00, NULL);  -- Employee 4

-- Step 2: Set up the management hierarchy (ensuring managers earn more than employees)
UPDATE EMPLOYEE
SET ManagerID = 1
WHERE EmployeeID IN (2, 3);

UPDATE EMPLOYEE
SET ManagerID = 2
WHERE EmployeeID = 4;

-- Step 3: Create a department with the manager
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES ('Manufacturing', 1);

-- Step 4: Assign employees to the department (ensuring at least 3 employees)
UPDATE EMPLOYEE
SET DepartmentName = 'Manufacturing'
WHERE EmployeeID IN (1, 2, 3, 4);

-- Step 5: Create machines (note: we'll handle Last_Maintenance_Date carefully due to the trigger)
INSERT INTO PRODUCTION_MACHINE (Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status, Is_New)
VALUES
('Manufacturing', 'Milling Machine', '2023-01-15', 1, 'Operational', 0),
('Manufacturing', 'CNC Lathe', '2022-06-20', 1, 'Operational', 0),
('Manufacturing', 'Press', '2021-09-10', 0, 'Operational', 0);

-- Step 6: Set Last_Maintenance_Date for each machine (trigger will auto-set Next_Scheduled_Maintenance)
UPDATE PRODUCTION_MACHINE
SET Last_Maintenance_Date = DATEADD(day, -10, GETDATE())
WHERE Machine_id = 1;

UPDATE PRODUCTION_MACHINE
SET Last_Maintenance_Date = DATEADD(day, -15, GETDATE())
WHERE Machine_id = 2;

UPDATE PRODUCTION_MACHINE
SET Last_Maintenance_Date = DATEADD(day, -5, GETDATE())
WHERE Machine_id = 3;

-- Step 7: Create products
INSERT INTO PRODUCT (Description, Production_Cost)
VALUES
('Flywheel', 120.50),
('Clutch plate', 85.75),
('Pressure plate', 95.25),
('Bearing', 45.00),
('Gear shaft', 65.30);

-- Step 8: Link products to machines that can produce them
INSERT INTO PRODUCTION_MACHINE_PRODUCT (Machine_id, Product_Number)
VALUES
(1, 1), -- Machine 1 can produce Flywheel
(1, 3), -- Machine 1 can produce Pressure plate
(2, 1), -- Machine 2 can produce Flywheel
(2, 2), -- Machine 2 can produce Clutch plate
(2, 4), -- Machine 2 can produce Bearing
(3, 2), -- Machine 3 can produce Clutch plate
(3, 3), -- Machine 3 can produce Pressure plate
(3, 1), -- Machine 3 can produce Flywheel
(1, 5); -- Machine 1 can produce Gear shaft

-- Step 9: Create product instances (production records)
-- Current date for reference in the script
DECLARE @CurrentDate DATETIME2 = GETDATE();

-- Today
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(1, 1, @CurrentDate),  -- Flywheel on Machine 1 today
(2, 2, @CurrentDate);  -- Clutch plate on Machine 2 today

-- Yesterday
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(3, 1, DATEADD(day, -1, @CurrentDate)),  -- Pressure plate on Machine 1 yesterday
(2, 3, DATEADD(day, -1, @CurrentDate)),  -- Clutch plate on Machine 3 yesterday
(4, 2, DATEADD(day, -1, @CurrentDate));  -- Bearing (not in criteria) on Machine 2 yesterday

-- 2 days ago
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(1, 2, DATEADD(day, -2, @CurrentDate)),  -- Flywheel on Machine 2 two days ago
(3, 3, DATEADD(day, -2, @CurrentDate));  -- Pressure plate on Machine 3 two days ago

-- 4 days ago (outside our 3-day window)
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(1, 3, DATEADD(day, -4, @CurrentDate)),  -- Flywheel on Machine 3 four days ago (should NOT appear in results)
(5, 1, DATEADD(day, -4, @CurrentDate));  -- Gear shaft on Machine 1 four days ago (should NOT appear in results)

---------------

-- Additional test data with component relationships

-- Add some assembly products that use our components
INSERT INTO PRODUCT (Description, Production_Cost)
VALUES
('Clutch Assembly', 350.75),      -- Product 6: An assembly that uses multiple components
('Drivetrain Assembly', 850.25),  -- Product 7: A larger assembly
('Transmission Kit', 1250.50);    -- Product 8: A complete kit

-- Define the component relationships (which products are made up of which components)
-- Clutch Assembly components
INSERT INTO COMPONENTS_IN_PRODUCT (Assembly_Product_Number, Component_Product_Number, Quantity)
VALUES
(6, 2, 1),  -- 1 Clutch plate in a Clutch Assembly
(6, 3, 1);  -- 1 Pressure plate in a Clutch Assembly

-- Drivetrain Assembly components
INSERT INTO COMPONENTS_IN_PRODUCT (Assembly_Product_Number, Component_Product_Number, Quantity)
VALUES
(7, 1, 1),  -- 1 Flywheel in a Drivetrain Assembly
(7, 6, 1),  -- 1 Clutch Assembly in a Drivetrain Assembly
(7, 4, 2);  -- 2 Bearings in a Drivetrain Assembly

-- Transmission Kit components
INSERT INTO COMPONENTS_IN_PRODUCT (Assembly_Product_Number, Component_Product_Number, Quantity)
VALUES
(8, 7, 1),  -- 1 Drivetrain Assembly in a Transmission Kit
(8, 5, 3);  -- 3 Gear shafts in a Transmission Kit

-- Link the new assembly products to machines
INSERT INTO PRODUCTION_MACHINE_PRODUCT (Machine_id, Product_Number)
VALUES
(1, 6),  -- Machine 1 can produce Clutch Assembly
(2, 7),  -- Machine 2 can produce Drivetrain Assembly
(3, 8);  -- Machine 3 can produce Transmission Kit

-- Add production instances for these assemblies
DECLARE @CurrentDate DATETIME2 = GETDATE();

-- Today - Machine 1 produced a Clutch Assembly
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES (6, 1, @CurrentDate);

-- Yesterday - Machine 2 produced a Drivetrain Assembly
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES (7, 2, DATEADD(day, -1, @CurrentDate));

-- 2 days ago - Machine 3 produced a Transmission Kit
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES (8, 3, DATEADD(day, -2, @CurrentDate));

-- Add some more component production (focusing on our search criteria components)
-- Today
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(3, 3, @CurrentDate);  -- Pressure plate on Machine 3 today

-- Yesterday
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(1, 3, DATEADD(day, -1, @CurrentDate));  -- Flywheel on Machine 3 yesterday

-- 3 days ago (still within our search window)
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
(2, 1, DATEADD(day, -3, @CurrentDate)),  -- Clutch plate on Machine 1 three days ago
(3, 2, DATEADD(day, -3, @CurrentDate));  -- Pressure plate on Machine 2 three days ago
