CREATE DATABASE LSBU_Manufacturing;
go;

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
    DepartmentName VARCHAR(255) NOT NULL,
    CONSTRAINT EmployeePK PRIMARY KEY(EmployeeID)
);

-- Add foreign keys to Department and Employee Tables

ALTER TABLE DEPARTMENT
ADD CONSTRAINT ManagerFK FOREIGN KEY (ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT ManagerREF FOREIGN KEY(ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT DepartmentFK FOREIGN KEY(DepartmentName)
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
    CONSTRAINT OperatorFK FOREIGN KEY (UnionID)
        REFERENCES UNIONTABLE(UnionID)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT OperatorPK PRIMARY KEY (EmployeeID),
    CONSTRAINT OperatorPKFK FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

-- Create and Alter Certification table and Certification/Operator Junction table

CREATE TABLE CERTIFICATION (
    Certification_id int identity(1,1),
    Name varchar NOT NULL
    CONSTRAINT CertificationPK PRIMARY KEY (Certification_id)
);

CREATE TABLE OPERATOR_CERTIFICATION(
    Employee_id int,
    Certification_id int,
    Date_awarded date,
    expiry date,
);

ALTER TABLE OPERATOR_CERTIFICATION
    ALTER COLUMN Employee_id int NOT NULL;

ALTER TABLE OPERATOR_CERTIFICATION
    ALTER COLUMN Certification_id int NOT NULL;

ALTER TABLE OPERATOR_CERTIFICATION
    ADD CONSTRAINT OCCPK PRIMARY KEY (Employee_id,Certification_id),
    CONSTRAINT OCFK1 FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT OCFK2 FOREIGN KEY (Certification_id)
        REFERENCES CERTIFICATION(Certification_id)
            ON UPDATE CASCADE
            ON DELETE CASCADE;

-- Create Production Machine

CREATE TABLE PRODUCTION_MACHINE (
    Machine_id int identity (1,1) NOT NULL,
    Department_name varchar(255) default 'Unassigned',
    Machine_Type varchar(255) NOT NULL,
    Purchase_Date DATE NOT NULL,
    -- find out how to make this a boolean
    Is_Automatic BIT NOT NULL,
    -- constaint for specific statuses
    Maintenance_Status VARCHAR(255) NOT NULL,
    Last_Maintenance_Date DATE NULL,
    Nex_Schedualed_Maintenance Date NULL,
    Is_New BIT DEFAULT 1

    CONSTRAINT MachinePK primary key (Machine_id),
    CONSTRAINT MachineFK foreign key (Department_name)
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
    Employee_ID int NULL,
    Date_Of_Service DATETIME NOT NULL default getDate(),
    Service_Notes varchar(max) NULL,
    Resolution_Status Varchar(255) NOT NULL

    CONSTRAINT ServicePK PRIMARY KEY (Service_ID),
    CONSTRAINT ServiceFK1 FOREIGN KEY (Machine_ID)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    CONSTRAINT ServiceFK2 FOREIGN KEY (Employee_ID)
        REFERENCES  EMPLOYEE(EmployeeID)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT ResolutionStatusValidation CHECK
        (Resolution_Status IN ('In progress','Resolved','Awating Service Worker','Blocked'))
);

CREATE TABLE SPECIAL_SERVICE_HISTORY(
    Special_Service_ID int identity(1,1),
    Machine_ID int NOT NULL,
    Employee_ID int NULL,
    Date_Of_Service DATETIME NOT NULL default getDate(),
    Service_Notes varchar(max) NULL,
    Resolution_Status Varchar(255) NOT NULL

    CONSTRAINT SpecialServicePK PRIMARY KEY (Special_Service_ID),
    CONSTRAINT SpecialServiceFK1 FOREIGN KEY (Machine_ID)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    CONSTRAINT SpecialServiceFK2 FOREIGN KEY (Employee_ID)
        REFERENCES  EMPLOYEE(EmployeeID)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT SpecialServiceResolutionStatusValidation CHECK
        (Resolution_Status IN ('In progress','Resolved','Awating Service Worker','Blocked'))
);

ALTER TABLE SPECIAL_SERVICE_HISTORY
    ADD CONSTRAINT OneServicePerDay UNIQUE (Date_Of_Service);

-- Machine/Operator Junction Table

CREATE TABLE PRODUCTION_MACHINE_OPERATOR (
    Shift_Date DATETIME2 NOT NULL,
    Machine_id int NOT NULL,
    Employee_id int NOT NULL,
    Shift_End DATETIME2 NOT NULL,
    Operator_Task varchar(max) NOT NULL

    CONSTRAINT PMOCPK PRIMARY KEY (Shift_Date,Machine_id,Employee_id),
    CONSTRAINT PMOFK1 FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE NO ACTION
            ON DELETE NO ACTION,
    CONSTRAINT PMOFK2 FOREIGN KEY (Employee_id)
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
    -- Sale price needs to be a function that takes production cost and * 1.45 iirc.
    Sale_Price numeric(19,2) NOT NULL

    CONSTRAINT ProductPK PRIMARY KEY (Product_Number),
);

-- Components in product many-to-many table

CREATE TABLE COMPONENTS_IN_PRODUCT(
    Assembly_Product_Number int NOT NULL,
    Component_Product_Number  int NOT NULL,
    Quantity int NOT NULL default 1

    CONSTRAINT CIPCPK PRIMARY KEY (Assembly_Product_Number, Component_Product_Number),
    CONSTRAINT CIPFK1 FOREIGN KEY (Assembly_Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT CIPFK2 FOREIGN KEY (Component_Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);

-- Product/Machine Junction Tables

CREATE TABLE PRODUCTION_MACHINE_PRODUCT (
    Machine_id int NOT NULL,
    Product_Number int NOT NULL

    CONSTRAINT PMPCPK PRIMARY KEY (Machine_id,Product_Number),
    CONSTRAINT PMPFK1 FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE NO ACTION
            ON DELETE CASCADE,
    CONSTRAINT PMPFK2 FOREIGN KEY (Product_Number)
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
    CONSTRAINT ProductionProcessFK1 FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT ProductionProcessFK2 FOREIGN KEY (Machine_id)
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
    CONSTRAINT ProductInstanceFK1 FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT ProductInstanceFK2 FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
);