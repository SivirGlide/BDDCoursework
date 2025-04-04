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
    DepartmentName VARCHAR(255) null,
    StartDate DATE NOT NULL DEFAULT GETDATE(),
    EndDate DATE NULL --default assumes still employed
    CONSTRAINT EmployeePK PRIMARY KEY(EmployeeID)
);

-- Add foreign keys to Department and Employee Tables

ALTER TABLE DEPARTMENT
ADD CONSTRAINT ManagerFKEmployee FOREIGN KEY (ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE cascade
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT ManagerREF FOREIGN KEY(ManagerID)
    REFERENCES EMPLOYEE(EmployeeID)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT EmployeeFKDepartment FOREIGN KEY(DepartmentName)
    REFERENCES DEPARTMENT(DepartmentName)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

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
            ON DELETE no action
            ON UPDATE CASCADE,
    CONSTRAINT OperatorPK PRIMARY KEY (EmployeeID),
    CONSTRAINT OperatorStrongPK FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEE(EmployeeID)
            ON UPDATE CASCADE
            ON DELETE cascade
);

CREATE TABLE CERTIFICATION_DATES(
    Date_awarded DATE,
    Expiry_Date AS DATEADD(YEAR, 2, Date_awarded),

    CONSTRAINT CertDatePK PRIMARY KEY (Date_awarded)
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
    Date_awarded DATE,

    CONSTRAINT OperatorCertificationPK PRIMARY KEY (Employee_id,Certification_id),
    CONSTRAINT OperatorCertificationFKEmployee FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE(EmployeeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT OperatorCertificationFKCertification FOREIGN KEY (Certification_id)
        REFERENCES CERTIFICATION(Certification_id)
            ON UPDATE CASCADE
            ON DELETE no action,
    CONSTRAINT OperatorCertificationFKAwardDates FOREIGN KEY (Date_awarded)
        REFERENCES CERTIFICATION_DATES (Date_awarded)
            ON UPDATE CASCADE
            ON DELETE no action
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
            ON UPDATE no action
            ON DELETE NO ACTION,
    CONSTRAINT ResolutionStatusValidation CHECK
        (Resolution_Status IN ('In progress','Resolved','Awaiting Service Worker','Blocked'))
);

CREATE TABLE SPECIAL_SERVICE_HISTORY(
    Special_Service_ID int identity(1,1),
    Machine_ID int NOT NULL,
    Employee_ID int NULL,
    --This MIGHT cause an error where 2 machines cant go into service on the same date, check back later...
    Date_Of_Service DATE NOT NULL default getDate(),
    Service_Notes varchar(max) NULL,
    Resolution_Status Varchar(255) NOT NULL

    CONSTRAINT SpecialServicePK PRIMARY KEY (Special_Service_ID),
    CONSTRAINT SpecialServiceFKMachine FOREIGN KEY (Machine_ID)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE CASCADE
            ON DELETE NO ACTION,
    CONSTRAINT SpecialServiceFKEmployee FOREIGN KEY (Employee_ID)
        REFERENCES  EMPLOYEE(EmployeeID)
            ON UPDATE no action
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
            ON UPDATE cascade
            ON DELETE NO ACTION,
    CONSTRAINT PRODUCTION_MACHINE_OPERATORFKEmployee FOREIGN KEY (Employee_id)
        REFERENCES EMPLOYEE (EmployeeID)
            ON UPDATE no action
            ON DELETE NO ACTION,
    CONSTRAINT ShiftEndAfterStartValidation CHECK (Shift_End > Shift_Date)
);

-- Create product prices
CREATE TABLE PRODUCT_PRICE(
    Production_Cost numeric(19,2) NOT NULL,
    -- PERSISTED Keyword stored the value instead of generating on query, takes up storage for faster querying
    Sale_Price AS (Production_Cost * 1.45) PERSISTED

    CONSTRAINT PRICEPK PRIMARY KEY (Production_Cost)
);

-- Create Product

CREATE TABLE PRODUCT (
    Product_Number int identity(1,1),
    Description varchar(max) NULL,
    Production_cost numeric (19,2) NOT NULL
    CONSTRAINT ProductPK PRIMARY KEY (Product_Number),
    CONSTRAINT ProductPriceFK FOREIGN KEY (Production_cost)
        references PRODUCT_PRICE (Production_Cost)
            ON UPDATE CASCADE
            ON DELETE NO ACTION
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
            ON UPDATE cascade ,
    CONSTRAINT COMPONENTS_IN_PRODUCTFKProduct2 FOREIGN KEY (Component_Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON DELETE NO ACTION
            ON UPDATE no action
);

-- Product/Machine Junction Tables

CREATE TABLE PRODUCTION_MACHINE_PRODUCT (
    Machine_id int NOT NULL,
    Product_Number int NOT NULL

    CONSTRAINT PRODUCTION_MACHINE_PRODUCTCPK PRIMARY KEY (Machine_id,Product_Number),
    CONSTRAINT PRODUCTION_MACHINE_PRODUCTFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON UPDATE cascade
            ON DELETE no action ,
    CONSTRAINT PRODUCTION_MACHINE_PRODUCTFKProduct FOREIGN KEY (Product_Number)
        REFERENCES PRODUCT (Product_Number)
            ON UPDATE cascade
            ON DELETE no action
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
            ON UPDATE cascade ,
    CONSTRAINT ProductionProcessFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON DELETE NO ACTION
            ON UPDATE cascade
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
            ON UPDATE cascade ,
    CONSTRAINT ProductInstanceFKMachine FOREIGN KEY (Machine_id)
        REFERENCES PRODUCTION_MACHINE (Machine_id)
            ON DELETE NO ACTION
            ON UPDATE cascade
);
