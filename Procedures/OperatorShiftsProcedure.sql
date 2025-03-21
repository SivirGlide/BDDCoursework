create or alter procedure Improvedshiftcountprocedure @month int
as
    begin

        declare @minimumshifts INT;
        declare @maximumshifts INT;

        set @minimumshifts = (select min(shiftcount)
                              from (select count(Shift_Date) as shiftcount
                                    from AllOperatorShifts
                                    where Shift_Date > dateadd(month, -@month, GETDATE())
                                    group by Employee_id)
                                as popuptable)

        set @maximumshifts = (select max(shiftcount)
                              from (select count(Shift_Date) as shiftcount
                                    from AllOperatorShifts
                                    where Shift_Date > dateadd(month, -@month, GETDATE())
                                    group by Employee_id)
                                as popuptable)

        -- Find employees with minimum shift counts
        SELECT Employee_id, COUNT(Shift_Date) AS shiftcount
        FROM AllOperatorShifts
        WHERE Shift_Date > DATEADD(month, -@month, GETDATE())
        GROUP BY Employee_id
        HAVING COUNT(Shift_Date) = @minimumshifts

        UNION

        -- Find employees with maximum shift counts
        SELECT Employee_id, COUNT(Shift_Date) AS shiftcount
        FROM AllOperatorShifts
        WHERE Shift_Date > DATEADD(month, -@month, GETDATE())
        GROUP BY Employee_id
        HAVING COUNT(Shift_Date) = @maximumshifts
    end;


