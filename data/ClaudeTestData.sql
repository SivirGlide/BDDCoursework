-- Insert initial employees (without department assignment)
-- We need to insert at least one employee first to establish managers
SET IDENTITY_INSERT EMPLOYEE ON;
INSERT INTO EMPLOYEE (EmployeeID, ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, NULL, 120000.00, NULL, '2021-01-15', NULL); -- CEO (no manager)
SET IDENTITY_INSERT EMPLOYEE OFF;

-- Now we can insert departments with the CEO as the manager
INSERT INTO DEPARTMENT (DepartmentName, ManagerID) VALUES
('Engineering', 1),
('Production', 1),
('Quality Control', 1),
('Maintenance', 1),
('Assembly', 1),
('Research', 1),
('Administration', 1),
('Human Resources', 1);

-- Now insert more employees with department assignments and managers
-- Engineering Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 110000.00, 'Engineering', '2021-03-01', NULL), -- Engineering Manager (ID: 2)
(2, 95000.00, 'Engineering', '2022-01-10', NULL),  -- Senior Engineer
(2, 85000.00, 'Engineering', '2022-02-15', NULL),  -- Engineer
(2, 82000.00, 'Engineering', '2022-06-20', NULL),  -- Engineer
(2, 82000.00, 'Engineering', '2022-07-11', NULL),  -- Engineer
(2, 78000.00, 'Engineering', '2023-01-05', NULL);  -- Junior Engineer

-- Production Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 105000.00, 'Production', '2021-02-15', NULL),  -- Production Manager (ID: 8)
(8, 82000.00, 'Production', '2022-02-01', NULL),   -- Production Lead
(8, 72000.00, 'Production', '2022-03-10', NULL),   -- Production Specialist
(8, 71000.00, 'Production', '2022-05-05', NULL),   -- Production Specialist
(8, 70000.00, 'Production', '2022-09-10', NULL),   -- Production Specialist
(8, 68000.00, 'Production', '2023-01-20', NULL);   -- Production Associate

-- Quality Control Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 100000.00, 'Quality Control', '2021-04-10', NULL),  -- QC Manager (ID: 14)
(14, 85000.00, 'Quality Control', '2021-11-15', NULL),  -- QC Lead
(14, 75000.00, 'Quality Control', '2022-01-25', NULL),  -- QC Specialist
(14, 72000.00, 'Quality Control', '2022-03-01', NULL),  -- QC Technician
(14, 71000.00, 'Quality Control', '2022-08-15', NULL),  -- QC Technician
(14, 70000.00, 'Quality Control', '2023-02-10', NULL);  -- QC Associate

-- Maintenance Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 102000.00, 'Maintenance', '2021-03-20', NULL),  -- Maintenance Manager (ID: 20)
(20, 88000.00, 'Maintenance', '2021-09-05', NULL),  -- Maintenance Lead
(20, 78000.00, 'Maintenance', '2022-01-15', NULL),  -- Maintenance Technician
(20, 76000.00, 'Maintenance', '2022-04-12', NULL),  -- Maintenance Technician
(20, 75000.00, 'Maintenance', '2022-06-01', NULL),  -- Maintenance Technician
(20, 72000.00, 'Maintenance', '2023-01-10', NULL);  -- Maintenance Associate

-- Assembly Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 98000.00, 'Assembly', '2021-05-01', NULL),    -- Assembly Manager (ID: 26)
(26, 82000.00, 'Assembly', '2021-10-15', NULL),   -- Assembly Lead
(26, 72000.00, 'Assembly', '2022-02-01', NULL),   -- Assembly Specialist
(26, 70000.00, 'Assembly', '2022-04-20', NULL),   -- Assembly Technician
(26, 68000.00, 'Assembly', '2022-07-10', NULL),   -- Assembly Technician
(26, 65000.00, 'Assembly', '2023-01-15', NULL);   -- Assembly Associate

