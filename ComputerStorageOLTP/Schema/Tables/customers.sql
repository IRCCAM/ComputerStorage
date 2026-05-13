CREATE TABLE [sales].[customers] (
    [CustomerID]   NCHAR(5)      NOT NULL,
    [CompanyName]  NVARCHAR(40)  NOT NULL,
    [ContactName]  NVARCHAR(30)  NULL,
    [ContactTitle] NVARCHAR(30)  NULL,
    [Address]      NVARCHAR(60)  NULL,
    [City]         NVARCHAR(15)  NULL,
    [Region]       NVARCHAR(15)  NULL,
    [PostalCode]   NVARCHAR(10)  NULL,
    [Country]      NVARCHAR(15)  NULL,
    [Phone]        NVARCHAR(24)  NULL,
    [Fax]          NVARCHAR(24)  NULL,
    [rowversion]   ROWVERSION    NULL,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_customers_City]
    ON [sales].[customers] ([City] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_customers_CompanyName]
    ON [sales].[customers] ([CompanyName] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_customers_PostalCode]
    ON [sales].[customers] ([PostalCode] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_customers_Region]
    ON [sales].[customers] ([Region] ASC);
GO
