CREATE OR ALTER PROCEDURE DepartmentSalaryReport
    @PeriodType VARCHAR(10),  -- 'Week', 'Month', or 'Quarter'
    @PeriodNumber INT,        -- Week number (1-52), Month (1-12), or Quarter (1-4)
    @Year INT
AS
BEGIN
    IF @PeriodType NOT IN ('Week', 'Month', 'Quarter')
    BEGIN
        RAISERROR('Must choose a valid time frame', 16, 1)
        RETURN
    END
    ELSE IF @PeriodType = 'Week' AND @PeriodNumber BETWEEN 1 AND 52
    BEGIN
        -- Find first day of the year
        DECLARE @FirstDayOfYear DATE = DATEFROMPARTS(@Year, 1, 1)

        -- Get day of week (1 = Sunday, 2 = Monday, etc. with default DATEFIRST=7)
        DECLARE @DayOfWeek INT = DATEPART(WEEKDAY, @FirstDayOfYear)

        -- Adjust to make Monday = 1, Sunday = 7
        SET @DayOfWeek = (@DayOfWeek + 5) % 7 + 1

        -- Calculate days to add to get to the first Monday
        DECLARE @DaysToFirstMonday INT = (9 - @DayOfWeek) % 7

        -- Calculate start of the requested week (Monday)
        DECLARE @StartOfWeek DATE = DATEADD(DAY, @DaysToFirstMonday + ((@PeriodNumber - 1) * 7), @FirstDayOfYear)

        -- Calculate end of the week (Sunday)
        DECLARE @EndOfWeek DATE = DATEADD(DAY, 6, @StartOfWeek);

        WITH DepartmentTotals AS (
            SELECT
                d.DepartmentName,
                SUM(e.WeeklySalary) AS WeeklySalary
            FROM
                vw_EmployeeSalaryPeriods e
            JOIN
                vw_Departments d ON e.DepartmentName = d.DepartmentName
            WHERE
                (e.StartDate <= @EndOfWeek) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfWeek)
            GROUP BY
                d.DepartmentName
        )
        SELECT
            e.EmployeeID,
            e.DepartmentName,
            e.WeeklySalary AS EmployeeWeeklySalary,
            dt.WeeklySalary,
            FORMAT(e.WeeklySalary / dt.WeeklySalary, 'P') AS PercentOfDeptTotal
        FROM
            vw_EmployeeSalaryPeriods e
        JOIN
            DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
        WHERE
            (e.StartDate <= @EndOfWeek) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfWeek)
        ORDER BY
            e.DepartmentName, e.EmployeeID;

        RETURN
    END
    ELSE IF @PeriodType = 'Month' AND @PeriodNumber BETWEEN 1 AND 12
    BEGIN
        DECLARE @StartOfMonth DATE = DATEFROMPARTS(@Year, @PeriodNumber, 1);
        DECLARE @EndOfMonth DATE = DATEADD(DAY, -1, DATEADD(MONTH, 1, @StartOfMonth));

        -- Calculate department totals using a CTE
        WITH DepartmentTotals AS (
            SELECT
                d.DepartmentName,
                SUM(e.MonthlySalary) AS DepartmentMonthlySalary
            FROM
                vw_EmployeeSalaryPeriods e
            JOIN
                vw_Departments d ON e.DepartmentName = d.DepartmentName
            WHERE
                (e.StartDate <= @EndOfMonth) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfMonth)
            GROUP BY
                d.DepartmentName
        )
        -- Join with employee records to show both individual and department data
        SELECT
            e.EmployeeID,
            e.DepartmentName,
            e.MonthlySalary AS EmployeeMonthlySalary,
            dt.DepartmentMonthlySalary,
            FORMAT(e.MonthlySalary / dt.DepartmentMonthlySalary, 'P') AS PercentOfDeptTotal
        FROM
            vw_EmployeeSalaryPeriods e
        JOIN
            DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
        WHERE
            (e.StartDate <= @EndOfMonth) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfMonth)
        ORDER BY
            e.DepartmentName, e.EmployeeID;

        RETURN
    END
    ELSE IF @PeriodType = 'Quarter' AND @PeriodNumber BETWEEN 1 AND 4
    BEGIN
        DECLARE @StartOfQuarter DATE = DATEFROMPARTS(@Year, (3*@PeriodNumber)-2, 1)
        DECLARE @EndOfQuarter DATE = DATEADD(DAY, -1, DATEADD(MONTH, 3, @StartOfQuarter));

        WITH DepartmentTotals AS (
            SELECT
                d.DepartmentName,
                SUM(e.QuarterlySalary) AS QuarterlySalary
            FROM
                vw_EmployeeSalaryPeriods e
            JOIN
                vw_Departments d ON e.DepartmentName = d.DepartmentName
            WHERE
                (e.StartDate <= @EndOfQuarter) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfQuarter)
            GROUP BY
                d.DepartmentName
        )
        SELECT
            e.EmployeeID,
            e.DepartmentName,
            e.QuarterlySalary AS EmployeeQuarterlySalary,
            dt.QuarterlySalary,
            FORMAT(e.QuarterlySalary / dt.QuarterlySalary, 'P') AS PercentOfDeptTotal
        FROM
            vw_EmployeeSalaryPeriods e
        JOIN
            DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
        WHERE
            (e.StartDate <= @EndOfQuarter) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfQuarter)
        ORDER BY
            e.DepartmentName, e.EmployeeID;

        RETURN
    END
    ELSE
    BEGIN
        RAISERROR('Must Choose a valid Week, Month or Quarter period', 16, 1)
    END
END;
GO