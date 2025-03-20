CREATE OR ALTER VIEW FrequentlyServicedMachinesView AS
SELECT
    pm.Machine_id,
    pm.Machine_Type,
    pm.Department_name,
    pm.Maintenance_Status,
    (SELECT COUNT(*) FROM SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) +
    (SELECT COUNT(*) FROM SPECIAL_SERVICE_HISTORY WHERE Machine_ID = pm.Machine_id) AS TotalServiceCount
FROM
    PRODUCTION_MACHINE pm;

GO

Create PROCEDURE FindMachinesWithHighMaintenanceRecords @AmountOfRecords INT
AS
    Begin
        Select *
        from FrequentlyServicedMachinesView v
        WHERE
        (SELECT COUNT(*) FROM SERVICE_HISTORY WHERE Machine_ID = v.Machine_id) +
        (SELECT COUNT(*) FROM SPECIAL_SERVICE_HISTORY WHERE Machine_ID = v.Machine_id) >= @AmountOfRecords;
    end