-- Research Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 108000.00, 'Research', '2021-04-01', NULL),   -- Research Manager (ID: 32)
(32, 92000.00, 'Research', '2021-11-01', NULL),   -- Research Lead
(32, 88000.00, 'Research', '2022-01-05', NULL),   -- Senior Researcher
(32, 82000.00, 'Research', '2022-03-15', NULL),   -- Researcher
(32, 78000.00, 'Research', '2022-06-15', NULL),   -- Junior Researcher
(32, 75000.00, 'Research', '2022-09-20', NULL);   -- Research Assistant

-- Administration Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 95000.00, 'Administration', '2021-02-01', NULL), -- Admin Manager (ID: 38)
(38, 80000.00, 'Administration', '2021-08-10', NULL), -- Admin Lead
(38, 70000.00, 'Administration', '2022-01-15', NULL), -- Admin Specialist
(38, 65000.00, 'Administration', '2022-04-10', NULL), -- Admin Assistant
(38, 62000.00, 'Administration', '2022-07-01', NULL), -- Admin Assistant
(38, 60000.00, 'Administration', '2022-10-15', NULL); -- Admin Clerk

-- Human Resources Department (Manager + minimum 3 employees = 4 total)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate) VALUES
(1, 100000.00, 'Human Resources', '2021-02-05', NULL), -- HR Manager (ID: 44)
(44, 85000.00, 'Human Resources', '2021-09-01', NULL), -- HR Lead
(44, 75000.00, 'Human Resources', '2022-01-10', NULL), -- HR Specialist
(44, 68000.00, 'Human Resources', '2022-03-01', NULL), -- HR Assistant
(44, 65000.00, 'Human Resources', '2022-06-15', NULL), -- HR Coordinator
(44, 62000.00, 'Human Resources', '2022-09-05', NULL); -- HR Clerk

-- Union table
INSERT INTO UNIONTABLE (Name) VALUES
('Manufacturing Workers Union'),
('Maintenance Workers Union'),
('Technical Workers Union'),
('Administrative Workers Union');

-- Operator (assign union membership to production employees)
INSERT INTO OPERATOR (EmployeeID, UnionID) VALUES
(9, 1),  -- Production employees to Manufacturing Workers Union
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(21, 2), -- Maintenance employees to Maintenance Workers Union
(22, 2),
(23, 2),
(24, 2),
(25, 2),
(27, 1), -- Assembly employees to Manufacturing Workers Union
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(3, 3),  -- Engineers to Technical Workers Union
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(39, 4), -- Admin employees to Administrative Workers Union
(40, 4),
(41, 4),
(42, 4),
(43, 4);

-- Certification table
INSERT INTO CERTIFICATION (Name) VALUES
('Machine Operation Level 1'),
('Machine Operation Level 2'),
('Machine Operation Level 3'),
('Maintenance Level 1'),
('Maintenance Level 2'),
('Quality Control'),
('Safety Procedures'),
('Assembly Specialist'),
('Welding'),
('CNC Operation');

-- Operator Certification
INSERT INTO OPERATOR_CERTIFICATION (Employee_id, Certification_id, Date_awarded) VALUES
-- Production employees
(9, 1, '2022-03-15'),
(9, 2, '2022-06-20'),
(9, 7, '2022-04-10'),
(10, 1, '2022-04-05'),
(10, 7, '2022-04-10'),
(11, 1, '2022-05-20'),
(11, 7, '2022-05-25'),
(12, 1, '2022-10-15'),
(12, 7, '2022-10-20'),
(13, 1, '2023-02-10'),
(13, 7, '2023-02-15'),

-- Maintenance employees
(21, 4, '2021-10-15'),
(21, 5, '2022-01-20'),
(21, 7, '2021-10-20'),
(22, 4, '2022-02-25'),
(22, 7, '2022-03-05'),
(23, 4, '2022-05-10'),
(23, 7, '2022-05-15'),
(24, 4, '2022-07-01'),
(24, 7, '2022-07-10'),
(25, 4, '2023-02-05'),
(25, 7, '2023-02-10'),

