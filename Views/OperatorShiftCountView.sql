-- Write a query to find the operators who have worked the highest and lowest
-- number of shifts in the last month.

CREATE View OperatorShiftCountView AS
    SELECT op.EmployeeID,
    (SELECT COUNT(*) FROM PRODUCTION_MACHINE_OPERATOR where Employee_id = op.EmployeeID and Shift_Date > DATEADD(month, -1, GETDATE())) as ShiftCount
    FROM OPERATOR as op

SELECT * from OperatorShiftCountView