-- Master setup script to initialize the entire database

PRINT 'Starting database setup...';

-- Create the database
PRINT 'Creating database...';
:r CreateDB.sql
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
:r Triggers/AutoSchedualMaintenance.sql
GO

:r Triggers/ManagerEmployeePay.sql
GO

:r Triggers/MinimumEmployeesInDepartment.sql
GO

-- Create views
PRINT 'Creating views...';
:r schema/05_views.sql
GO

-- Create stored procedures
PRINT 'Creating stored procedures...';
:r Procedures/EmployeeManagerPayProcedure.sql
GO

-- Optional: Load test data
PRINT 'Loading test data...';
:r data/DataInsertion.sql
GO

PRINT 'Database setup complete!';