-- Assembly employees
(27, 8, '2021-11-20'),
(27, 9, '2022-02-15'),
(27, 7, '2021-11-25'),
(28, 8, '2022-03-10'),
(28, 7, '2022-03-15'),
(29, 8, '2022-05-25'),
(29, 7, '2022-06-01'),
(30, 8, '2022-08-10'),
(30, 7, '2022-08-15'),
(31, 8, '2023-02-20'),
(31, 7, '2023-02-25');

-- Production Machines
INSERT INTO PRODUCTION_MACHINE (Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status, Last_Maintenance_Date, Is_New) VALUES
-- Engineering Department Machines
('Engineering', 'CNC Mill', '2021-06-10', 1, 'Operational', '2024-01-15', 0),
('Engineering', 'CNC Lathe', '2021-07-15', 1, 'Operational', '2024-02-10', 0),
('Engineering', '3D Printer', '2022-01-20', 1, 'Operational', '2024-01-25', 0),
('Engineering', 'Laser Cutter', '2022-03-05', 1, 'Operational', '2024-02-20', 0),

-- Production Department Machines
('Production', 'Assembly Line A', '2021-05-10', 1, 'Operational', '2024-01-05', 0),
('Production', 'Assembly Line B', '2021-08-20', 1, 'Operational', '2024-01-12', 0),
('Production', 'Injection Molder', '2022-02-15', 1, 'Operational', '2024-02-05', 0),
('Production', 'Extruder', '2022-04-10', 1, 'Operational', '2024-02-15', 0),

-- Quality Control Department Machines
('Quality Control', 'Material Tester', '2021-09-15', 1, 'Operational', '2024-01-18', 0),
('Quality Control', 'Optical Inspector', '2022-01-10', 1, 'Operational', '2024-01-28', 0),
('Quality Control', 'X-Ray Machine', '2022-03-25', 1, 'Operational', '2024-02-12', 0),
('Quality Control', 'CMM Machine', '2022-05-05', 1, 'Operational', '2024-02-25', 0),

-- Maintenance Department Machines
('Maintenance', 'Diagnostic System', '2021-10-10', 0, 'Operational', '2024-01-08', 0),
('Maintenance', 'Calibration Equipment', '2022-01-15', 0, 'Operational', '2024-01-20', 0),
('Maintenance', 'Parts Cleaner', '2022-04-05', 0, 'Operational', '2024-02-08', 0),
('Maintenance', 'Welder', '2022-06-20', 0, 'Operational', '2024-02-18', 0),

-- Assembly Department Machines
('Assembly', 'Robotic Arm A', '2021-11-05', 1, 'Operational', '2024-01-10', 0),
('Assembly', 'Robotic Arm B', '2022-01-25', 1, 'Operational', '2024-01-22', 0),
('Assembly', 'Conveyor System', '2022-03-15', 1, 'Operational', '2024-02-05', 0),
('Assembly', 'Packaging Machine', '2022-05-10', 1, 'Operational', '2024-02-22', 0),

-- Research Department Machines
('Research', 'Test Chamber', '2021-12-10', 1, 'Operational', '2024-01-12', 0),
('Research', 'Spectroscope', '2022-02-05', 0, 'Operational', '2024-01-28', 0),
('Research', 'Thermal Analyzer', '2022-04-15', 0, 'Operational', '2024-02-10', 0),
('Research', 'Centrifuge', '2022-06-05', 0, 'Operational', '2024-02-20', 0),

-- Administration Department Machines
('Administration', 'Document Scanner', '2021-08-15', 0, 'Operational', '2024-01-05', 0),
('Administration', 'Printer System', '2022-01-05', 0, 'Operational', '2024-01-15', 0),
('Administration', 'Binding Machine', '2022-03-10', 0, 'Operational', '2024-02-02', 0),
('Administration', 'Shredder', '2022-05-20', 0, 'Operational', '2024-02-15', 0);

