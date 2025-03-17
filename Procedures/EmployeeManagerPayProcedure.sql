Create PROCEDURE ManagerPaysMore
AS
    -- Set the Owner Salary
    Update Employee SET Salary = 1000000 where (EmployeeID = 1);
    -- Try to set the Employees salary below him higher
    UPDATE EMPLOYEE SET Salary = 15000000 Where (EmployeeID = 2);