CREATE DATABASE LSBU_Manufacturing;
GO

USE LSBU_Manufacturing;
GO
-- Department and Employee Tables

CREATE TABLE DEPARTMENT (
    DepartmentName VARCHAR(255) NOT NULL,
    ManagerID int NOT NULL,
    CONSTRAINT DepartmentPK PRIMARY KEY (DepartmentName)
);

CREATE TABLE EMPLOYEE (
    EmployeeID int NOT NULL IDENTITY(1,1),
    ManagerID int NULL,
    Salary NUMERIC(19,2) NOT NULL,
    DepartmentName VARCHAR(255) NULL,
    CONSTRAINT EmployeePK PRIMARY KEY(EmployeeID)
);

-- Add foreign keys to Department and Employee Tables

ALTER TABLE DEPARTMENT
ADD CONSTRAINT ManagerFKEmployee FOREIGN KEY (ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT ManagerREF FOREIGN KEY(ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EmployeeFKDepartment FOREIGN KEY(DepartmentName)
    REFERENCES DEPARTMENT(DepartmentName)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

-- Union Table

CREATE TABLE UNIONTABLE (
    UnionID int NOT NULL IDENTITY(1,1),
    Name VARCHAR(255)
    CONSTRAINT UnionPK PRIMARY KEY (UnionID)
);

-- Operator Table

CREATE TABLE OPERATOR (
    EmployeeID int NOT NULL,
    UnionID int NOT NULL
    CONSTRAINT OperatorFKUnion FOREIGN KEY (UnionID)
        REFERENCES UNIONTABLE(UnionID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT OperatorPK PRIMARY KEY (EmployeeID),
    CONSTRAINT OperatorStrongPK FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

-- Create and Alter Certification table and Certification/Operator Junction table

CREATE TABLE CERTIFICATION (
    Certification_id int identity(1,1),
    Name varchar(max) NOT NULL
    CONSTRAINT CertificationPK PRIMARY KEY (Certification_id)
);

CREATE TABLE OPERATOR_CERTIFICATION(
    Employee_id int NOT NULL,
    Certification_id int NOT NULL,
    Date_awarded date,
    expiry date,

    CONSTRAINT OperatorCertificationPK PRIMARY KEY (Employee_id,Certification_id),
    CONSTRAINT OperatorCertificationFKEmployee FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT OperatorCertificationFKCertification FOREIGN KEY (Certification_id)
        REFERENCES CERTIFICATION(Certification_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

-- Create Production Machine

CREATE TABLE PRODUCTION_MACHINE (
    Machine_id int identity (1,1) NOT NULL,
    Department_name varchar(255) default 'Unassigned',
    Machine_Type varchar(255) NOT NULL,
    Purchase_Date DATE NOT NULL,
    -- find out how to make this a boolean
    Is_Automatic BIT NOT NULL,
    -- constraint for specific statuses
    Maintenance_Status VARCHAR(255) NOT NULL,
    Last_Maintenance_Date DATETIME2 NULL,
    Next_Scheduled_Maintenance DATETIME2 NULL,
    Is_New BIT DEFAULT 1

    CONSTRAINT MachinePK primary key (Machine_id),
    CONSTRAINT MachineFKDepartment foreign key (Department_name)
        REFERENCES DEPARTMENT(DEPARTMENTNAME)
            ON UPDATE CASCADE
            ON DELETE SET DEFAULT,
    CONSTRAINT ValidMaintenanceStatus CHECK (Maintenance_Status
        IN ('Operational','In service','In special service','Awaiting service','Retired'))
);

-- Create Service Histories

CREATE TABLE SERVICE_HISTORY(
    Service_ID int identity(1,1),
    Machine_ID int NOT NULL,
    Employee_ID int NULL default 'outsourced',
    Date_Of_Service DATETIME NOT NULL default getDate(),
    Service_Notes varchar(max) NULL,
    Resolution_Status Varchar(255) NOT NULL

    CONSTRAINT ServicePK PRIMARY KEY (Service_ID),
    CONSTRAINT ServiceFKMachine FOREIGN KEY (Machine_ID)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    CONSTRAINT ServiceFKEmployee FOREIGN KEY (Employee_ID)
        REFERENCES  EMPLOYEE(EmployeeID)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT ResolutionStatusValidation CHECK
        (Resolution_Status IN ('In progress','Resolved','Awaiting Service Worker','Blocked'))
);

CREATE TABLE SPECIAL_SERVICE_HISTORY(
    Special_Service_ID int identity(1,1),
    Machine_ID int NOT NULL,
    Employee_ID int NULL,
    --This MIGHT cause an error where 2 machines cant go into service on the same date, check back later...
    Date_Of_Service DATE UNIQUE NOT NULL default getDate(),
    Service_Notes varchar(max) NULL,
    Resolution_Status Varchar(255) NOT NULL

    CONSTRAINT SpecialServicePK PRIMARY KEY (Special_Service_ID),
    CONSTRAINT SpecialServiceFKMachine FOREIGN KEY (Machine_ID)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    CONSTRAINT SpecialServiceFKEmployee FOREIGN KEY (Employee_ID)
        REFERENCES  EMPLOYEE(EmployeeID)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT SpecialServiceResolutionStatusValidation CHECK
        (Resolution_Status IN ('In progress','Resolved','Awaiting Service Worker','Blocked'))
);

-- Machine/Operator Junction Table

CREATE TABLE PRODUCTION_MACHINE_OPERATOR (
    Shift_Date DATETIME2 NOT NULL,
    Machine_id int NOT NULL,
    Employee_id int NOT NULL,
    Shift_End DATETIME2 NOT NULL,
    Operator_Task varchar(max) NOT NULL

    CONSTRAINT PRODUCTION_MACHINE_OPERATORCPK PRIMARY KEY (Shift_Date,Machine_id,Employee_id),
    CONSTRAINT PRODUCTION_MACHINE_OPERATORFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT PRODUCTION_MACHINE_OPERATORFKEmployee FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE (EmployeeID)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT ShiftEndAfterStartValidation CHECK (Shift_End > Shift_Date)
);

-- Create Product

CREATE TABLE PRODUCT (
    Product_Number int identity(1,1),
    Description varchar(max) NULL,
    Production_Cost numeric(19,2) NOT NULL,
    -- PERSISTED Keyword stored the value instead of generating on query, takes up storage for faster querying
    Sale_Price AS (Production_Cost * 1.45) PERSISTED

    CONSTRAINT ProductPK PRIMARY KEY (Product_Number),
);

-- Components in product many-to-many table

CREATE TABLE COMPONENTS_IN_PRODUCT(
    Assembly_Product_Number int NOT NULL,
    Component_Product_Number  int NOT NULL,
    Quantity int NOT NULL default 1

    CONSTRAINT COMPONENTS_IN_PRODUCTCPK PRIMARY KEY (Assembly_Product_Number, Component_Product_Number),
    CONSTRAINT COMPONENTS_IN_PRODUCTFKProduct1 FOREIGN KEY (Assembly_Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT COMPONENTS_IN_PRODUCTFKProduct2 FOREIGN KEY (Component_Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

-- Product/Machine Junction Tables

CREATE TABLE PRODUCTION_MACHINE_PRODUCT (
    Machine_id int NOT NULL,
    Product_Number int NOT NULL

    CONSTRAINT PRODUCTION_MACHINE_PRODUCTCPK PRIMARY KEY (Machine_id,Product_Number),
    CONSTRAINT PRODUCTION_MACHINE_PRODUCTFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE NO ACTION
            ON DELETE CASCADE,
    CONSTRAINT PRODUCTION_MACHINE_PRODUCTFKProduct FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON UPDATE NO ACTION
            ON DELETE CASCADE
);

CREATE TABLE PRODUCTION_PROCESS (
    Process_id int identity(1,1),
    Product_Number int,
    Machine_id int,
    -- Might not be needed?
    Sequence_Number int NOT NULL,
    Process_Type varchar(255) NOT NULL,
    Build_Time_In_Seconds numeric(19,0) NOT NULL

    CONSTRAINT ProductionProcessPK PRIMARY KEY (Process_id),
    CONSTRAINT ProductionProcessFKProduct FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT ProductionProcessFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

CREATE TABLE PRODUCT_INSTANCE (
    Serial_Number int identity(1,1),
    Product_Number int,
    Machine_id int,
    Manufacture_Date_Time DATETIME2 NOT NULL default getDate()

    CONSTRAINT ProductInstancePK PRIMARY KEY (Serial_Number),
    CONSTRAINT ProductInstanceFKProduct FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT ProductInstanceFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

-- Minimum 3 employees per department Trigger

CREATE TRIGGER trg_MinimumEmployeesPerDepartment
ON EMPLOYEE
AFTER UPDATE, DELETE
AS
BEGIN
    -- Get affected departments from the current operation
    DECLARE @AffectedDepartments TABLE (DepartmentName VARCHAR(255));

    -- For updates, both old and new departments are affected
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO @AffectedDepartments
        SELECT DepartmentName FROM inserted WHERE DepartmentName IS NOT NULL
        UNION
        SELECT DepartmentName FROM deleted WHERE DepartmentName IS NOT NULL;
    END
    ELSE
    BEGIN
        -- For deletes, only the departments employees were removed from
        INSERT INTO @AffectedDepartments
        SELECT DepartmentName FROM deleted WHERE DepartmentName IS NOT NULL;
    END

    -- Check if any affected department now has fewer than 3 employees
    DECLARE @InvalidDepartments TABLE (DepartmentName VARCHAR(255));

    INSERT INTO @InvalidDepartments
    SELECT d.DepartmentName
    FROM @AffectedDepartments a
    JOIN DEPARTMENT d ON a.DepartmentName = d.DepartmentName
    LEFT JOIN EMPLOYEE e ON d.DepartmentName = e.DepartmentName
    GROUP BY d.DepartmentName
    HAVING COUNT(e.EmployeeID) < 3;

    -- If any affected departments violate the rule, roll back
    IF EXISTS (SELECT 1 FROM @InvalidDepartments)
    BEGIN
        DECLARE @DeptList VARCHAR(MAX) = '';

        SELECT @DeptList = @DeptList + DepartmentName + ', '
        FROM @InvalidDepartments;

        SET @DeptList = LEFT(@DeptList, LEN(@DeptList) - 1);

        ROLLBACK TRANSACTION;
        RAISERROR('Operation would result in fewer than 3 employees in department(s): %s. Transaction rolled back.', 16, 1, @DeptList);
    END
END;

-- Machines must always be on


-- Certificate expiration == 2 years after awarded date.


-- Unless the machine is new, Service must be every 72 hours


-- Manager must be paid more than employee

Create TRIGGER trg_EmployeeSalaryCheck
ON EMPLOYEE
AFTER INSERT, UPDATE
AS
BEGIN
    -- Scenario 1: Check if any updated employee's salary exceeds their manager's
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN EMPLOYEE m ON i.ManagerID = m.EmployeeID
        WHERE i.Salary >= m.Salary
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Employees cannot earn more than or equal to their manager. Transaction rolled back.', 16, 1);
        RETURN;
    END

    -- Scenario 2: Check if any updated manager's salary is now less than their employees'
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN EMPLOYEE e ON e.ManagerID = i.EmployeeID
        WHERE e.Salary >= i.Salary
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Managers cannot earn less than or equal to their employees. Transaction rolled back.', 16, 1);
        RETURN;
    END
END;