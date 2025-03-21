-- Minimum 3 employees per department Trigger

CREATE TRIGGER trg_MinimumEmployeesPerDepartment
ON EMPLOYEE
AFTER UPDATE, DELETE
AS
BEGIN
    -- Get affected departments from the current operation
    DECLARE @AffectedDepartments TABLE (DepartmentName VARCHAR(255));

    -- For updates, both old and new departments are affected
    IF EXISTS (SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO @AffectedDepartments
        SELECT DepartmentName FROM inserted WHERE DepartmentName IS NOT NULL
        UNION
        SELECT DepartmentName FROM deleted WHERE DepartmentName IS NOT NULL;
    END
    ELSE
    BEGIN
        -- For deletes, only the departments employees were removed from
        INSERT INTO @AffectedDepartments
        SELECT DepartmentName FROM deleted WHERE DepartmentName IS NOT NULL;
    END

    -- Check if any affected department now has fewer than 3 employees
    DECLARE @InvalidDepartments TABLE (DepartmentName VARCHAR(255));

    INSERT INTO @InvalidDepartments
    SELECT d.DepartmentName
    FROM @AffectedDepartments a
    JOIN DEPARTMENT d ON a.DepartmentName = d.DepartmentName
    LEFT JOIN EMPLOYEE e ON d.DepartmentName = e.DepartmentName
    GROUP BY d.DepartmentName
    HAVING COUNT(e.EmployeeID) < 3;

    -- If any affected departments violate the rule, roll back
    IF EXISTS (SELECT 1 FROM @InvalidDepartments)
    BEGIN
        DECLARE @DeptList VARCHAR(MAX) = '';

        SELECT @DeptList = @DeptList + DepartmentName + ', '
        FROM @InvalidDepartments;

        SET @DeptList = LEFT(@DeptList, LEN(@DeptList) - 1);

        ROLLBACK TRANSACTION;
        RAISERROR('Operation would result in fewer than 3 employees in department(s): %s. Transaction rolled back.', 16, 1, @DeptList);
    END
END;