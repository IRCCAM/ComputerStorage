USE ComputerStorageDW;
GO

TRUNCATE TABLE dbo.FactSales;
GO

INSERT INTO dbo.FactSales
(
    OrderID,
    ProductKey,
    CustomerKey,
    EmployeeKey,
    ShipperKey,
    GeographyKey,

    OrderDateKey,
    RequiredDateKey,
    ShippedDateKey,

    Quantity,
    UnitPrice,
    Discount,
    Freight,

    CreatedDate
)
SELECT
    o.OrderID,

    dp.ProductKey,

    dc.CustomerKey,

    de.EmployeeKey,

    ds.ShipperKey,

    1,

    CAST(CONVERT(VARCHAR, o.OrderDate, 112) AS INT),

    CAST(CONVERT(VARCHAR, o.RequiredDate, 112) AS INT),

    CAST(CONVERT(VARCHAR, o.ShippedDate, 112) AS INT),

    od.Quantity,

    od.UnitPrice,

    od.Discount,

    o.Freight,

    GETDATE()

FROM ComputerStorageOLTP.sales.orders o

INNER JOIN ComputerStorageOLTP.sales.orderdetails od
    ON o.OrderID = od.OrderID

INNER JOIN dbo.DimCustomer dc
    ON RTRIM(o.CustomerID) = RTRIM(dc.CustomerID_NK)

INNER JOIN dbo.DimProduct dp
    ON od.ProductID = dp.ProductID_NK

INNER JOIN dbo.DimEmployee de
    ON o.EmployeeID = de.EmployeeID_NK

INNER JOIN dbo.DimShipper ds
    ON o.ShipVia = ds.ShipperID_NK;
GO