Create trigger DepartmentEmployeeCountRule
    on EMPLOYEE
    after delete , update -- when should this fire
    as
    begin

        create table #affectedDepartments( -- # in the table name removes persistence
            Departmentname varchar(255),
            employeecount int
        );

    INSERT INTO #affectedDepartments (DepartmentName, EmployeeCount)
    SELECT e.DepartmentName,
           COUNT(e.EmployeeID) -
           (SELECT COUNT(*) FROM deleted d WHERE d.DepartmentName = e.DepartmentName) +
           (SELECT COUNT(*) FROM inserted i WHERE i.DepartmentName = e.DepartmentName)
    FROM EMPLOYEE e
    WHERE e.DepartmentName IN (
        SELECT DISTINCT d.DepartmentName FROM deleted d WHERE d.DepartmentName IS NOT NULL
        UNION
        SELECT DISTINCT i.DepartmentName FROM inserted i WHERE i.DepartmentName IS NOT NULL
    )
    GROUP BY e.DepartmentName;

       if exists ( select 1 from #affectedDepartments where employeecount < 3)
        begin
            ROLLBACK TRANSACTION
            raiserror ('CANNOT DELETE EMPLOYEES, WOULD VIOLATE MINIMUM OF 3 EMPLOYEES PER DEPARTMENT BUSINESS RULE',16,1)
        end
    end
