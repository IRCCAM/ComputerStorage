CREATE PROCEDURE [sales].[CustOrdersOrders]
    @CustomerID NCHAR(5)
AS
BEGIN
    SELECT o.[OrderID]
        ,o.[OrderDate]
        ,o.[RequiredDate]
        ,o.[ShippedDate]
    FROM [sales].[orders] o
    WHERE o.[CustomerID] = @CustomerID
    ORDER BY o.[OrderID]
END
GO