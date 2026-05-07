CREATE TABLE [dbo].[customers](
    [CustomerID]   NCHAR(5)       NOT NULL,
    [CompanyName]  NVARCHAR(40)   NOT NULL,
    [ContactName]  NVARCHAR(30)   NULL,
    [ContactTitle] NVARCHAR(30)   NULL,
    [Address]      NVARCHAR(60)   NULL,
    [City]         NVARCHAR(15)   NULL,
    [Region]       NVARCHAR(15)   NULL,
    [PostalCode]   NVARCHAR(10)   NULL,
    [Country]      NVARCHAR(15)   NULL,
    [Phone]        NVARCHAR(24)   NULL,
    [Fax]          NVARCHAR(24)   NULL,
    [rowversion]   ROWVERSION     NULL,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_customers_City] ON [dbo].[customers]([City] ASC);
CREATE NONCLUSTERED INDEX [IX_customers_CompanyName] ON [dbo].[customers]([CompanyName] ASC);
CREATE NONCLUSTERED INDEX [IX_customers_PostalCode] ON [dbo].[customers]([PostalCode] ASC);
CREATE NONCLUSTERED INDEX [IX_customers_Region] ON [dbo].[customers]([Region] ASC);
GO