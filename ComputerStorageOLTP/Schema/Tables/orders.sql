CREATE TABLE [dbo].[orders](
    [OrderID]        INT            IDENTITY(1,1) NOT NULL,
    [CustomerID]     NCHAR(5)       NULL,
    [EmployeeID]     INT            NULL,
    [OrderDate]      DATETIME       NULL,
    [RequiredDate]   DATETIME       NULL,
    [ShippedDate]    DATETIME       NULL,
    [ShipVia]        INT            NULL,
    [Freight]        MONEY          NULL,
    [ShipName]       NVARCHAR(40)   NULL,
    [ShipAddress]    NVARCHAR(60)   NULL,
    [ShipCity]       NVARCHAR(15)   NULL,
    [ShipRegion]     NVARCHAR(15)   NULL,
    [ShipPostalCode] NVARCHAR(10)   NULL,
    [ShipCountry]    NVARCHAR(15)   NULL,
    [rowversion]     ROWVERSION     NULL,
    CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_orders_CustomerID] ON [dbo].[orders]([CustomerID] ASC);
CREATE NONCLUSTERED INDEX [IX_orders_EmployeeID] ON [dbo].[orders]([EmployeeID] ASC);
CREATE NONCLUSTERED INDEX [IX_orders_OrderDate] ON [dbo].[orders]([OrderDate] ASC);
CREATE NONCLUSTERED INDEX [IX_orders_ShipPostalCode] ON [dbo].[orders]([ShipPostalCode] ASC);
CREATE NONCLUSTERED INDEX [IX_orders_ShippedDate] ON [dbo].[orders]([ShippedDate] ASC);
CREATE NONCLUSTERED INDEX [IX_orders_ShipVia] ON [dbo].[orders]([ShipVia] ASC);
GO

ALTER TABLE [dbo].[orders] ADD CONSTRAINT [DF_orders_Freight] DEFAULT ((0)) FOR [Freight];
GO