CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion combinado de Products, Categories, Suppliers
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM (
        SELECT RowVersion FROM [staging].[Products]
        UNION ALL
        SELECT RowVersion FROM [staging].[Categories]
        UNION ALL
        SELECT RowVersion FROM [staging].[Suppliers]
    ) AS all_versions;
    
    -- MERGE de productos
    MERGE INTO [dim].[DimProduct] AS target
    USING (
        SELECT 
            p.ProductID AS ProductID_NK,
            p.ProductName,
            p.QuantityPerUnit,
            p.UnitPrice,
            p.UnitsInStock,
            p.UnitsOnOrder,
            p.ReorderLevel,
            p.Discontinued,
            c.CategoryID AS CategoryID_NK,
            c.CategoryName,
            c.Description AS CategoryDescription,
            s.SupplierID AS SupplierID_NK,
            s.CompanyName AS SupplierCompanyName,
            s.ContactName AS SupplierContactName,
            s.ContactTitle AS SupplierContactTitle,
            s.City AS SupplierCity,
            s.Region AS SupplierRegion,
            s.Country AS SupplierCountry,
            s.Phone AS SupplierPhone,
            s.Fax AS SupplierFax,
            CASE 
                WHEN p.UnitPrice < 10 THEN 'Low'
                WHEN p.UnitPrice BETWEEN 10 AND 50 THEN 'Medium'
                ELSE 'High'
            END AS PriceRange,
            CASE 
                WHEN p.UnitsInStock = 0 THEN 'Out of Stock'
                WHEN p.UnitsInStock < p.ReorderLevel THEN 'Low Stock'
                ELSE 'In Stock'
            END AS StockStatus,
            CASE WHEN p.Discontinued = 1 THEN 0 ELSE 1 END AS IsActive,
            GETDATE() AS CreatedDate,
            GETDATE() AS UpdatedDate,
            ROW_NUMBER() OVER (PARTITION BY p.ProductID ORDER BY p.ModifiedDate DESC) AS rn
        FROM [staging].[Products] p
        INNER JOIN [staging].[Categories] c ON p.CategoryID = c.CategoryID
        INNER JOIN [staging].[Suppliers] s ON p.SupplierID = s.SupplierID
        WHERE p.RowVersion > @LastRowVersion 
           OR c.RowVersion > @LastRowVersion 
           OR s.RowVersion > @LastRowVersion
    ) AS source
    ON target.ProductID_NK = source.ProductID_NK AND source.rn = 1
    
    WHEN MATCHED AND target.UpdatedDate < source.UpdatedDate THEN
        UPDATE SET
            ProductName = source.ProductName,
            QuantityPerUnit = source.QuantityPerUnit,
            UnitPrice = source.UnitPrice,
            UnitsInStock = source.UnitsInStock,
            UnitsOnOrder = source.UnitsOnOrder,
            ReorderLevel = source.ReorderLevel,
            Discontinued = source.Discontinued,
            CategoryID_NK = source.CategoryID_NK,
            CategoryName = source.CategoryName,
            CategoryDescription = source.CategoryDescription,
            SupplierID_NK = source.SupplierID_NK,
            SupplierCompanyName = source.SupplierCompanyName,
            SupplierContactName = source.SupplierContactName,
            SupplierContactTitle = source.SupplierContactTitle,
            SupplierCity = source.SupplierCity,
            SupplierRegion = source.SupplierRegion,
            SupplierCountry = source.SupplierCountry,
            SupplierPhone = source.SupplierPhone,
            SupplierFax = source.SupplierFax,
            PriceRange = source.PriceRange,
            StockStatus = source.StockStatus,
            IsActive = source.IsActive,
            UpdatedDate = source.UpdatedDate
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            ProductID_NK, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock,
            UnitsOnOrder, ReorderLevel, Discontinued, CategoryID_NK, CategoryName,
            CategoryDescription, SupplierID_NK, SupplierCompanyName, SupplierContactName,
            SupplierContactTitle, SupplierCity, SupplierRegion, SupplierCountry,
            SupplierPhone, SupplierFax, PriceRange, StockStatus, IsActive,
            CreatedDate, UpdatedDate
        )
        VALUES (
            source.ProductID_NK, source.ProductName, source.QuantityPerUnit, source.UnitPrice, source.UnitsInStock,
            source.UnitsOnOrder, source.ReorderLevel, source.Discontinued, source.CategoryID_NK, source.CategoryName,
            source.CategoryDescription, source.SupplierID_NK, source.SupplierCompanyName, source.SupplierContactName,
            source.SupplierContactTitle, source.SupplierCity, source.SupplierRegion, source.SupplierCountry,
            source.SupplierPhone, source.SupplierFax, source.PriceRange, source.StockStatus, source.IsActive,
            source.CreatedDate, source.UpdatedDate
        );
END