CREATE PROCEDURE [sales].[GetCustomerChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT c.[CustomerID]
        ,c.[CompanyName]
        ,c.[ContactName]
        ,c.[ContactTitle]
        ,c.[Address]
        ,c.[City]
        ,c.[Region]
        ,c.[PostalCode]
        ,c.[Country]
        ,c.[Phone]
        ,c.[Fax]
        ,c.[rowversion]
        ,g.[CustomerDesc]
    FROM [sales].[customers] c
    LEFT JOIN [sales].[customerdemographics] g ON c.[CustomerID] = g.[CustomerID]
    WHERE c.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND c.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END
GO