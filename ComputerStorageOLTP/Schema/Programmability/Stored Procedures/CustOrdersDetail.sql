CREATE PROCEDURE [sales].[CustOrdersDetail]
    @OrderID INT
AS
BEGIN
    SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
    FROM [production].[products] P, [sales].[orderdetails] Od
    WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID
END
GO