CREATE PROCEDURE [sales].[GetOrderChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT o.[OrderID]
        ,o.[CustomerID]
        ,o.[EmployeeID]
        ,o.[OrderDate]
        ,o.[RequiredDate]
        ,o.[ShippedDate]
        ,o.[ShipVia]
        ,o.[Freight]
        ,o.[ShipName]
        ,o.[ShipAddress]
        ,o.[ShipCity]
        ,o.[ShipRegion]
        ,o.[ShipPostalCode]
        ,o.[ShipCountry]
        ,od.[ProductID]
        ,od.[UnitPrice]
        ,od.[Quantity]
        ,od.[Discount]
        ,o.[rowversion]
    FROM [sales].[orders] o
    INNER JOIN [sales].[orderdetails] od ON o.[OrderID] = od.[OrderID]
    WHERE o.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND o.[rowversion] <= CONVERT(ROWVERSION, @endRow)
        OR od.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND od.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END
GO