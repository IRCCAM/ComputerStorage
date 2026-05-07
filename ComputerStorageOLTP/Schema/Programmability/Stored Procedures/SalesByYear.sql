CREATE PROCEDURE [sales].[SalesByYear]
    @Beginning_Date DATETIME,
    @Ending_Date DATETIME
AS
BEGIN
    SELECT o.[ShippedDate]
        ,o.[OrderID]
        ,(
            SELECT SUM(od.[UnitPrice] * od.[Quantity] * (1 - od.[Discount]))
            FROM [sales].[orderdetails] od
            WHERE od.[OrderID] = o.[OrderID]
        ) AS Subtotal
        ,DATENAME(yy, o.[ShippedDate]) AS Year
    FROM [sales].[orders] o
    WHERE o.[ShippedDate] BETWEEN @Beginning_Date AND @Ending_Date
END
GO