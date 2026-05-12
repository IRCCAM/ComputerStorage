CREATE TABLE [dbo].[DimProduct]
(
    [ProductKey]           INT IDENTITY(1,1) NOT NULL,
    [ProductID]            INT               NOT NULL,
    [ProductName]          NVARCHAR(40)      NOT NULL,
    [QuantityPerUnit]      NVARCHAR(20)      NULL,
    [UnitPriceList]        MONEY             NULL,
    [UnitsInStock]         SMALLINT          NULL,
    [UnitsOnOrder]         SMALLINT          NULL,
    [ReorderLevel]         SMALLINT          NULL,
    [Discontinued]         BIT               NOT NULL,

    [CategoryID]           INT               NULL,
    [CategoryName]         NVARCHAR(15)      NULL,
    [CategoryDescription]  NVARCHAR(MAX)     NULL,

    [SupplierID]           INT               NULL,
    [SupplierName]         NVARCHAR(40)      NULL,
    [SupplierCity]         NVARCHAR(15)      NULL,
    [SupplierRegion]       NVARCHAR(15)      NULL,
    [SupplierCountry]      NVARCHAR(15)      NULL,

    CONSTRAINT [PK_DimProduct]
        PRIMARY KEY CLUSTERED ([ProductKey]),

    CONSTRAINT [UQ_DimProduct_ProductID]
        UNIQUE ([ProductID])
);