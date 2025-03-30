
Create view ProductsMadeByMachines as
SELECT
    PM.Machine_id,
    PM.Machine_Type,
    P.Product_Number,
    P.Description AS ProductName,
    PI.Manufacture_Date_Time
FROM
    PRODUCTION_MACHINE PM
INNER JOIN
    PRODUCT_INSTANCE PI ON PM.Machine_id = PI.Machine_id
INNER JOIN
    PRODUCT P ON PI.Product_Number = P.Product_Number
WHERE
    -- Filter for only the specific parts we're looking for
    P.Description IN ('Flywheel', 'Clutch plate', 'Pressure plate')
    -- Filter for products manufactured in the last 3 days
    AND PI.Manufacture_Date_Time >= DATEADD(day, -3, GETDATE())