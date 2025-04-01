CREATE OR ALTER VIEW vw_EmployeeSalaryBreakdown AS
SELECT
    e.EmployeeID,
    e.DepartmentName,
    e.StartDate,
    e.EndDate,
    e.Salary AS AnnualSalary,
    (e.Salary / 12) AS MonthlySalary,
    (e.Salary / 52) AS WeeklySalary,
    (e.Salary / 4) AS QuarterlySalary,
    (e.Salary / 365) AS DailySalary,
    YEAR(GETDATE()) AS CurrentYear,
    DATEPART(QUARTER, GETDATE()) AS CurrentQuarter,
    MONTH(GETDATE()) AS CurrentMonth,
    DATEPART(WEEK, GETDATE()) AS CurrentWeek,
    CASE
        WHEN e.StartDate <= GETDATE() AND (e.EndDate IS NULL OR e.EndDate >= GETDATE())
        THEN 1 ELSE 0
    END AS IsCurrentlyEmployed
FROM
    EMPLOYEE e
WHERE
    e.DepartmentName IS NOT NULL
