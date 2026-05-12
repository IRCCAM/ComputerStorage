CREATE TABLE [staging].[Sales]
(
    [OrderID]          INT       NOT NULL,
    [ProductID]        INT       NOT NULL,
    [CustomerID]       NCHAR(5)  NULL,
    [EmployeeID]       INT       NULL,
    [ShipVia]          INT       NULL,

    [OrderDate]        DATETIME  NULL,
    [RequiredDate]     DATETIME  NULL,
    [ShippedDate]      DATETIME  NULL,

    [ShipName]         NVARCHAR(40)  NULL,
    [ShipAddress]      NVARCHAR(60)  NULL,
    [ShipCity]         NVARCHAR(15)  NULL,
    [ShipRegion]       NVARCHAR(15)  NULL,
    [ShipPostalCode]   NVARCHAR(10)  NULL,
    [ShipCountry]      NVARCHAR(15)  NULL,

    [UnitPrice]        MONEY     NOT NULL,
    [Quantity]         SMALLINT  NOT NULL,
    [Discount]         REAL      NOT NULL,
    [Freight]          MONEY     NULL
);