-- Master setup script to initialize the entire database

Drop database LSBU_Manufacturing

PRINT 'Starting database setup...';

-- Create the database
PRINT 'Creating database...';
CREATE DATABASE LSBU_Manufacturing;
GO

-- Switch to the created database
USE LSBU_Manufacturing;
GO

-- Create tables
PRINT 'Creating tables...';
:r Database-Creator.sql
GO

-- Create triggers
PRINT 'Creating triggers...';
GO
:r Triggers/AutoSchedualMaintenance.sql
GO

:r Triggers/ManagerEmployeePay.sql
GO

:r Triggers/MinimumEmployeesInDepartment.sql
GO

-- Create views
PRINT 'Creating views...';
GO
:r Views/MaintenanceIssueView.sql
GO

-- Create stored procedures
PRINT 'Creating stored procedures...';
GO
:r Procedures/EmployeeManagerPayProcedure.sql
GO

:r Procedures/OperatorShiftCountView.sql

-- Optional: Load test data
PRINT 'Loading test data...';
GO
-- :r data/DataInsertion.sql
-- :r Views/testdata.sql
GO

PRINT 'Database setup complete!';

