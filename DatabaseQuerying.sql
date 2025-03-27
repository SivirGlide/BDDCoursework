Use LSBU_Manufacturing
GO

-- Question 4A

EXECUTE Improvedshiftcountprocedure 14

    SELECT Employee_id, Shift_Date
    From PRODUCTION_MACHINE_OPERATOR

-- Question 4B

SELECT *
from ProductsMadeByMachines
ORDER BY
Machine_id,Manufacture_Date_Time

-- Question 4C

EXECUTE FindMachinesWithHighMaintenanceRecords 2;

-- Question 4D

--Manager cannot have pay lower than employee.
EXECUTE ManagerPaysMore 99998, 99999;
--Employee Cannot have pay lower than manager.
Execute ManagerPaysMore 100000, 1000000;

-- Question 4E

Execute DepartmentSalaryReport'month', 10, 2025
