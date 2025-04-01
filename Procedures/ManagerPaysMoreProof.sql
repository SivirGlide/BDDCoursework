CREATE OR ALTER PROCEDURE ManagerPaysMore
    @ManagerPay decimal(19,2),
    @EmployeePay decimal(19,2)
AS
BEGIN

            UPDATE EMPLOYEE SET Salary = @EmployeePay Where (EmployeeID = 6);
            Update EMPLOYEE SET Salary = @ManagerPay where (EmployeeID = 1);

END;