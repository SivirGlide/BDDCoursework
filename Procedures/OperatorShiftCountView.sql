CREATE OR ALTER View OperatorShiftCount AS
    SELECT Employee_id, Shift_Date
    From PRODUCTION_MACHINE_OPERATOR

GO
CREATE OR ALTER PROCEDURE OperatorShiftCountProcedure @MonthIncriment INT
    --Specify how many months you want to go back
AS
BEGIN
    -- Get min and max shift counts
    DECLARE @MinShifts INT, @MaxShifts INT

    SELECT @MinShifts = MIN(ShiftCount), @MaxShifts = MAX(ShiftCount)
    FROM (
        SELECT COUNT(Shift_Date) as ShiftCount
        FROM OperatorShiftCount
        WHERE Shift_Date > DATEADD(month, -@MonthIncriment, GETDATE())
        GROUP BY Employee_id
    ) AS ShiftCounts

        -- Return both the min and max employees in a single result set
    SELECT Employee_id, COUNT(Shift_Date) as TotalShifts,
           CASE
               WHEN COUNT(Shift_Date) = @MinShifts THEN 'Lowest Shift Count'
               WHEN COUNT(Shift_Date) = @MaxShifts THEN 'Highest Shift Count'
           END AS Status
    FROM OperatorShiftCount
    WHERE Shift_Date > DATEADD(month, -@MonthIncriment, GETDATE())
    GROUP BY Employee_id
    HAVING COUNT(Shift_Date) = @MinShifts OR COUNT(Shift_Date) = @MaxShifts
    ORDER BY TotalShifts
END;