-- Service History (30 entries spanning 2024-2025)
INSERT INTO SERVICE_HISTORY (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status) VALUES
(1, 21, '2024-01-15 09:30:00', 'Regular maintenance - replaced worn parts', 'Resolved'),
(2, 22, '2024-02-10 10:15:00', 'Oil change and calibration', 'Resolved'),
(3, 21, '2024-01-25 11:00:00', 'Firmware update and nozzle cleaning', 'Resolved'),
(4, 23, '2024-02-20 13:45:00', 'Lens cleaning and alignment', 'Resolved'),
(5, 21, '2024-01-05 08:30:00', 'Belt replacement and lubrication', 'Resolved'),
(6, 22, '2024-01-12 14:00:00', 'Sensor calibration and testing', 'Resolved'),
(7, 23, '2024-02-05 09:45:00', 'Nozzle replacement and cleaning', 'Resolved'),
(8, 24, '2024-02-15 10:30:00', 'Die cleaning and lubrication', 'Resolved'),
(9, 21, '2024-01-18 11:15:00', 'Calibration and software update', 'Resolved'),
(10, 22, '2024-01-28 13:00:00', 'Camera cleaning and alignment', 'Resolved'),
(11, 23, '2024-02-12 14:30:00', 'Tube replacement and calibration', 'Resolved'),
(12, 24, '2024-02-25 09:00:00', 'Probe calibration and software update', 'Resolved'),
(13, 21, '2024-01-08 10:45:00', 'Software update and testing', 'Resolved'),
(14, 22, '2024-01-20 11:30:00', 'Reference standard verification', 'Resolved'),
(15, 23, '2024-02-08 13:15:00', 'Filter replacement and cleaning', 'Resolved'),
(16, 24, '2024-02-18 14:45:00', 'Wire feed mechanism maintenance', 'Resolved'),
(17, 21, '2024-01-10 08:00:00', 'Joint lubrication and calibration', 'Resolved'),
(18, 22, '2024-01-22 09:15:00', 'Motor replacement and testing', 'Resolved'),
(19, 23, '2024-02-05 10:00:00', 'Belt tensioning and lubrication', 'Resolved'),
(20, 24, '2024-02-22 11:45:00', 'Sensor cleaning and calibration', 'Resolved'),
(21, 21, '2024-01-12 13:30:00', 'Seal replacement and pressure test', 'Resolved'),
(22, 22, '2024-01-28 14:15:00', 'Optics cleaning and alignment', 'Resolved'),
(23, 23, '2024-02-10 08:45:00', 'Temperature sensor calibration', 'Resolved'),
(24, 24, '2024-02-20 09:30:00', 'Rotor balancing and bearing inspection', 'Resolved'),
(25, 21, '2024-01-05 10:15:00', 'Glass cleaning and roller maintenance', 'Resolved'),
(26, 22, '2024-01-15 11:00:00', 'Cartridge replacement and alignment', 'Resolved'),
(27, 23, '2024-02-02 13:45:00', 'Drive replacement and testing', 'Resolved'),
(28, 24, '2024-02-15 14:30:00', 'Blade sharpening and lubrication', 'Resolved'),
(1, 21, '2024-03-15 09:00:00', 'Regular quarterly maintenance', 'Resolved'),
(2, 22, '2024-03-17 10:30:00', 'Quarterly oil change and calibration', 'Resolved');

