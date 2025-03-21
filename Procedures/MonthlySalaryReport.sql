CREATE OR ALTER PROCEDURE DepartmentSalaryReport
    @PeriodType VARCHAR(10) = 'MONTH', -- Valid values: 'WEEK', 'MONTH', 'QUARTER'
    @PeriodValue INT = NULL,           -- Week number (1-52), Month number (1-12), or Quarter (1-4)
    @Year INT = NULL                    -- Year to report on
AS
BEGIN
    SET NOCOUNT ON;

    -- Set default values if not provided
    IF @Year IS NULL
        SET @Year = YEAR(GETDATE());

    IF @PeriodValue IS NULL
    BEGIN
        IF @PeriodType = 'WEEK'
            SET @PeriodValue = DATEPART(WEEK, GETDATE());
        ELSE IF @PeriodType = 'MONTH'
            SET @PeriodValue = MONTH(GETDATE());
        ELSE IF @PeriodType = 'QUARTER'
            SET @PeriodValue = DATEPART(QUARTER, GETDATE());
    END

    -- Validate input parameters
    IF @PeriodType NOT IN ('WEEK', 'MONTH', 'QUARTER')
    BEGIN
        RAISERROR('Invalid period type. Valid values are WEEK, MONTH, or QUARTER.', 16, 1);
        RETURN;
    END

    IF @PeriodType = 'WEEK' AND (@PeriodValue < 1 OR @PeriodValue > 53)
    BEGIN
        RAISERROR('Week number must be between 1 and 53.', 16, 1);
        RETURN;
    END

    IF @PeriodType = 'MONTH' AND (@PeriodValue < 1 OR @PeriodValue > 12)
    BEGIN
        RAISERROR('Month number must be between 1 and 12.', 16, 1);
        RETURN;
    END

    IF @PeriodType = 'QUARTER' AND (@PeriodValue < 1 OR @PeriodValue > 4)
    BEGIN
        RAISERROR('Quarter number must be between 1 and 4.', 16, 1);
        RETURN;
    END

    -- Calculate start and end dates based on period type
    DECLARE @StartDate DATE;
    DECLARE @EndDate DATE;

    IF @PeriodType = 'WEEK'
    BEGIN
        SET @StartDate = DATEADD(WEEK, @PeriodValue - 1, DATEADD(YEAR, @Year - 1900, 0));
        SET @StartDate = DATEADD(DAY, 1 - DATEPART(WEEKDAY, @StartDate), @StartDate); -- Adjust to start of week
        SET @EndDate = DATEADD(DAY, 6, @StartDate); -- End of week (7 days later)
    END
    ELSE IF @PeriodType = 'MONTH'
    BEGIN
        SET @StartDate = DATEFROMPARTS(@Year, @PeriodValue, 1); -- First day of month
        SET @EndDate = EOMONTH(@StartDate); -- Last day of month
    END
    ELSE IF @PeriodType = 'QUARTER'
    BEGIN
        SET @StartDate = DATEFROMPARTS(@Year, ((@PeriodValue - 1) * 3) + 1, 1); -- First day of quarter
        SET @EndDate = EOMONTH(DATEADD(MONTH, 2, @StartDate)); -- Last day of quarter
    END

    -- Generate report title
    DECLARE @ReportTitle NVARCHAR(100);

    IF @PeriodType = 'WEEK'
        SET @ReportTitle = CONCAT('Weekly Salary Report - Week ', @PeriodValue, ', ', @Year,
                                  ' (', FORMAT(@StartDate, 'MMM d'), ' - ', FORMAT(@EndDate, 'MMM d'), ')');
    ELSE IF @PeriodType = 'MONTH'
        SET @ReportTitle = CONCAT('Monthly Salary Report - ', FORMAT(@StartDate, 'MMMM yyyy'));
    ELSE IF @PeriodType = 'QUARTER'
        SET @ReportTitle = CONCAT('Quarterly Salary Report - Q', @PeriodValue, ' ', @Year,
                                  ' (', FORMAT(@StartDate, 'MMM'), ' - ', FORMAT(@EndDate, 'MMM'), ')');

    -- Print report header
    PRINT @ReportTitle;
    PRINT REPLICATE('-', LEN(@ReportTitle));
    PRINT '';

    -- Create a temporary table to store report data
    CREATE TABLE #SalaryReport (
        DepartmentName VARCHAR(255),
        EmployeeID INT,
        ManagerID INT,
        IsManager BIT,
        ManagerName VARCHAR(100),
        Salary NUMERIC(19,2),
        ReportTotal BIT DEFAULT 0 -- Flag to identify total rows
    );

    -- Insert employee data
    INSERT INTO #SalaryReport (DepartmentName, EmployeeID, ManagerID, IsManager, Salary)
    SELECT
        ISNULL(e.DepartmentName, 'Unassigned'),
        e.EmployeeID,
        e.ManagerID,
        CASE WHEN EXISTS (SELECT 1 FROM EMPLOYEE WHERE ManagerID = e.EmployeeID) THEN 1 ELSE 0 END,
        e.Salary
    FROM
        EMPLOYEE e
    ORDER BY
        ISNULL(e.DepartmentName, 'Unassigned'),
        e.EmployeeID;

    -- Update manager names
    UPDATE r
    SET ManagerName = CONCAT('Employee ', m.EmployeeID)
    FROM #SalaryReport r
    JOIN EMPLOYEE m ON r.ManagerID = m.EmployeeID;

    -- Calculate department totals and insert as summary rows
    INSERT INTO #SalaryReport (DepartmentName, Salary, ReportTotal)
    SELECT
        DepartmentName,
        SUM(Salary),
        1
    FROM
        #SalaryReport
    GROUP BY
        DepartmentName;

    -- Calculate company total and insert as final summary row
    INSERT INTO #SalaryReport (DepartmentName, Salary, ReportTotal)
    SELECT
        'COMPANY TOTAL',
        SUM(Salary),
        1
    FROM
        #SalaryReport
    WHERE
        ReportTotal = 0;

    -- Output the report data
    SELECT
        DepartmentName,
        CASE WHEN ReportTotal = 1 THEN NULL ELSE EmployeeID END AS EmployeeID,
        CASE WHEN ReportTotal = 1 THEN NULL ELSE ManagerID END AS ManagerID,
        CASE WHEN ReportTotal = 1 THEN NULL ELSE IsManager END AS IsManager,
        CASE WHEN ReportTotal = 1 THEN NULL ELSE ManagerName END AS ManagerName,
        Salary,
        CASE
            WHEN DepartmentName = 'COMPANY TOTAL' THEN 'COMPANY TOTAL'
            WHEN ReportTotal = 1 THEN 'DEPARTMENT TOTAL'
            ELSE NULL
        END AS ReportType
    FROM
        #SalaryReport
    ORDER BY
        CASE WHEN DepartmentName = 'COMPANY TOTAL' THEN 2 ELSE 1 END,
        DepartmentName,
        ReportTotal DESC,
        EmployeeID;

    -- Clean up
    DROP TABLE #SalaryReport;

    -- Return period information for reference
    SELECT
        @PeriodType AS PeriodType,
        @PeriodValue AS PeriodValue,
        @Year AS ReportYear,
        @StartDate AS StartDate,
        @EndDate AS EndDate,
        @ReportTitle AS ReportTitle;
END;