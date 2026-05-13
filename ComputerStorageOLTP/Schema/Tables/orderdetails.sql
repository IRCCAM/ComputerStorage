CREATE TABLE [sales].[orderdetails] (
    [OrderID]    INT        NOT NULL,
    [ProductID]  INT        NOT NULL,
    [UnitPrice]  MONEY      NOT NULL  CONSTRAINT [DF_orderdetails_UnitPrice]  DEFAULT (0),
    [Quantity]   SMALLINT   NOT NULL  CONSTRAINT [DF_orderdetails_Quantity]   DEFAULT (1),
    [Discount]   REAL       NOT NULL  CONSTRAINT [DF_orderdetails_Discount]   DEFAULT (0),
    [rowversion] ROWVERSION NULL,
    CONSTRAINT [PK_orderdetails]          PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [CK_orderdetails_Discount]  CHECK ([Discount]  >= 0 AND [Discount] <= 1),
    CONSTRAINT [CK_orderdetails_Quantity]  CHECK ([Quantity]  > 0),
    CONSTRAINT [CK_orderdetails_UnitPrice] CHECK ([UnitPrice] >= 0)
);
GO
CREATE NONCLUSTERED INDEX [IX_orderdetails_OrderID]
    ON [sales].[orderdetails] ([OrderID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orderdetails_ProductID]
    ON [sales].[orderdetails] ([ProductID] ASC);
GO
-- FK: orderdetails -> orders
ALTER TABLE [sales].[orderdetails]
    ADD CONSTRAINT [FK_orderdetails_orders]
    FOREIGN KEY ([OrderID])
    REFERENCES [sales].[orders] ([OrderID]);
GO
-- FK: orderdetails -> products
ALTER TABLE [sales].[orderdetails]
    ADD CONSTRAINT [FK_orderdetails_products]
    FOREIGN KEY ([ProductID])
    REFERENCES [production].[products] ([ProductID]);
GO
