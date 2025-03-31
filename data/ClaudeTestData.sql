-- Manufacturing Database Insert Statements
-- Note: This script handles the circular dependency between DEPARTMENT and EMPLOYEE
-- and respects all triggers, especially for salary constraints and department employee counts

-- Step 1: Insert initial employees without departments or managers
-- These will become department managers
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (NULL, 120000.00, NULL, '2020-01-15', NULL), -- ID 1 (Will be Engineering manager)
    (NULL, 115000.00, NULL, '2019-06-20', NULL), -- ID 2 (Will be Production manager)
    (NULL, 125000.00, NULL, '2018-03-10', NULL), -- ID 3 (Will be Quality Control manager)
    (NULL, 130000.00, NULL, '2017-11-05', NULL), -- ID 4 (Will be Maintenance manager)
    (NULL, 118000.00, NULL, '2021-02-28', NULL); -- ID 5 (Will be Research & Development manager)

-- Step 2: Create departments with managers from the employees we just created
INSERT INTO DEPARTMENT (DepartmentName, ManagerID)
VALUES
    ('Engineering', 1),
    ('Production', 2),
    ('Quality Control', 3),
    ('Maintenance', 4),
    ('Research & Development', 5);


-- Step 4: Insert remaining employees with departments and managers
-- To satisfy the department employee count trigger (minimum 3 employees per department)
-- Engineering Department (at least 2 more for total of 3)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (1, 95000.00, 'Engineering', '2021-04-12', NULL),           -- ID 6
    (1, 92000.00, 'Engineering', '2021-07-20', NULL),           -- ID 7
    (1, 90000.00, 'Engineering', '2022-01-10', NULL),           -- ID 8
    (1, 87500.00, 'Engineering', '2022-05-15', NULL),           -- ID 9
    (1, 85000.00, 'Engineering', '2023-02-01', '2024-08-15');   -- ID 10

-- Production Department (at least 2 more for total of 3)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (2, 85000.00, 'Production', '2020-09-05', NULL),            -- ID 11
    (2, 82000.00, 'Production', '2021-03-15', NULL),            -- ID 12
    (2, 80000.00, 'Production', '2022-02-10', NULL),            -- ID 13
    (2, 78000.00, 'Production', '2022-11-10', '2024-06-30'),    -- ID 14
    (2, 77000.00, 'Production', '2023-04-01', NULL);            -- ID 15

-- Quality Control Department (at least 2 more for total of 3)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (3, 88000.00, 'Quality Control', '2019-10-10', NULL),          -- ID 16
    (3, 86000.00, 'Quality Control', '2020-05-12', NULL),          -- ID 17
    (3, 84000.00, 'Quality Control', '2021-08-01', NULL),          -- ID 18
    (3, 82000.00, 'Quality Control', '2022-03-15', '2024-04-28'),  -- ID 19
    (3, 80000.00, 'Quality Control', '2023-01-20', NULL);          -- ID 20

-- Maintenance Department (at least 2 more for total of 3)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (4, 90000.00, 'Maintenance', '2018-12-05', NULL),            -- ID 21
    (4, 87500.00, 'Maintenance', '2019-08-10', NULL),            -- ID 22
    (4, 85000.00, 'Maintenance', '2020-06-15', NULL),            -- ID 23
    (4, 82500.00, 'Maintenance', '2021-11-20', '2024-03-15'),    -- ID 24
    (4, 80000.00, 'Maintenance', '2022-09-01', NULL);            -- ID 25

-- Research & Development Department (at least 2 more for total of 3)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (5, 98000.00, 'Research & Development', '2021-05-10', NULL),           -- ID 26
    (5, 95000.00, 'Research & Development', '2022-01-15', NULL),           -- ID 27
    (5, 93000.00, 'Research & Development', '2022-07-01', NULL),           -- ID 28
    (5, 90000.00, 'Research & Development', '2023-03-15', '2024-09-30'),   -- ID 29
    (5, 88000.00, 'Research & Development', '2023-10-01', NULL);           -- ID 30


    -- Step 3: Update the managers with their department assignments
UPDATE EMPLOYEE
SET DepartmentName = 'Engineering'
WHERE EmployeeID = 1;

UPDATE EMPLOYEE
SET DepartmentName = 'Production'
WHERE EmployeeID = 2;

