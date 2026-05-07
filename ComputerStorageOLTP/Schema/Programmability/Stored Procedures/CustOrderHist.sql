CREATE PROCEDURE [sales].[CustOrderHist]
    @CustomerID NCHAR(5)
AS
BEGIN
    SELECT p.[ProductName], Total = SUM(od.[Quantity])
    FROM [production].[products] p
    INNER JOIN [sales].[orderdetails] od ON p.[ProductID] = od.[ProductID]
    INNER JOIN [sales].[orders] o ON od.[OrderID] = o.[OrderID]
    INNER JOIN [sales].[customers] c ON o.[CustomerID] = c.[CustomerID]
    WHERE c.[CustomerID] = @CustomerID
    GROUP BY p.[ProductName]
END
GO