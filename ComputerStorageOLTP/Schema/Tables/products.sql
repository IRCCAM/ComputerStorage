CREATE TABLE [production].[products] (
    [ProductID]       INT            IDENTITY(1,1) NOT NULL,
    [ProductName]     NVARCHAR(40)   NOT NULL,
    [SupplierID]      INT            NULL,
    [CategoryID]      INT            NULL,
    [QuantityPerUnit] NVARCHAR(20)   NULL,
    [UnitPrice]       MONEY          NULL  CONSTRAINT [DF_products_UnitPrice]    DEFAULT (0),
    [UnitsInStock]    SMALLINT       NULL  CONSTRAINT [DF_products_UnitsInStock] DEFAULT (0),
    [UnitsOnOrder]    SMALLINT       NULL  CONSTRAINT [DF_products_UnitsOnOrder] DEFAULT (0),
    [ReorderLevel]    SMALLINT       NULL  CONSTRAINT [DF_products_ReorderLevel] DEFAULT (0),
    [Discontinued]    BIT            NOT NULL CONSTRAINT [DF_products_Discontinued] DEFAULT (0),
    [rowversion]      ROWVERSION     NULL,
    CONSTRAINT [PK_products]              PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [CK_products_UnitPrice]    CHECK ([UnitPrice]    >= 0),
    CONSTRAINT [CK_products_UnitsInStock] CHECK ([UnitsInStock] >= 0),
    CONSTRAINT [CK_products_UnitsOnOrder] CHECK ([UnitsOnOrder] >= 0),
    CONSTRAINT [CK_products_ReorderLevel] CHECK ([ReorderLevel] >= 0)
);
GO
CREATE NONCLUSTERED INDEX [IX_products_CategoryID]
    ON [production].[products] ([CategoryID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_products_ProductName]
    ON [production].[products] ([ProductName] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_products_SupplierID]
    ON [production].[products] ([SupplierID] ASC);
GO
-- FK: products -> categories
ALTER TABLE [production].[products]
    ADD CONSTRAINT [FK_products_categories]
    FOREIGN KEY ([CategoryID])
    REFERENCES [production].[categories] ([CategoryID]);
GO
-- FK: products -> suppliers
ALTER TABLE [production].[products]
    ADD CONSTRAINT [FK_products_suppliers]
    FOREIGN KEY ([SupplierID])
    REFERENCES [production].[suppliers] ([SupplierID]);
GO
