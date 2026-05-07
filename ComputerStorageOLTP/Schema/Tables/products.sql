CREATE TABLE [dbo].[products](
    [ProductID]       INT            IDENTITY(1,1) NOT NULL,
    [ProductName]     NVARCHAR(40)   NOT NULL,
    [SupplierID]      INT            NULL,
    [CategoryID]      INT            NULL,
    [QuantityPerUnit] NVARCHAR(20)   NULL,
    [UnitPrice]       MONEY          NULL,
    [UnitsInStock]    SMALLINT       NULL,
    [UnitsOnOrder]    SMALLINT       NULL,
    [ReorderLevel]    SMALLINT       NULL,
    [Discontinued]    BIT            NOT NULL,
    [rowversion]      ROWVERSION     NULL,
    CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_products_CategoryID] ON [dbo].[products]([CategoryID] ASC);
CREATE NONCLUSTERED INDEX [IX_products_ProductName] ON [dbo].[products]([ProductName] ASC);
CREATE NONCLUSTERED INDEX [IX_products_SupplierID] ON [dbo].[products]([SupplierID] ASC);
GO

ALTER TABLE [dbo].[products] ADD CONSTRAINT [DF_products_UnitPrice] DEFAULT ((0)) FOR [UnitPrice];
ALTER TABLE [dbo].[products] ADD CONSTRAINT [DF_products_UnitsInStock] DEFAULT ((0)) FOR [UnitsInStock];
ALTER TABLE [dbo].[products] ADD CONSTRAINT [DF_products_UnitsOnOrder] DEFAULT ((0)) FOR [UnitsOnOrder];
ALTER TABLE [dbo].[products] ADD CONSTRAINT [DF_products_ReorderLevel] DEFAULT ((0)) FOR [ReorderLevel];
ALTER TABLE [dbo].[products] ADD CONSTRAINT [DF_products_Discontinued] DEFAULT ((0)) FOR [Discontinued];
GO

ALTER TABLE [dbo].[products] ADD CONSTRAINT [CK_products_UnitPrice] CHECK ([UnitPrice] >= 0);
ALTER TABLE [dbo].[products] ADD CONSTRAINT [CK_products_ReorderLevel] CHECK ([ReorderLevel] >= 0);
ALTER TABLE [dbo].[products] ADD CONSTRAINT [CK_products_UnitsInStock] CHECK ([UnitsInStock] >= 0);
ALTER TABLE [dbo].[products] ADD CONSTRAINT [CK_products_UnitsOnOrder] CHECK ([UnitsOnOrder] >= 0);
GO