-- Special Service History (fewer entries - for major repairs)
INSERT INTO SPECIAL_SERVICE_HISTORY (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status) VALUES
(3, 21, '2024-01-10', 'Major extruder assembly replacement', 'Resolved'),
(7, 22, '2024-01-20', 'Mold system overhaul', 'Resolved'),
(11, 23, '2024-01-30', 'X-ray tube replacement', 'Resolved'),
(15, 24, '2024-02-07', 'Complete system disassembly and cleaning', 'Resolved'),
(19, 21, '2024-02-14', 'Arm joint rebuild', 'Resolved'),
(23, 22, '2024-02-21', 'Heating element replacement', 'Resolved'),
(27, 23, '2024-02-28', 'Drive system replacement', 'Resolved'),
(2, 24, '2024-03-05', 'Spindle replacement and alignment', 'Resolved'),
(6, 21, '2024-03-12', 'Conveyor system rebuild', 'Resolved'),
(10, 22, '2024-03-19', 'Camera array replacement', 'Resolved');

-- Products
INSERT INTO PRODUCT (Description, Production_Cost) VALUES
('Aluminum Bracket', 12.50),
('Steel Bolt Pack (100)', 8.75),
('Bearing Assembly', 22.00),
('Circuit Board - Basic', 45.00),
('Circuit Board - Advanced', 85.00),
('Motor - Small', 35.00),
('Motor - Medium', 65.00),
('Motor - Large', 120.00),
('Sensor Package', 55.00),
('Control Panel', 95.00),
('Plastic Housing - Small', 15.00),
('Plastic Housing - Medium', 25.00),
('Plastic Housing - Large', 40.00),
('Metal Enclosure - Small', 30.00),
('Metal Enclosure - Medium', 50.00),
('Metal Enclosure - Large', 80.00),
('Wire Harness - Basic', 18.00),
('Wire Harness - Complex', 32.00),
('Power Supply - 12V', 42.00),
('Power Supply - 24V', 58.00),
('Fan Assembly', 28.00),
('Cooling System', 75.00),
('LED Display', 48.00),
('Touchscreen Panel', 110.00),
('Rubber Gasket Set', 9.50),
('Mounting Kit', 14.50),
('Control Unit - Basic', 120.00),
('Control Unit - Advanced', 210.00),
('Automated Assembly Robot', 3500.00),
('Conveyor System Section', 650.00);

-- Components in Product (Bill of Materials)
INSERT INTO COMPONENTS_IN_PRODUCT (Assembly_Product_Number, Component_Product_Number, Quantity) VALUES
-- Automated Assembly Robot components
(29, 8, 2),  -- Large Motors
(29, 5, 1),  -- Advanced Circuit Board
(29, 10, 1), -- Control Panel
(29, 16, 1), -- Large Metal Enclosure
(29, 18, 1), -- Complex Wire Harness
(29, 20, 1), -- 24V Power Supply
(29, 22, 1), -- Cooling System
(29, 24, 1), -- Touchscreen Panel
(29, 28, 1), -- Advanced Control Unit

-- Conveyor System Section components
(30, 7, 2),  -- Medium Motors
(30, 4, 1),  -- Basic Circuit Board
(30, 15, 1), -- Medium Metal Enclosure
(30, 17, 1), -- Basic Wire Harness
(30, 19, 1), -- 12V Power Supply
(30, 27, 1), -- Basic Control Unit

-- Control Unit - Advanced components
(28, 5, 1),  -- Advanced Circuit Board
(28, 15, 1), -- Medium Metal Enclosure
(28, 9, 3),  -- Sensor Packages
(28, 18, 1), -- Complex Wire Harness
(28, 20, 1), -- 24V Power Supply

-- Control Unit - Basic components
(27, 4, 1),  -- Basic Circuit Board
(27, 14, 1), -- Small Metal Enclosure
(27, 9, 1),  -- Sensor Package
(27, 17, 1), -- Basic Wire Harness
(27, 19, 1), -- 12V Power Supply

-- Cooling System components
(22, 6, 1),  -- Small Motor
(22, 21, 2), -- Fan Assemblies
(22, 12, 1), -- Medium Plastic Housing
(22, 25, 1), -- Rubber Gasket Set

