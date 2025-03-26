CREATE OR ALTER PROCEDURE ManagerPaysMore
    @ManagerPay decimal(19,2),
    @EmployeePay decimal(19,2)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Always update in the correct order based on values
        -- If manager pay is higher, update employee first, then manager
        -- If employee pay is higher, update manager first, then employee
        IF @ManagerPay >= @EmployeePay
        BEGIN
            UPDATE EMPLOYEE SET Salary = @EmployeePay Where (EmployeeID = 6);
            Update EMPLOYEE SET Salary = @ManagerPay where (EmployeeID = 1);
        END
        ELSE
        BEGIN
            Update EMPLOYEE SET Salary = @ManagerPay where (EmployeeID = 1);
            UPDATE EMPLOYEE SET Salary = @EmployeePay Where (EmployeeID = 6);
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;