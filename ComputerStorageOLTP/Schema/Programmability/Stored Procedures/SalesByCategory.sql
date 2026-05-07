CREATE PROCEDURE [sales].[SalesByCategory]
    @CategoryName NVARCHAR(15),
    @OrdYear NVARCHAR(4) = '1998'
AS
BEGIN
    IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998'
    BEGIN
        SELECT @OrdYear = '1998'
    END

    SELECT p.[ProductName]
        ,TotalPurchase = ROUND(SUM(CONVERT(DECIMAL(14,2), od.[Quantity] * (1 - od.[Discount]) * od.[UnitPrice])), 0)
    FROM [sales].[orderdetails] od
    INNER JOIN [sales].[orders] o ON od.[OrderID] = o.[OrderID]
    INNER JOIN [production].[products] p ON od.[ProductID] = p.[ProductID]
    INNER JOIN [production].[categories] c ON p.[CategoryID] = c.[CategoryID]
    WHERE c.[CategoryName] = @CategoryName
        AND SUBSTRING(CONVERT(NVARCHAR(22), o.[OrderDate], 111), 1, 4) = @OrdYear
    GROUP BY p.[ProductName]
    ORDER BY p.[ProductName]
END
GO