-- Touchscreen Panel components
(24, 23, 1), -- LED Display
(24, 4, 1),  -- Basic Circuit Board
(24, 11, 1), -- Small Plastic Housing
(24, 17, 1); -- Basic Wire Harness

-- Production Machine Product (which machines can make which products)
INSERT INTO PRODUCTION_MACHINE_PRODUCT (Machine_id, Product_Number) VALUES
-- Engineering Machines
(1, 1), -- CNC Mill can make Aluminum Bracket
(1, 14), -- CNC Mill can make Small Metal Enclosure
(1, 15), -- CNC Mill can make Medium Metal Enclosure
(1, 16), -- CNC Mill can make Large Metal Enclosure
(2, 2), -- CNC Lathe can make Steel Bolt Pack
(2, 3), -- CNC Lathe can make Bearing Assembly
(3, 11), -- 3D Printer can make Small Plastic Housing
(3, 12), -- 3D Printer can make Medium Plastic Housing
(3, 13), -- 3D Printer can make Large Plastic Housing
(4, 1), -- Laser Cutter can also make Aluminum Bracket
(4, 4), -- Laser Cutter can make Basic Circuit Board
(4, 5), -- Laser Cutter can make Advanced Circuit Board

-- Production Machines
(5, 17), -- Assembly Line A can make Basic Wire Harness
(5, 18), -- Assembly Line A can make Complex Wire Harness
(5, 19), -- Assembly Line A can make 12V Power Supply
(5, 20), -- Assembly Line A can make 24V Power Supply
(6, 21), -- Assembly Line B can make Fan Assembly
(6, 22), -- Assembly Line B can make Cooling System
(6, 23), -- Assembly Line B can make LED Display
(6, 24), -- Assembly Line B can make Touchscreen Panel
(7, 11), -- Injection Molder can make Small Plastic Housing
(7, 12), -- Injection Molder can make Medium Plastic Housing
(7, 13), -- Injection Molder can make Large Plastic Housing
(7, 25), -- Injection Molder can make Rubber Gasket Set
(8, 1), -- Extruder can make Aluminum Bracket
(8, 2), -- Extruder can make Steel Bolt Pack
(8, 26), -- Extruder can make Mounting Kit

-- Assembly Machines
(17, 6), -- Robotic Arm A can make Small Motor
(17, 7), -- Robotic Arm A can make Medium Motor
(17, 8), -- Robotic Arm A can make Large Motor
(17, 9), -- Robotic Arm A can make Sensor Package
(17, 10), -- Robotic Arm A can make Control Panel
(18, 27), -- Robotic Arm B can make Basic Control Unit
(18, 28), -- Robotic Arm B can make Advanced Control Unit
(19, 29), -- Conveyor System can make Automated Assembly Robot
(20, 30); -- Packaging Machine can make Conveyor System Section

-- Production Process
INSERT INTO PRODUCTION_PROCESS (Product_Number, Machine_id, Sequence_Number, Process_Type, Build_Time_In_Seconds) VALUES
-- Aluminum Bracket Production Process
(1, 1, 1, 'Milling', 120),
(1, 4, 2, 'Cutting', 60),
(1, 8, 3, 'Finishing', 90),

-- Steel Bolt Pack Production Process
(2, 2, 1, 'Turning', 180),
(2, 8, 2, 'Threading', 120),

-- Circuit Board Production Processes
(4, 4, 1, 'Cutting', 90),
(4, 5, 2, 'Assembly', 150),
(5, 4, 1, 'Precision Cutting', 150),
(5, 5, 2, 'Complex Assembly', 300),

-- Motor Production Processes
(6, 17, 1, 'Assembly', 240),
(7, 17, 1, 'Assembly', 360),
(8, 17, 1, 'Assembly', 480),