UPDATE EMPLOYEE
SET DepartmentName = 'Quality Control'
WHERE EmployeeID = 3;

UPDATE EMPLOYEE
SET DepartmentName = 'Maintenance'
WHERE EmployeeID = 4;

UPDATE EMPLOYEE
SET DepartmentName = 'Research & Development'
WHERE EmployeeID = 5;
-- Step 5: Insert unions
INSERT INTO UNIONTABLE (Name)
VALUES
    ('Manufacturing Workers Alliance'),
    ('Technical Professionals Guild'),
    ('Maintenance Workers Association'),
    ('Quality Assurance Union'),
    ('Engineering Collective');

-- Step 6: Insert operators (linking employees to unions)
-- Note: Typically operators would be production employees, but could be from other departments too
INSERT INTO OPERATOR (EmployeeID, UnionID)
VALUES
    (6, 5),   -- Engineering employee in Engineering Collective
    (7, 5),   -- Engineering employee in Engineering Collective
    (8, 5),   -- Engineering employee in Engineering Collective
    (11, 1),  -- Production employee in Manufacturing Workers Alliance
    (12, 1),  -- Production employee in Manufacturing Workers Alliance
    (13, 1),  -- Production employee in Manufacturing Workers Alliance
    (14, 1),  -- Production employee in Manufacturing Workers Alliance
    (15, 1),  -- Production employee in Manufacturing Workers Alliance
    (16, 4),  -- Quality Control employee in Quality Assurance Union
    (18, 4),  -- Quality Control employee in Quality Assurance Union
    (21, 3),  -- Maintenance employee in Maintenance Workers Association
    (22, 3),  -- Maintenance employee in Maintenance Workers Association
    (23, 3),  -- Maintenance employee in Maintenance Workers Association
    (26, 2),  -- R&D employee in Technical Professionals Guild
    (27, 2);  -- R&D employee in Technical Professionals Guild

-- Step 7: Insert certification dates
INSERT INTO CERTIFICATION_DATES (Date_awarded)
VALUES
    ('2023-01-15'),
    ('2023-03-20'),
    ('2023-05-10'),
    ('2023-07-22'),
    ('2023-09-05'),
    ('2023-11-18'),
    ('2024-01-08'),
    ('2024-02-15'),
    ('2024-03-22'),
    ('2024-05-03'),
    ('2024-06-14'),
    ('2024-07-25'),
    ('2024-09-09');

-- Step 8: Insert certifications
INSERT INTO CERTIFICATION (Name)
VALUES
    ('CNC Machine Operation Level 1'),
    ('CNC Machine Operation Level 2'),
    ('Industrial Robotic Systems'),
    ('Precision Milling'),
    ('Quality Control Systems'),
    ('Safety Protocol Management'),
    ('Maintenance Engineering'),
    ('Production Planning'),
    ('Materials Handling'),
    ('Hydraulic Systems'),
    ('CAD/CAM Engineering'),
    ('PLC Programming'),
    ('Welding Certification');

-- Step 9: Insert operator certifications
INSERT INTO OPERATOR_CERTIFICATION (Employee_id, Certification_id, Date_awarded)
VALUES
    (6, 11, '2023-05-10'),  -- Engineering: CAD/CAM Engineering
    (6, 12, '2024-02-15'),  -- Engineering: PLC Programming
    (7, 11, '2023-11-18'),  -- Engineering: CAD/CAM Engineering
    (8, 12, '2024-05-03'),  -- Engineering: PLC Programming

    (11, 1, '2023-03-20'),  -- Production: CNC Machine Operation Level 1
    (11, 2, '2024-03-22'),  -- Production: CNC Machine Operation Level 2
    (12, 1, '2023-07-22'),  -- Production: CNC Machine Operation Level 1
    (13, 3, '2024-06-14'),  -- Production: Industrial Robotic Systems
    (14, 8, '2023-09-05'),  -- Production: Production Planning
    (15, 9, '2024-07-25'),  -- Production: Materials Handling

    (16, 5, '2023-03-20'),  -- Quality Control: Quality Control Systems
    (18, 5, '2024-01-08'),  -- Quality Control: Quality Control Systems

    (21, 7, '2023-05-10'),  -- Maintenance: Maintenance Engineering
    (22, 10, '2023-11-18'), -- Maintenance: Hydraulic Systems
    (23, 7, '2024-02-15'),  -- Maintenance: Maintenance Engineering

    (26, 13, '2023-01-15'), -- R&D: Welding Certification
    (27, 6, '2024-09-09');  -- R&D: Safety Protocol Management

