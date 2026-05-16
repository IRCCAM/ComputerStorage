USE ComputerStorageDW;
GO

TRUNCATE TABLE dbo.DimCustomer;
GO

INSERT INTO dbo.DimCustomer
(
    CustomerID_NK,
    CompanyName,
    ContactName,
    ContactTitle,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    Phone,
    Fax,
    IsActive,
    CreatedDate
)
SELECT
    CustomerID,
    CompanyName,
    ContactName,
    ContactTitle,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    Phone,
    Fax,
    1,
    GETDATE()
FROM ComputerStorageOLTP.sales.customers;
GO