CREATE OR ALTER VIEW QuantityOfProducts AS
    SELECT
        p.Description,
        COUNT(pi.Product_Number) AS QuantityProduced,
        SUM(pp.Sale_Price) AS TotalRevenue,
        SUM(pp.Sale_Price - p.Production_cost) AS TotalProfit
    FROM PRODUCT_INSTANCE pi
    INNER JOIN PRODUCT p ON pi.Product_Number = p.Product_Number
    INNER JOIN PRODUCT_PRICE pp ON p.Production_cost = pp.Production_Cost
    GROUP BY p.Description;