Use LSBU_Manufacturing
GO

-- Question 4A

EXECUTE Improvedshiftcountprocedure 1

-- Question 4B

SELECT *
from ProductsMadeByMachines
ORDER BY
Machine_id,Manufacture_Date_Time

-- Question 4C

EXECUTE FindMachinesWithHighMaintenanceRecords 6;

-- Question 4D

--Manager cannot have pay lower than employee.
EXECUTE ManagerPaysMore 100, 100000;
--Employee Cannot have pay lower than manager.
Execute ManagerPaysMore 1000000, 10000000;

-- Question 4E

Execute DepartmentSalaryReport'Month', 3, 2025