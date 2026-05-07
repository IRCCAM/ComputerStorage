CREATE PROCEDURE [sales].[GetEmployeeChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow BIGINT
)
AS
BEGIN
    SELECT e.[EmployeeID]
        ,e.[LastName]
        ,e.[FirstName]
        ,e.[Title]
        ,e.[TitleOfCourtesy]
        ,e.[BirthDate]
        ,e.[HireDate]
        ,e.[Address]
        ,e.[City]
        ,e.[Region]
        ,e.[PostalCode]
        ,e.[Country]
        ,e.[HomePhone]
        ,e.[Extension]
        ,e.[Photo]
        ,e.[Notes]
        ,e.[ReportsTo]
        ,e.[PhotoPath]
        ,t.[TerritoryDescription]
        ,r.[RegionDescription]
    FROM [sales].[employees] e
    INNER JOIN [sales].[employeeterritories] et ON e.[EmployeeID] = et.[EmployeeID]
    INNER JOIN [production].[territories] t ON et.[TerritoryID] = t.[TerritoryID]
    INNER JOIN [production].[region] r ON t.[RegionID] = r.[RegionID]
    WHERE e.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND e.[rowversion] <= CONVERT(ROWVERSION, @endRow)
        OR et.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND et.[rowversion] <= CONVERT(ROWVERSION, @endRow)
        OR t.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND t.[rowversion] <= CONVERT(ROWVERSION, @endRow)
        OR r.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND r.[rowversion] <= CONVERT(ROWVERSION, @endRow)
END
GO