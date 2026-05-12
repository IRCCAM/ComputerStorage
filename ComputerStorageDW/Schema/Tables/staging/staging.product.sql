CREATE TABLE [staging].[Product]
(
    [ProductID]            INT            NOT NULL,
    [ProductName]          NVARCHAR(40)   NOT NULL,
    [SupplierID]           INT            NULL,
    [SupplierName]         NVARCHAR(40)   NULL,
    [SupplierCity]         NVARCHAR(15)   NULL,
    [SupplierRegion]       NVARCHAR(15)   NULL,
    [SupplierCountry]      NVARCHAR(15)   NULL,
    [CategoryID]           INT            NULL,
    [CategoryName]         NVARCHAR(15)   NULL,
    [CategoryDescription]  NVARCHAR(MAX)  NULL,
    [QuantityPerUnit]      NVARCHAR(20)   NULL,
    [UnitPriceList]        MONEY          NULL,
    [UnitsInStock]         SMALLINT       NULL,
    [UnitsOnOrder]         SMALLINT       NULL,
    [ReorderLevel]         SMALLINT       NULL,
    [Discontinued]         BIT            NOT NULL
);