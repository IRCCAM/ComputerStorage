CREATE PROCEDURE [dbo].[DW_MergeDimEmployee]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion de staging
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM [staging].[Employees];
    
    -- MERGE de empleados
    MERGE INTO [dim].[DimEmployee] AS target
    USING (
        SELECT 
            EmployeeID AS EmployeeID_NK,
            LastName,
            FirstName,
            FirstName + ' ' + LastName AS FullName,
            Title,
            TitleOfCourtesy,
            CAST(BirthDate AS DATE) AS BirthDate,
            CAST(HireDate AS DATE) AS HireDate,
            Address,
            City,
            Region,
            PostalCode,
            Country,
            HomePhone,
            Extension,
            Notes,
            ReportsTo AS ReportsTo_NK,
            NULL AS ManagerName,
            NULL AS HierarchyLevel,
            DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age,
            DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfExperience,
            1 AS IsActive,
            GETDATE() AS CreatedDate,
            GETDATE() AS UpdatedDate,
            ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY ModifiedDate DESC) AS rn
        FROM [staging].[Employees]
        WHERE RowVersion > @LastRowVersion
    ) AS source
    ON target.EmployeeID_NK = source.EmployeeID_NK AND source.rn = 1
    
    WHEN MATCHED AND target.UpdatedDate < source.UpdatedDate THEN
        UPDATE SET
            LastName = source.LastName,
            FirstName = source.FirstName,
            FullName = source.FullName,
            Title = source.Title,
            TitleOfCourtesy = source.TitleOfCourtesy,
            BirthDate = source.BirthDate,
            HireDate = source.HireDate,
            Address = source.Address,
            City = source.City,
            Region = source.Region,
            PostalCode = source.PostalCode,
            Country = source.Country,
            HomePhone = source.HomePhone,
            Extension = source.Extension,
            Notes = source.Notes,
            ReportsTo_NK = source.ReportsTo_NK,
            Age = source.Age,
            YearsOfExperience = source.YearsOfExperience,
            UpdatedDate = source.UpdatedDate
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            EmployeeID_NK, LastName, FirstName, FullName, Title, TitleOfCourtesy,
            BirthDate, HireDate, Address, City, Region, PostalCode, Country,
            HomePhone, Extension, Notes, ReportsTo_NK, ManagerName, HierarchyLevel,
            Age, YearsOfExperience, IsActive, CreatedDate, UpdatedDate
        )
        VALUES (
            source.EmployeeID_NK, source.LastName, source.FirstName, source.FullName, 
            source.Title, source.TitleOfCourtesy, source.BirthDate, source.HireDate,
            source.Address, source.City, source.Region, source.PostalCode, source.Country,
            source.HomePhone, source.Extension, source.Notes, source.ReportsTo_NK,
            source.ManagerName, source.HierarchyLevel, source.Age, source.YearsOfExperience,
            source.IsActive, source.CreatedDate, source.UpdatedDate
        );
        
    -- Actualizar ManagerName después del MERGE
    UPDATE [dim].[DimEmployee]
    SET ManagerName = (
        SELECT FullName 
        FROM [dim].[DimEmployee] m 
        WHERE m.EmployeeID_NK = [dim].[DimEmployee].ReportsTo_NK
    ),
    HierarchyLevel = CASE
        WHEN ReportsTo_NK IS NULL THEN 1
        WHEN ReportsTo_NK IN (SELECT EmployeeID_NK FROM [dim].[DimEmployee] WHERE ReportsTo_NK IS NULL) THEN 2
        ELSE 3
    END
    WHERE ReportsTo_NK IS NOT NULL;
END