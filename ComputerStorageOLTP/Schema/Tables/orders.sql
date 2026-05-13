CREATE TABLE [sales].[orders] (
    [OrderID]        INT           IDENTITY(1,1) NOT NULL,
    [CustomerID]     NCHAR(5)      NULL,
    [EmployeeID]     INT           NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [ShippedDate]    DATETIME      NULL,
    [ShipVia]        INT           NULL,
    [Freight]        MONEY         NULL  CONSTRAINT [DF_orders_Freight] DEFAULT (0),
    [ShipName]       NVARCHAR(40)  NULL,
    [ShipAddress]    NVARCHAR(60)  NULL,
    [ShipCity]       NVARCHAR(15)  NULL,
    [ShipRegion]     NVARCHAR(15)  NULL,
    [ShipPostalCode] NVARCHAR(10)  NULL,
    [ShipCountry]    NVARCHAR(15)  NULL,
    [rowversion]     ROWVERSION    NULL,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_orders_CustomerID]
    ON [sales].[orders] ([CustomerID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orders_EmployeeID]
    ON [sales].[orders] ([EmployeeID] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orders_OrderDate]
    ON [sales].[orders] ([OrderDate] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orders_ShippedDate]
    ON [sales].[orders] ([ShippedDate] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orders_ShipPostalCode]
    ON [sales].[orders] ([ShipPostalCode] ASC);
GO
CREATE NONCLUSTERED INDEX [IX_orders_ShipVia]
    ON [sales].[orders] ([ShipVia] ASC);
GO
-- FK: orders -> customers
ALTER TABLE [sales].[orders]
    ADD CONSTRAINT [FK_orders_customers]
    FOREIGN KEY ([CustomerID])
    REFERENCES [sales].[customers] ([CustomerID]);
GO
-- FK: orders -> employees
ALTER TABLE [sales].[orders]
    ADD CONSTRAINT [FK_orders_employees]
    FOREIGN KEY ([EmployeeID])
    REFERENCES [sales].[employees] ([EmployeeID]);
GO
-- FK: orders -> shippers (ShipVia)
ALTER TABLE [sales].[orders]
    ADD CONSTRAINT [FK_orders_shippers]
    FOREIGN KEY ([ShipVia])
    REFERENCES [production].[shippers] ([ShipperID]);
GO
