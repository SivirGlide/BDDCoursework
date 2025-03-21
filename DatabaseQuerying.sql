Use LSBU_Manufacturing
GO

-- Question 4A

EXECUTE OperatorShiftCountProcedure 1

-- Question 4B

SELECT *
from ProductsMadeByMachines
ORDER BY
    Machine_id,Manufacture_Date_Time

-- Question 4C

EXECUTE FindMachinesWithHighMaintenanceRecords 4;

-- Question 4D

--Manager cannot have pay lower than employee.
EXECUTE ManagerPaysMore 100, 1000;
--Employee Cannot have pay lower than manager.
Execute ManagerPaysMore 1000000, 100000;

-- Question 4E

Execute DepartmentSalaryReport