USE ComputerStorageDW;
GO

TRUNCATE TABLE dbo.DimProduct;
GO

INSERT INTO dbo.DimProduct
(
    ProductID_NK,
    ProductName,
    QuantityPerUnit,
    UnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued,

    CategoryID_NK,
    CategoryName,
    CategoryDescription,

    SupplierID_NK,
    SupplierCompanyName,
    SupplierContactName,
    SupplierContactTitle,
    SupplierCity,
    SupplierRegion,
    SupplierCountry,
    SupplierPhone,
    SupplierFax,

    IsActive,
    CreatedDate
)
SELECT
    p.ProductID,
    p.ProductName,
    p.QuantityPerUnit,
    p.UnitPrice,
    p.UnitsInStock,
    p.UnitsOnOrder,
    p.ReorderLevel,
    p.Discontinued,

    c.CategoryID,
    c.CategoryName,
    c.Description,

    s.SupplierID,
    s.CompanyName,
    s.ContactName,
    s.ContactTitle,
    s.City,
    s.Region,
    s.Country,
    s.Phone,
    s.Fax,

    1,
    GETDATE()

FROM ComputerStorageOLTP.production.products p

LEFT JOIN ComputerStorageOLTP.production.categories c
    ON p.CategoryID = c.CategoryID

LEFT JOIN ComputerStorageOLTP.production.suppliers s
    ON p.SupplierID = s.SupplierID;
GO