-- Step 10: Insert production machines
INSERT INTO PRODUCTION_MACHINE (Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status, Last_Maintenance_Date, Next_Scheduled_Maintenance, Is_New)
VALUES
    ('Production', 'CNC Milling Machine', '2020-05-15', 1, 'Operational', '2024-02-10', '2024-02-13', 0),
    ('Production', 'CNC Lathe', '2021-03-20', 1, 'Operational', '2024-01-22', '2024-01-25', 0),
    ('Production', 'Industrial Robot', '2022-07-10', 1, 'Operational', '2024-03-05', '2024-03-08', 0),
    ('Production', 'Injection Molding Machine', '2019-11-28', 1, 'In service', '2024-04-15', NULL, 0),
    ('Production', '3D Printer (Industrial)', '2023-01-05', 1, 'Operational', '2024-05-20', '2024-05-23', 0),

    ('Engineering', 'Precision Laser Cutter', '2022-03-17', 1, 'Operational', '2024-02-18', '2024-02-21', 0),
    ('Engineering', 'Prototype 3D Printer', '2023-05-10', 1, 'Operational', '2024-04-08', '2024-04-11', 0),
    ('Engineering', 'Test Jig Assembly', '2021-09-22', 0, 'Operational', '2024-01-15', '2024-01-18', 0),
    ('Engineering', 'Electronic Testing Station', '2022-11-30', 1, 'In service', '2024-06-01', NULL, 0),

    ('Quality Control', 'Coordinate Measuring Machine', '2020-08-12', 1, 'Operational', '2024-03-10', '2024-03-13', 0),
    ('Quality Control', 'Optical Inspection System', '2021-05-25', 1, 'Operational', '2024-05-05', '2024-05-08', 0),
    ('Quality Control', 'Tensile Testing Machine', '2022-09-15', 0, 'Operational', '2024-01-30', '2024-02-02', 0),

    ('Maintenance', 'Hydraulic Press', '2019-07-08', 0, 'Operational', '2024-02-25', '2024-02-28', 0),
    ('Maintenance', 'Industrial Tooling System', '2021-02-14', 0, 'Operational', '2024-04-20', '2024-04-23', 0),
    ('Maintenance', 'Welding Station', '2020-10-30', 0, 'Awaiting service', '2023-12-15', '2023-12-18', 0),

    ('Research & Development', 'Material Testing System', '2022-04-05', 1, 'Operational', '2024-03-18', '2024-03-21', 0),
    ('Research & Development', 'Chemical Analysis Unit', '2023-02-28', 1, 'Operational', '2024-05-12', '2024-05-15', 0),
    ('Research & Development', 'Prototype Assembly Station', '2021-11-10', 0, 'In special service', '2024-04-30', NULL, 0),
    ('Research & Development', 'CAD Workstation Cluster', '2022-08-20', 1, 'Operational', '2024-01-05', '2024-01-08', 0),

    ('Production', 'Packaging System', '2020-12-10', 1, 'Operational', '2024-06-05', '2024-06-08', 0),
    ('Production', 'Assembly Line', '2021-06-30', 1, 'Operational', '2024-05-25', '2024-05-28', 0),
    ('Engineering', 'Circuit Board Tester', '2022-05-18', 1, 'Awaiting service', '2024-02-05', '2024-02-08', 0),
    ('Maintenance', 'Diagnostic System', '2023-03-10', 1, 'Operational', '2024-04-12', '2024-04-15', 0),
    ('Quality Control', 'X-Ray Inspection Unit', '2021-08-15', 1, 'Retired', '2023-11-10', NULL, 0),
    ('Production', 'Robotic Arm Assembly', '2024-01-15', 1, 'Operational', NULL, NULL, 1);