-- Plastic Housing Production Process
(11, 3, 1, 'Printing', 300),
(11, 7, 2, 'Molding', 180),
(12, 3, 1, 'Printing', 420),
(12, 7, 2, 'Molding', 240),
(13, 3, 1, 'Printing', 600),
(13, 7, 2, 'Molding', 360),

-- Control Unit Production Process
(27, 18, 1, 'Assembly', 420),
(28, 18, 1, 'Assembly', 600),

-- Advanced Products
(29, 19, 1, 'Assembly', 1800),
(30, 20, 1, 'Assembly', 1200);

-- Product Instance (30 manufactured products with dates spanning 2024-2025)
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time) VALUES
(1, 1, '2024-01-05 08:30:00'),
(2, 2, '2024-01-07 09:45:00'),
(3, 2, '2024-01-10 11:15:00'),
(4, 4, '2024-01-12 13:30:00'),
(5, 4, '2024-01-15 15:00:00'),
(6, 17, '2024-01-18 10:30:00'),
(7, 17, '2024-01-20 14:00:00'),
(8, 17, '2024-01-23 11:45:00'),
(9, 17, '2024-01-25 09:15:00'),
(10, 17, '2024-01-28 13:30:00'),
(11, 3, '2024-02-01 10:00:00'),
(12, 3, '2024-02-03 11:30:00'),
(13, 3, '2024-02-05 14:45:00'),
(14, 1, '2024-02-08 09:30:00'),
(15, 1, '2024-02-10 13:15:00'),
(16, 1, '2024-02-12 15:45:00'),
(17, 5, '2024-02-15 10:30:00'),
(18, 5, '2024-02-18 12:00:00'),
(19, 5, '2024-02-20 14:30:00'),
(20, 5, '2024-02-22 16:00:00'),
(21, 6, '2024-02-25 09:45:00'),
(22, 6, '2024-02-28 11:15:00'),
(23, 6, '2024-03-02 13:30:00'),
(24, 6, '2024-03-05 15:00:00'),
(25, 7, '2024-03-08 10:45:00'),
(26, 8, '2024-03-10 12:15:00'),
(27, 18, '2024-03-13 09:30:00'),
(28, 18, '2024-03-16 11:45:00'),
(29, 19, '2024-03-19 14:00:00'),
(30, 20, '2024-03-22 16:30:00');

-- Production Machine Operator (shifts for machine operators spanning 2024-2025)
INSERT INTO PRODUCTION_MACHINE_OPERATOR (Shift_Date, Machine_id, Employee_id, Shift_End, Operator_Task) VALUES
-- January 2024 Shifts
('2024-01-05 08:00:00', 1, 9, '2024-01-05 16:00:00', 'CNC Mill Operation - Aluminum Brackets'),
('2024-01-05 08:00:00', 5, 10, '2024-01-05 16:00:00', 'Assembly Line Operation - Wire Harnesses'),
('2024-01-05 08:00:00', 17, 27, '2024-01-05 16:00:00', 'Robotic Arm Operation - Motor Assembly'),
('2024-01-07 08:00:00', 2, 9, '2024-01-07 16:00:00', 'CNC Lathe Operation - Bolt Production'),
('2024-01-07 08:00:00', 6, 10, '2024-01-07 16:00:00', 'Assembly Line Operation - Fan Assembly'),
('2024-01-07 08:00:00', 18, 27, '2024-01-07 16:00:00', 'Robotic Arm Operation - Control Unit Assembly'),

('2024-01-10 08:00:00', 3, 11, '2024-01-10 16:00:00', '3D Printer Operation - Plastic Housing'),
('2024-01-10 08:00:00', 7, 12, '2024-01-10 16:00:00', 'Injection Molder Operation - Gasket Production'),
('2024-01-10 08:00:00', 19, 28, '2024-01-10 16:00:00', 'Conveyor System Operation - Robot Assembly'),
('2024-01-15 08:00:00', 4, 11, '2024-01-15 16:00:00', 'Laser Cutter Operation - Circuit Board Cutting'),
('2024-01-15 08:00:00', 8, 12, '2024-01-15 16:00:00', 'Extruder Operation - Mounting Kit Production'),
('2024-01-15 08:00:00', 20, 28, '2024-01-15 16:00:00', 'Packaging Machine Operation - Conveyor Assembly'),

