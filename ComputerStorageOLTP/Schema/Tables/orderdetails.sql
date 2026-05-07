CREATE TABLE [sales].[orderdetails](
    [OrderID]     INT       NOT NULL,
    [ProductID]   INT       NOT NULL,
    [UnitPrice]   MONEY     NOT NULL,
    [Quantity]    SMALLINT  NOT NULL,
    [Discount]    REAL      NOT NULL,
    [rowversion]  ROWVERSION NULL,
    CONSTRAINT [PK_orderdetails] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_orderdetails_OrderID] ON [dbo].[orderdetails]([OrderID] ASC);
CREATE NONCLUSTERED INDEX [IX_orderdetails_ProductID] ON [dbo].[orderdetails]([ProductID] ASC);
GO

ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [DF_orderdetails_UnitPrice] DEFAULT ((0)) FOR [UnitPrice];
ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [DF_orderdetails_Quantity] DEFAULT ((1)) FOR [Quantity];
ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [DF_orderdetails_Discount] DEFAULT ((0)) FOR [Discount];
GO

ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [CK_orderdetails_Discount] CHECK ([Discount] >= 0 AND [Discount] <= 1);
ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [CK_orderdetails_Quantity] CHECK ([Quantity] > 0);
ALTER TABLE [dbo].[orderdetails] ADD CONSTRAINT [CK_orderdetails_UnitPrice] CHECK ([UnitPrice] >= 0);
GO