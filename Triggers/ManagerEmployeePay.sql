Create TRIGGER trg_EmployeeSalaryCheck
ON EMPLOYEE
AFTER INSERT, UPDATE
AS
BEGIN
    -- Scenario 1: Check if any updated employee's salary exceeds their manager's
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN EMPLOYEE m ON i.ManagerID = m.EmployeeID
        WHERE i.Salary > m.Salary
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Employees cannot earn more than or equal to their manager. Transaction rolled back.', 16, 1);
        RETURN;
    END

    -- Scenario 2: Check if any updated manager's salary is now less than their employees'
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN EMPLOYEE e ON e.ManagerID = i.EmployeeID
        WHERE e.Salary > i.Salary
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('Managers cannot earn less than or equal to their employees. Transaction rolled back.', 16, 1);
        RETURN;
    END
END;