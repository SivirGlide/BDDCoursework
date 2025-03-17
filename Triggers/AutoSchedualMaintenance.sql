USE LSBU_Manufacturing
GO

CREATE TRIGGER trg_ScheduleNextMaintenance
ON PRODUCTION_MACHINE
AFTER UPDATE
AS
BEGIN
    -- Only proceed if Last_Maintenance_Date was updated AND the machine is not new
    IF UPDATE(Last_Maintenance_Date)
    BEGIN
        -- Update Next_Scheduled_Maintenance to be 72 hours after Last_Maintenance_Date
        UPDATE pm
        SET Next_Scheduled_Maintenance = DATEADD(HOUR, 72, i.Last_Maintenance_Date)
        FROM PRODUCTION_MACHINE pm
        JOIN inserted i ON pm.Machine_id = i.Machine_id
        WHERE i.Last_Maintenance_Date IS NOT NULL AND pm.Is_New = 0;
    END
END;

--Test

INSERT INTO PRODUCTION_MACHINE (Department_name, Machine_Type, Purchase_Date, Is_Automatic, Maintenance_Status,Is_New)
VALUES ('Engineering', 'Drill Press', '2023-01-15', 1, 'Operational',0);

UPDATE PRODUCTION_MACHINE
SET Last_Maintenance_Date = GETDATE()
WHERE Machine_id = 3;

Select * from PRODUCTION_MACHINE
