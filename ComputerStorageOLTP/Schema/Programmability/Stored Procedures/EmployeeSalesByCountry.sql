CREATE PROCEDURE [sales].[EmployeeSalesByCountry]
    @Beginning_Date DATETIME,
    @Ending_Date DATETIME
AS
BEGIN
    SELECT e.[Country]
        ,e.[LastName]
        ,e.[FirstName]
        ,o.[ShippedDate]
        ,o.[OrderID]
        ,(
            SELECT SUM(od.[UnitPrice] * od.[Quantity] * (1 - od.[Discount]))
            FROM [sales].[orderdetails] od
            WHERE od.[OrderID] = o.[OrderID]
        ) AS SaleAmount
    FROM [sales].[employees] e
    INNER JOIN [sales].[orders] o ON e.[EmployeeID] = o.[EmployeeID]
    WHERE o.[ShippedDate] BETWEEN @Beginning_Date AND @Ending_Date
END
GO