-- February 2024 Shifts
('2024-02-05 08:00:00', 1, 9, '2024-02-05 16:00:00', 'CNC Mill Operation - Metal Enclosures'),
('2024-02-05 08:00:00', 5, 10, '2024-02-05 16:00:00', 'Assembly Line Operation - Power Supplies'),
('2024-02-05 08:00:00', 17, 27, '2024-02-05 16:00:00', 'Robotic Arm Operation - Sensor Package Assembly'),
('2024-02-10 08:00:00', 2, 9, '2024-02-10 16:00:00', 'CNC Lathe Operation - Bearing Assembly'),
('2024-02-10 08:00:00', 6, 10, '2024-02-10 16:00:00', 'Assembly Line Operation - Cooling System Assembly'),
('2024-02-10 08:00:00', 18, 27, '2024-02-10 16:00:00', 'Robotic Arm Operation - Advanced Control Unit Assembly'),

('2024-02-15 08:00:00', 3, 11, '2024-02-15 16:00:00', '3D Printer Operation - Large Plastic Housing'),
('2024-02-15 08:00:00', 7, 12, '2024-02-15 16:00:00', 'Injection Molder Operation - Custom Parts'),
('2024-02-15 08:00:00', 19, 28, '2024-02-15 16:00:00', 'Conveyor System Operation - Assembly Robot Testing'),
('2024-02-20 08:00:00', 4, 11, '2024-02-20 16:00:00', 'Laser Cutter Operation - Advanced Circuit Board'),
('2024-02-20 08:00:00', 8, 12, '2024-02-20 16:00:00', 'Extruder Operation - Custom Aluminum Parts'),
('2024-02-20 08:00:00', 20, 28, '2024-02-20 16:00:00', 'Packaging Machine Operation - System Packaging'),

-- March 2024 Shifts
('2024-03-05 08:00:00', 1, 9, '2024-03-05 16:00:00', 'CNC Mill Operation - Custom Metal Parts'),
('2024-03-05 08:00:00', 5, 10, '2024-03-05 16:00:00', 'Assembly Line Operation - Complex Wire Harnesses'),
('2024-03-05 08:00:00', 17, 27, '2024-03-05 16:00:00', 'Robotic Arm Operation - Large Motor Assembly'),
('2024-03-10 08:00:00', 2, 9, '2024-03-10 16:00:00', 'CNC Lathe Operation - Precision Parts'),
('2024-03-10 08:00:00', 6, 10, '2024-03-10 16:00:00', 'Assembly Line Operation - LED Display Assembly'),
('2024-03-10 08:00:00', 18, 27, '2024-03-10 16:00:00', 'Robotic Arm Operation - Control Panel Assembly'),

('2024-03-15 08:00:00', 3, 11, '2024-03-15 16:00:00', '3D Printer Operation - Custom Housing'),
('2024-03-15 08:00:00', 7, 12, '2024-03-15 16:00:00', 'Injection Molder Operation - Specialized Parts'),
('2024-03-15 08:00:00', 19, 28, '2024-03-15 16:00:00', 'Conveyor System Operation - Final Assembly'),
('2024-03-20 08:00:00', 4, 11, '2024-03-20 16:00:00', 'Laser Cutter Operation - Specialty Components'),
('2024-03-20 08:00:00', 8, 12, '2024-03-20 16:00:00', 'Extruder Operation - Custom Bracket Production'),
('2024-03-20 08:00:00', 20, 28, '2024-03-20 16:00:00', 'Packaging Machine Operation - Premium Packaging');