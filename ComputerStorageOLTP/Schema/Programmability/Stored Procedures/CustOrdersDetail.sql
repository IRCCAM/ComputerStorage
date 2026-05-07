CREATE PROCEDURE [sales].[CustOrdersDetail]
    @OrderID INT
AS
BEGIN
    SELECT p.[ProductName]
        ,UnitPrice = ROUND(od.[UnitPrice], 2)
        ,od.[Quantity]
        ,Discount = CONVERT(INT, od.[Discount] * 100)
        ,ExtendedPrice = ROUND(CONVERT(MONEY, od.[Quantity] * (1 - od.[Discount]) * od.[UnitPrice]), 2)
    FROM [production].[products] p
    INNER JOIN [sales].[orderdetails] od ON p.[ProductID] = od.[ProductID]
    WHERE od.[OrderID] = @OrderID
END
GO