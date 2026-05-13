CREATE PROCEDURE [sales].[CustOrdersOrders]
    @CustomerID NCHAR(5)
AS
BEGIN
    SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
    FROM [sales].[orders]
    WHERE [CustomerID] = @CustomerID
    ORDER BY [OrderID]
END
GO