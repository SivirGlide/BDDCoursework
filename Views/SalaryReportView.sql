CREATE VIEW vw_EmployeeBasic AS
SELECT
    EmployeeID,
    DepartmentName,
    Salary,
    MonthlySalary,
    StartDate,
    EndDate
FROM
    EMPLOYEE;
GO

-- 2. Active departments view
CREATE VIEW vw_Departments AS
SELECT
    DepartmentName
FROM
    DEPARTMENT;
GO

-- 3. Create a view for calculating employee salary periods
CREATE VIEW vw_EmployeeSalaryPeriods AS
SELECT
    e.EmployeeID,
    e.DepartmentName,
    e.Salary,
    e.MonthlySalary,
    (e.Salary / 52) AS WeeklySalary,
    (e.Salary / 4) AS QuarterlySalary,
    e.StartDate,
    e.EndDate
FROM
    vw_EmployeeBasic e;