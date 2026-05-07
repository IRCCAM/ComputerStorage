CREATE PROCEDURE [production].[TenMostExpensiveProducts]
AS
BEGIN
    SET ROWCOUNT 10
    
    SELECT p.[ProductName] AS TenMostExpensiveProducts
        ,p.[UnitPrice]
    FROM [production].[products] p
    ORDER BY p.[UnitPrice] DESC
    
    SET ROWCOUNT 0
END
GO