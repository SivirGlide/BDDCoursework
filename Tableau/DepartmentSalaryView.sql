CREATE OR ALTER VIEW vw_EmployeeSalaryBreakdown AS
WITH DateSeries AS (
    -- Generate all months for multiple years (e.g., 2020-2030)
    SELECT DATEFROMPARTS(years.y, months.m, 1) AS ReportMonth
    FROM (SELECT DISTINCT YEAR(StartDate) AS y FROM EMPLOYEE
          UNION SELECT DISTINCT YEAR(EndDate) FROM EMPLOYEE
          UNION SELECT 2020 UNION SELECT 2021 UNION SELECT 2022
          UNION SELECT 2023 UNION SELECT 2024 UNION SELECT 2025
          UNION SELECT 2026 UNION SELECT 2027 UNION SELECT 2028
          UNION SELECT 2029 UNION SELECT 2030) AS years
    CROSS JOIN (VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12)) AS months(m)
), EmployeesPerMonth AS (
    -- Join employees to each month they were active
    SELECT
        d.ReportMonth,
        e.EmployeeID,
        e.DepartmentName,
        e.Salary / 12 AS MonthlySalary,
        CASE
            WHEN e.StartDate <= d.ReportMonth
                AND (e.EndDate IS NULL OR e.EndDate >= d.ReportMonth)
            THEN 1 ELSE 0
        END AS IsActive
    FROM DateSeries d
    CROSS JOIN EMPLOYEE e
)
-- Aggregate salaries for each department per month
SELECT
    ReportMonth,
    YEAR(ReportMonth) AS ReportYear,
    DepartmentName,
    SUM(CASE WHEN IsActive = 1 THEN MonthlySalary ELSE 0 END) AS TotalSalary
FROM EmployeesPerMonth
GROUP BY ReportMonth, DepartmentName;

