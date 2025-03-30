-- Master setup script to initialize the entire database

--Drop the original database if it exists. (mainly for me to reset the db)
DROP DATABASE LSBU_Manufacturing;

PRINT 'Starting database setup...';
-- Create the database

PRINT 'Creating database...';
GO
:r Createdb.sql
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
:r Views/MachinesToMakeProductView.sql
GO
:r Views/OperatorShiftsView.sql
GO
:r Views/SalaryReportView.sql
GO
-- Create stored procedures

PRINT 'Creating stored procedures...';
GO
:r Procedures/ManagerPaysMoreProof.sql
GO
:r Procedures/OperatorShiftsProcedure.sql
GO
:r Procedures/DepartmentSalaryReport.sql
GO

-- Test data
PRINT 'Loading test data...';
GO
:r data/ClaudeTestData.sql

PRINT 'Database setup complete!';

