/*
Produce all the Records from Maintenance and special maintenance
Where COUNT MachineID > 2

Should be FULL JOIN because a machine may have only one or the other type of service and we need to display all of them
*/

CREATE VIEW FrequentlyServicedMachinesView AS
SELECT
    pm.Machine_id,
    pm.Machine_Type,
    pm.Department_name,
    pm.Maintenance_Status,
    (SELECT COUNT(*) FROM SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) +
    (SELECT COUNT(*) FROM SPECIAL_SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) AS TotalServiceCount
FROM
    PRODUCTION_MACHINE pm
WHERE
    (SELECT COUNT(*) FROM SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) +
    (SELECT COUNT(*) FROM SPECIAL_SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) >= 4;