-- Step 11: Insert service histories
INSERT INTO SERVICE_HISTORY (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (1, 21, '2024-02-10 09:00:00', 'Regular maintenance performed. Replaced worn bearings and lubricated moving parts.', 'Resolved'),
    (2, 22, '2024-01-22 10:30:00', 'Calibration completed and tool holders replaced.', 'Resolved'),
    (3, 23, '2024-03-05 11:15:00', 'Reprogrammed movement sequences and updated firmware.', 'Resolved'),
    (4, 21, '2024-04-15 13:20:00', 'Hydraulic system repair in progress. Parts ordered.', 'In progress'),
    (5, 23, '2024-05-20 14:45:00', 'Extruder nozzle replaced and bed leveled.', 'Resolved'),
    (6, 22, '2024-02-18 08:30:00', 'Lens cleaning and alignment check completed.', 'Resolved'),
    (7, 23, '2024-04-08 09:45:00', 'Filament feed system maintenance and software update.', 'Resolved'),
    (8, 21, '2024-01-15 10:10:00', 'Connection terminals tightened and electrical safety check performed.', 'Resolved'),
    (9, 22, '2024-06-01 11:30:00', 'Circuit board replacement needed. Awaiting parts.', 'In progress'),
    (10, 23, '2024-03-10 13:15:00', 'Probe calibration and software update completed.', 'Resolved'),
    (11, 21, '2024-05-05 14:30:00', 'Camera alignment adjusted and lighting system replaced.', 'Resolved'),
    (12, 22, '2024-01-30 15:45:00', 'Load cell calibration and hydraulic fluid replacement.', 'Resolved'),
    (13, 23, '2024-02-25 08:15:00', 'Seal replacement and pressure system testing.', 'Resolved'),
    (14, 21, '2024-04-20 09:30:00', 'Tool holder replacements and alignment check.', 'Resolved'),
    (15, 22, '2023-12-15 10:45:00', 'Power supply issue identified. Awaiting replacement parts.', 'Awaiting Service Worker'),
    (16, 23, '2024-03-18 11:00:00', 'Sensor calibration and sample platform adjustment.', 'Resolved'),
    (17, 21, '2024-05-12 13:45:00', 'Ventilation system cleaned and detection sensors calibrated.', 'Resolved'),
    (18, 22, '2024-04-30 14:00:00', 'Custom fixture installation and testing. Special parts on order.', 'In progress'),
    (19, 23, '2024-01-05 15:30:00', 'System cooling maintenance and software update.', 'Resolved'),
    (20, 21, '2024-06-05 08:45:00', 'Belt replacement and motor adjustment completed.', 'Resolved'),
    (21, 22, '2024-05-25 09:15:00', 'Conveyor system maintenance and control system firmware update.', 'Resolved'),
    (22, 23, '2024-02-05 10:20:00', 'Circuit testing system fault. Diagnostic inspection required.', 'Awaiting Service Worker'),
    (23, 21, '2024-04-12 11:45:00', 'Software update and sensor calibration completed.', 'Resolved'),
    (24, 22, '2023-11-10 13:30:00', 'Unit reliability issues. Recommended for retirement.', 'Blocked');

-- Step 12: Insert special service histories
INSERT INTO SPECIAL_SERVICE_HISTORY (Machine_ID, Employee_ID, Date_Of_Service, Service_Notes, Resolution_Status)
VALUES
    (4, 21, '2024-04-20', 'Complete hydraulic system overhaul required. Extensive disassembly needed.', 'In progress'),
    (9, 22, '2024-06-05', 'Testing system motherboard replacement and firmware update.', 'In progress'),
    (15, 23, '2024-01-10', 'Power regulation system failure. Complete electrical overhaul required.', 'Awaiting Service Worker'),
    (18, 21, '2024-05-05', 'Custom modification for new product line testing. Engineering collaboration required.', 'In progress'),
    (22, 22, '2024-02-10', 'Testing algorithm failure. Software engineering team involvement required.', 'Blocked');

-- Step 13: Insert production machine operators (shifts)
INSERT INTO PRODUCTION_MACHINE_OPERATOR (Shift_Date, Machine_id, Employee_id, Shift_End, Operator_Task)
VALUES
    ('2024-01-05 07:00:00', 1, 11, '2024-01-05 15:00:00', 'Production run - Component A-2354'),
    ('2024-01-05 15:00:00', 1, 12, '2024-01-05 23:00:00', 'Production run - Component A-2354'),
    ('2024-01-06 07:00:00', 1, 11, '2024-01-06 15:00:00', 'Production run - Component A-2456'),
    ('2024-01-06 15:00:00', 1, 13, '2024-01-06 23:00:00', 'Production run - Component A-2456'),

    ('2024-01-10 07:00:00', 2, 12, '2024-01-10 15:00:00', 'Production run - Component B-1121'),
    ('2024-01-10 15:00:00', 2, 14, '2024-01-10 23:00:00', 'Production run - Component B-1121'),
    ('2024-01-11 07:00:00', 2, 13, '2024-01-11 15:00:00', 'Production run - Component B-1122'),
    ('2024-01-11 15:00:00', 2, 15, '2024-01-11 23:00:00', 'Production run - Component B-1122'),

    ('2024-02-05 07:00:00', 3, 11, '2024-02-05 15:00:00', 'Robot assembly line - Product C-550'),
    ('2024-02-05 15:00:00', 3, 12, '2024-02-05 23:00:00', 'Robot assembly line - Product C-550'),
    ('2024-02-06 07:00:00', 3, 13, '2024-02-06 15:00:00', 'Robot assembly line - Product C-550'),
    ('2024-02-06 15:00:00', 3, 14, '2024-02-06 23:00:00', 'Robot assembly line - Product C-550'),

    ('2024-03-12 07:00:00', 5, 15, '2024-03-12 15:00:00', '3D printing - Prototype D-788'),
    ('2024-03-13 07:00:00', 5, 11, '2024-03-13 15:00:00', '3D printing - Prototype D-788'),

    ('2024-03-20 07:00:00', 6, 6, '2024-03-20 15:00:00', 'Cutting parts for prototype E-901'),
    ('2024-03-21 07:00:00', 6, 7, '2024-03-21 15:00:00', 'Cutting parts for prototype E-901'),

    ('2024-04-02 08:00:00', 10, 16, '2024-04-02 16:00:00', 'Quality inspection - Product batch C-550'),
    ('2024-04-03 08:00:00', 10, 18, '2024-04-03 16:00:00', 'Quality inspection - Product batch C-550'),

    ('2024-05-15 07:00:00', 20, 12, '2024-05-15 15:00:00', 'Packaging run - Final product F-233'),
    ('2024-05-15 15:00:00', 20, 13, '2024-05-15 23:00:00', 'Packaging run - Final product F-233'),
    ('2024-05-16 07:00:00', 20, 15, '2024-05-16 15:00:00', 'Packaging run - Final product F-233'),
    ('2024-05-16 15:00:00', 20, 11, '2024-05-16 23:00:00', 'Packaging run - Final product F-233'),

    ('2024-06-10 07:00:00', 21, 14, '2024-06-10 15:00:00', 'Assembly line - Product G-340'),
    ('2024-06-10 15:00:00', 21, 13, '2024-06-10 23:00:00', 'Assembly line - Product G-340');

-- Step 14: Insert product prices
INSERT INTO PRODUCT_PRICE (Production_Cost)
VALUES
    (12.75),   -- Sale price will be $18.49
    (25.50),   -- Sale price will be $36.98
    (8.30),    -- Sale price will be $12.04
    (45.20),   -- Sale price will be $65.54
    (67.80),   -- Sale price will be $98.31
    (105.25),  -- Sale price will be $152.61
    (3.15),    -- Sale price will be $4.57
    (18.90),   -- Sale price will be $27.41
    (33.45),   -- Sale price will be $48.50
    (51.60),   -- Sale price will be $74.82
    (92.75),   -- Sale price will be $134.49
    (123.40),  -- Sale price will be $178.93
    (7.55),    -- Sale price will be $10.95
    (29.30),   -- Sale price will be $42.49
    (54.85);   -- Sale price will be $79.53

-- Step 15: Insert products
INSERT INTO PRODUCT (Description, Production_cost)
VALUES
    ('Circuit Board Component A', 12.75),         -- ID 1
    ('Hydraulic Control Unit', 25.50),            -- ID 2
    ('Plastic Housing Small', 8.30),              -- ID 3
    ('Metal Chassis Assembly', 45.20),            -- ID 4
    ('Cooling System Complete', 67.80),           -- ID 5
    ('Industrial Control System', 105.25),        -- ID 6
    ('Fastener Kit', 3.15),                       -- ID 7
    ('Drive Belt Assembly', 18.90),               -- ID 8
    ('Power Supply Unit', 33.45),                 -- ID 9
    ('LCD Display Panel', 51.60),                 -- ID 10
    ('Motor Control Assembly', 92.75),            -- ID 11
    ('Complete Smart Device', 123.40),            -- ID 12
    ('Cable Harness', 7.55),                      -- ID 13
    ('Sensor Array', 29.30),                      -- ID 14
    ('Interface Module', 54.85);                  -- ID 15

-- Step 16: Insert components in products (showing which products are made up of other products)
INSERT INTO COMPONENTS_IN_PRODUCT (Assembly_Product_Number, Component_Product_Number, Quantity)
VALUES
    -- Industrial Control System (ID 6) contains:
    (6, 1, 3),  -- 3 Circuit Board Components
    (6, 9, 1),  -- 1 Power Supply Unit
    (6, 10, 1), -- 1 LCD Display Panel
    (6, 13, 2), -- 2 Cable Harnesses
    (6, 14, 2), -- 2 Sensor Arrays
    (6, 15, 1), -- 1 Interface Module

    -- Complete Smart Device (ID 12) contains:
    (12, 1, 1),  -- 1 Circuit Board Component
    (12, 3, 2),  -- 2 Plastic Housing Small
    (12, 7, 1),  -- 1 Fastener Kit
    (12, 9, 1),  -- 1 Power Supply Unit
    (12, 10, 1), -- 1 LCD Display Panel
    (12, 13, 1), -- 1 Cable Harness
    (12, 14, 1), -- 1 Sensor Array

    -- Motor Control Assembly (ID 11) contains:
    (11, 1, 2),  -- 2 Circuit Board Components
    (11, 2, 1),  -- 1 Hydraulic Control Unit
    (11, 8, 1),  -- 1 Drive Belt Assembly
    (11, 9, 1),  -- 1 Power Supply Unit
    (11, 13, 2), -- 2 Cable Harnesses

    -- Cooling System Complete (ID 5) contains:
    (5, 3, 1),   -- 1 Plastic Housing Small
    (5, 7, 1),   -- 1 Fastener Kit
    (5, 8, 1),   -- 1 Drive Belt Assembly
    (5, 13, 1),  -- 1 Cable Harness

    -- Metal Chassis Assembly (ID 4) contains:
    (4, 3, 2),   -- 2 Plastic Housing Small
    (4, 7, 2);   -- 2 Fastener Kits

-- Step 17: Insert production machine products (which machines can produce which products)
INSERT INTO PRODUCTION_MACHINE_PRODUCT (Machine_id, Product_Number)
VALUES
    -- CNC Milling Machine (ID 1) can produce:
    (1, 2),  -- Hydraulic Control Unit
    (1, 4),  -- Metal Chassis Assembly

    -- CNC Lathe (ID 2) can produce:
    (2, 2),  -- Hydraulic Control Unit
    (2, 8),  -- Drive Belt Assembly

    -- Industrial Robot (ID 3) can produce:
    (3, 5),  -- Cooling System Complete
    (3, 6),  -- Industrial Control System
    (3, 11), -- Motor Control Assembly
    (3, 12), -- Complete Smart Device

    -- Injection Molding Machine (ID 4) can produce:
    (4, 3),  -- Plastic Housing Small

    -- 3D Printer (Industrial) (ID 5) can produce:
    (5, 3),  -- Plastic Housing Small
    (5, 15), -- Interface Module

    -- Precision Laser Cutter (ID 6) can produce:
    (6, 1),  -- Circuit Board Component A
    (6, 13), -- Cable Harness

    -- Prototype 3D Printer (ID 7) can produce:
    (7, 3),  -- Plastic Housing Small (prototypes)
    (7, 15), -- Interface Module (prototypes)

    -- Assembly Line (ID 21) can produce:
    (21, 6),  -- Industrial Control System
    (21, 11), -- Motor Control Assembly
    (21, 12), -- Complete Smart Device

    -- Packaging System (ID 20) handles all finished products
    (20, 5),  -- Cooling System Complete
    (20, 6),  -- Industrial Control System
    (20, 11), -- Motor Control Assembly
    (20, 12); -- Complete Smart Device

-- Step 18: Insert production processes
INSERT INTO PRODUCTION_PROCESS (Product_Number, Machine_id, Sequence_Number, Process_Type, Build_Time_In_Seconds)
VALUES
    -- Circuit Board Component A (ID 1) production process
    (1, 6, 1, 'Laser Cutting', 120),

    -- Hydraulic Control Unit (ID 2) production process
    (2, 1, 1, 'Milling', 300),
    (2, 2, 2, 'Turning', 180),

    -- Plastic Housing Small (ID 3) production process
    (3, 4, 1, 'Injection Molding', 90),

    -- Metal Chassis Assembly (ID 4) production process
    (4, 1, 1, 'Milling', 450),

    -- Cooling System Complete (ID 5) production process
    (5, 3, 1, 'Robotic Assembly', 600),

    -- Industrial Control System (ID 6) production process
    (6, 3, 1, 'Component Assembly', 480),
    (6, 21, 2, 'Final Assembly', 600),

    -- Complete Smart Device (ID 12) production process
    (12, 3, 1, 'Component Placement', 180),
    (12, 21, 2, 'System Integration', 300),
    (12, 21, 3, 'Final Assembly', 240),

    -- Motor Control Assembly (ID 11) production process
    (11, 3, 1, 'Robotic Assembly', 420),
    (11, 21, 2, 'System Integration', 360),

    -- Interface Module (ID 15) production process
    (15, 5, 1, '3D Printing', 540);

-- Step 19: Insert product instances (actual products that were manufactured)
INSERT INTO PRODUCT_INSTANCE (Product_Number, Machine_id, Manufacture_Date_Time)
VALUES
    -- Circuit Board Component A instances
    (1, 6, '2024-01-10 09:15:22'),
    (1, 6, '2024-01-10 09:17:45'),
    (1, 6, '2024-01-10 09:20:12'),
    (1, 6, '2024-01-10 13:30:05'),
    (1, 6, '2024-01-10 13:32:18'),
    (1, 6, '2024-02-15 10:05:33'),
    (1, 6, '2024-02-15 10:07:56'),
    (1, 6, '2024-02-15 14:20:42'),
    (1, 6, '2024-02-15 14:23:17'),
    (1, 6, '2024-03-22 11:10:08'),

    -- Hydraulic Control Unit instances
    (2, 1, '2024-01-15 08:45:30'),
    (2, 1, '2024-01-15 09:55:12'),
    (2, 2, '2024-02-20 10:30:25'),
    (2, 2, '2024-02-20 11:45:18'),
    (2, 1, '2024-04-10 13:20:05'),

    -- Plastic Housing Small instances
    (3, 4, '2024-01-20 14:10:40'),
    (3, 4, '2024-01-20 14:12:15'),
    (3, 4, '2024-01-20 14:13:50'),
    (3, 4, '2024-01-20 14:15:25'),
    (3, 4, '2024-02-25 09:30:22'),
    (3, 4, '2024-02-25 09:31:57'),
    (3, 4, '2024-02-25 09:33:32'),
    (3, 4, '2024-02-25 09:35:07'),
    (3, 5, '2024-03-15 15:05:10'),
    (3, 5, '2024-03-15 15:14:15'),

    -- Cooling System Complete instances
    (5, 3, '2024-02-05 11:20:38'),
    (5, 3, '2024-02-05 11:31:24'),
    (5, 3, '2024-04-15 13:45:12'),

    -- Industrial Control System instances
    (6, 21, '2024-02-10 14:25:55'),
    (6, 21, '2024-03-20 10:15:30'),
    (6, 21, '2024-05-05 11:35:45'),

    -- Complete Smart Device instances
    (12, 21, '2024-03-01 09:50:15'),
    (12, 21, '2024-03-01 10:10:25'),
    (12, 21, '2024-05-10 14:30:40'),
    (12, 21, '2024-05-10 14:50:55'),

    -- Motor Control Assembly instances
    (11, 21, '2024-02-15 13:20:10'),
    (11, 21, '2024-02-15 14:05:22'),
    (11, 21, '2024-04-20 11:15:35'),
    (11, 21, '2024-04-20 12:00:48'),

    -- Interface Module instances
    (15, 5, '2024-03-25 10:40:20'),
    (15, 5, '2024-03-25 10:49:45'),
    (15, 5, '2024-05-15 15:25:30'),
    (15, 5, '2024-05-15 15:34:55');

-- Adding 3 more employees to each department with end dates in 2024
-- Engineering Department (additional employees with end dates)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (1, 83000.00, 'Engineering', '2023-11-15', '2024-07-22'),           -- ID 31
    (1, 82000.00, 'Engineering', '2024-01-08', '2024-10-15'),           -- ID 32
    (1, 81500.00, 'Engineering', '2023-08-20', '2024-05-05');           -- ID 33

-- Production Department (additional employees with end dates)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (2, 76500.00, 'Production', '2023-09-12', '2024-03-30'),            -- ID 34
    (2, 75800.00, 'Production', '2023-10-01', '2024-08-18'),            -- ID 35
    (2, 75000.00, 'Production', '2024-02-15', '2024-11-30');            -- ID 36

-- Quality Control Department (additional employees with end dates)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (3, 79500.00, 'Quality Control', '2023-12-05', '2024-09-15'),       -- ID 37
    (3, 78800.00, 'Quality Control', '2023-07-15', '2024-04-10'),       -- ID 38
    (3, 78000.00, 'Quality Control', '2024-01-20', '2024-10-25');       -- ID 39

-- Maintenance Department (additional employees with end dates)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (4, 79000.00, 'Maintenance', '2023-08-10', '2024-02-28'),           -- ID 40
    (4, 78500.00, 'Maintenance', '2023-10-22', '2024-06-15'),           -- ID 41
    (4, 77800.00, 'Maintenance', '2024-03-01', '2024-12-15');           -- ID 42

-- Research & Development Department (additional employees with end dates)
INSERT INTO EMPLOYEE (ManagerID, Salary, DepartmentName, StartDate, EndDate)
VALUES
    (5, 87000.00, 'Research & Development', '2023-11-10', '2024-05-15'), -- ID 43
    (5, 86200.00, 'Research & Development', '2023-09-25', '2024-07-31'), -- ID 44
    (5, 85500.00, 'Research & Development', '2024-02-05', '2024-11-20'); -- ID 45

-- Update some existing employees to have start dates in 2024
-- Note: These are employees that previously had earlier start dates
UPDATE EMPLOYEE
SET StartDate = '2024-01-10', EndDate = '2024-09-30'
WHERE EmployeeID = 9;

UPDATE EMPLOYEE
SET StartDate = '2024-02-20', EndDate = '2024-12-15'
WHERE EmployeeID = 15;

UPDATE EMPLOYEE
SET StartDate = '2024-03-05'
WHERE EmployeeID = 20;

UPDATE EMPLOYEE
SET StartDate = '2024-01-15', EndDate = '2024-10-31'
WHERE EmployeeID = 25;

UPDATE EMPLOYEE
SET StartDate = '2024-02-10', EndDate = '2024-11-15'
WHERE EmployeeID = 28;

-- Update a random selection of employees to start between April and September 2024
-- While ensuring startDate < EndDate

-- Employee #7 (Engineering)
UPDATE EMPLOYEE
SET StartDate = '2024-04-15'
WHERE EmployeeID = 7;

-- Employee #13 (Production)
UPDATE EMPLOYEE
SET StartDate = '2024-05-20'
WHERE EmployeeID = 13;

-- Employee #18 (Quality Control)
UPDATE EMPLOYEE
SET StartDate = '2024-06-05'
WHERE EmployeeID = 18;

-- Employee #23 (Maintenance)
UPDATE EMPLOYEE
SET StartDate = '2024-07-12'
WHERE EmployeeID = 23;

-- Employee #27 (Research & Development)
UPDATE EMPLOYEE
SET StartDate = '2024-08-08'
WHERE EmployeeID = 27;

-- Employee #32 (Engineering - one of the new employees)
UPDATE EMPLOYEE
SET StartDate = '2024-06-18', EndDate = '2024-12-15'
WHERE EmployeeID = 32;

-- Employee #36 (Production - one of the new employees)
UPDATE EMPLOYEE
SET StartDate = '2024-04-25'
WHERE EmployeeID = 36;

-- Employee #39 (Quality Control - one of the new employees)
UPDATE EMPLOYEE
SET StartDate = '2024-05-10'
WHERE EmployeeID = 39;

-- Employee #42 (Maintenance - one of the new employees)
UPDATE EMPLOYEE
SET StartDate = '2024-07-01'
WHERE EmployeeID = 42;

-- Employee #45 (Research & Development - one of the new employees)
UPDATE EMPLOYEE
SET StartDate = '2024-09-05', EndDate = '2024-12-20'
WHERE EmployeeID = 45;