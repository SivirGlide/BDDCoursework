Create OR ALTER PROCEDURE ManagerPaysMore @ManagerPay INT, @EmployeePay INT
AS
    -- Set the Owner Salary
    Update Employee SET Salary = @ManagerPay where (EmployeeID = 1);
    -- Try to set the Employees salary below him higher
    UPDATE EMPLOYEE SET Salary = @EmployeePay Where (EmployeeID = 2);
