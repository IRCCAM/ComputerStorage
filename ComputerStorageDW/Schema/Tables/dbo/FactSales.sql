CREATE TABLE [dbo].[FactSales]
(
    [SalesKey]         BIGINT IDENTITY(1,1) NOT NULL,
    [OrderID]          INT                  NOT NULL,
    [ProductID]        INT                  NOT NULL,
    [OrderDateKey]     INT                  NULL,
    [RequiredDateKey]  INT                  NULL,
    [ShippedDateKey]   INT                  NULL,
    [CustomerKey]      INT                  NOT NULL,
    [EmployeeKey]      INT                  NOT NULL,
    [ProductKey]       INT                  NOT NULL,
    [ShipperKey]       INT                  NULL,
    [ShipLocationKey]  INT                  NULL,
    [UnitPrice]        MONEY                NOT NULL,
    [Quantity]         SMALLINT             NOT NULL,
    [Discount]         REAL                 NOT NULL,

    [GrossAmount] AS
    (
        CONVERT(DECIMAL(19,4), [UnitPrice])
        * CONVERT(DECIMAL(19,4), [Quantity])
    ) PERSISTED,

    [DiscountAmount] AS
    (
        CONVERT(DECIMAL(19,4), [UnitPrice])
        * CONVERT(DECIMAL(19,4), [Quantity])
        * CONVERT(DECIMAL(19,4), [Discount])
    ) PERSISTED,

    [NetAmount] AS
    (
        CONVERT(DECIMAL(19,4), [UnitPrice])
        * CONVERT(DECIMAL(19,4), [Quantity])
        * (1 - CONVERT(DECIMAL(19,4), [Discount]))
    ) PERSISTED,

    [Freight]          MONEY                NULL,

    [LoadDate]         DATETIME2(0)         NOT NULL
        CONSTRAINT [DF_FactSales_LoadDate]
        DEFAULT SYSUTCDATETIME(),

    CONSTRAINT [PK_FactSales]
        PRIMARY KEY CLUSTERED ([SalesKey]),

    CONSTRAINT [UQ_FactSales_Order_Product]
        UNIQUE ([OrderID], [ProductID]),

    CONSTRAINT [FK_FactSales_OrderDate]
        FOREIGN KEY ([OrderDateKey])
        REFERENCES [dbo].[DimDate] ([DateKey]),

    CONSTRAINT [FK_FactSales_RequiredDate]
        FOREIGN KEY ([RequiredDateKey])
        REFERENCES [dbo].[DimDate] ([DateKey]),

    CONSTRAINT [FK_FactSales_ShippedDate]
        FOREIGN KEY ([ShippedDateKey])
        REFERENCES [dbo].[DimDate] ([DateKey]),

    CONSTRAINT [FK_FactSales_Customer]
        FOREIGN KEY ([CustomerKey])
        REFERENCES [dbo].[DimCustomer] ([CustomerKey]),

    CONSTRAINT [FK_FactSales_Employee]
        FOREIGN KEY ([EmployeeKey])
        REFERENCES [dbo].[DimEmployee] ([EmployeeKey]),

    CONSTRAINT [FK_FactSales_Product]
        FOREIGN KEY ([ProductKey])
        REFERENCES [dbo].[DimProduct] ([ProductKey]),

    CONSTRAINT [FK_FactSales_Shipper]
        FOREIGN KEY ([ShipperKey])
        REFERENCES [dbo].[DimShipper] ([ShipperKey]),

    CONSTRAINT [FK_FactSales_ShipLocation]
        FOREIGN KEY ([ShipLocationKey])
        REFERENCES [dbo].[DimShipLocation] ([ShipLocationKey])
);