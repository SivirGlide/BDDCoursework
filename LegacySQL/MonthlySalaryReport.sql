Create procedure DepartmentSalaryReport
    @PeriodType VARCHAR(10),  -- 'Week', 'Month', or 'Quarter'
    @PeriodNumber INT,        -- Week number (1-52), Month (1-12), or Quarter (1-4)
    @Year INT
as
    begin
        if @PeriodType not in ('Week', 'Month', 'Quarter')
            begin
                RAISERROR('Must choose a valid time frame',16,1)
                return
            end
        else if @PeriodType = 'Week' and @PeriodNumber between 1 and 52
            begin
                -- Find first day of the year
                DECLARE @FirstDayOfYear DATE = DATEFROMPARTS(@Year, 1, 1)

                -- Get day of week (1 = Sunday, 2 = Monday, etc. with default DATEFIRST=7)
                DECLARE @DayOfWeek INT = DATEPART(WEEKDAY, @FirstDayOfYear)

                -- Adjust to make Monday = 1, Sunday = 7
                SET @DayOfWeek = (@DayOfWeek + 5) % 7 + 1

                -- Calculate days to add to get to the first Monday
                -- If Jan 1 is Monday, add 0; if Tuesday, add 6; if Wednesday, add 5; etc.
                DECLARE @DaysToFirstMonday INT = (9 - @DayOfWeek) % 7

                -- Calculate start of the requested week (Monday)
                DECLARE @StartOfWeek DATE = DATEADD(DAY, @DaysToFirstMonday + ((@PeriodNumber - 1) * 7), @FirstDayOfYear)

                -- Calculate end of the week (Sunday)
                DECLARE @EndOfWeek DATE = DATEADD(DAY, 6, @StartOfWeek);

                WITH DepartmentTotals AS (
                select d.DepartmentName, (sum(e.Salary)/52) as WeeklySalary
                from EMPLOYEE e
                join department d on e.DepartmentName = d.DepartmentName
                where (e.StartDate <= @EndOfWeek) and (e.EndDate is null or e.EndDate >= @StartOfWeek)
                group by d.DepartmentName)

                                SELECT
                    e.EmployeeID,
                    e.DepartmentName,
                    (e.Salary/52) AS EmployeeWeeklySalary,
                    dt.WeeklySalary,
                    FORMAT((e.Salary/52) / dt.WeeklySalary, 'P') AS PercentOfDeptTotal
                FROM
                    EMPLOYEE e
                JOIN
                    DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
                WHERE
                    (e.StartDate <= @EndOfWeek) AND (e.EndDate IS NULL OR e.EndDate >= @StartOfWeek)
                ORDER BY
                    e.DepartmentName, e.EmployeeID;


                return
            end
        else if @PeriodType = 'Month' and @PeriodNumber between 1 and 12
            begin
                --write month code

                declare @startofmonth date = datefromparts(@year, @PeriodNumber, 1);
                declare @endofmonth date = dateadd(day, -1, dateadd(month, 1, @startofmonth));

                -- Calculate department totals using a CTE
                WITH DepartmentTotals AS (
                    SELECT
                        d.DepartmentName,
                        SUM(e.MonthlySalary) AS DepartmentMonthlySalary
                    FROM
                        EMPLOYEE e
                    JOIN
                        DEPARTMENT d ON e.DepartmentName = d.DepartmentName
                    WHERE
                        (e.StartDate <= @endofmonth) AND (e.EndDate IS NULL OR e.EndDate >= @startofmonth)
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
                    EMPLOYEE e
                JOIN
                    DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
                WHERE
                    (e.StartDate <= @endofmonth) AND (e.EndDate IS NULL OR e.EndDate >= @startofmonth)
                ORDER BY
                    e.DepartmentName, e.EmployeeID;

                return
            end
        else if @PeriodType = 'Quarter' and @PeriodNumber between 1 and 4
            begin
                --write quarter code

                declare @startofquarter date = datefromparts(@year, (3*@PeriodNumber)-2, 1)
                declare @endofquarter date = dateadd(day, -1, dateadd(month, 3, @startofquarter));

                WITH DepartmentTotals AS (
                select d.DepartmentName, (sum(e.Salary)/4) as QuarterlySalary
                from EMPLOYEE e
                join department d on e.DepartmentName = d.DepartmentName
                where (e.StartDate <= @endofquarter) and (e.EndDate is null or e.EndDate >= @startofquarter)
                group by d.DepartmentName)

                                SELECT
                    e.EmployeeID,
                    e.DepartmentName,
                    (e.Salary/4) AS EmployeeQuarterlySalary,
                    dt.QuarterlySalary,
                    FORMAT((e.Salary/4) / dt.QuarterlySalary, 'P') AS PercentOfDeptTotal
                FROM
                    EMPLOYEE e
                JOIN
                    DepartmentTotals dt ON e.DepartmentName = dt.DepartmentName
                WHERE
                    (e.StartDate <= @endofquarter) AND (e.EndDate IS NULL OR e.EndDate >= @startofquarter)
                ORDER BY
                    e.DepartmentName, e.EmployeeID;

                return
            end

        else
        begin
            Raiserror('Must Choose a valid Week, Month or Quarter period',16,1)
        end
    end;
