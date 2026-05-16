CREATE PROCEDURE [dbo].[DW_MergeFactSales]
AS
BEGIN
    SET NOCOUNT ON;
    EXEC [dbo].[DW_MergeDimShipLocation];

    ;WITH SourceSales AS
    (
        SELECT
            s.[OrderID],
            s.[ProductID],
            dOrder.[DateKey] AS [OrderDateKey],
            dRequired.[DateKey] AS [RequiredDateKey],
            dShipped.[DateKey] AS [ShippedDateKey],
            c.[CustomerKey],
            e.[EmployeeKey],
            p.[ProductKey],
            sh.[ShipperKey],
            sl.[ShipLocationKey],
            s.[UnitPrice],
            s.[Quantity],
            s.[Discount],
            s.[Freight]
        FROM [staging].[Sales] s
        INNER JOIN [dbo].[DimCustomer] c
            ON c.[CustomerID] = s.[CustomerID]
        INNER JOIN [dbo].[DimEmployee] e
            ON e.[EmployeeID] = s.[EmployeeID]
        INNER JOIN [dbo].[DimProduct] p
            ON p.[ProductID] = s.[ProductID]
        LEFT JOIN [dbo].[DimShipper] sh
            ON sh.[ShipperID] = s.[ShipVia]
        INNER JOIN [dbo].[DimDate] dOrder
            ON dOrder.[FullDate] = CAST(s.[OrderDate] AS DATE)
        LEFT JOIN [dbo].[DimDate] dRequired
            ON dRequired.[FullDate] = CAST(s.[RequiredDate] AS DATE)
        LEFT JOIN [dbo].[DimDate] dShipped
            ON dShipped.[FullDate] = CAST(s.[ShippedDate] AS DATE)
        LEFT JOIN [dbo].[DimShipLocation] sl
            ON ISNULL(sl.[ShipName], N'') = ISNULL(s.[ShipName], N'')
           AND ISNULL(sl.[ShipAddress], N'') = ISNULL(s.[ShipAddress], N'')
           AND ISNULL(sl.[ShipCity], N'') = ISNULL(s.[ShipCity], N'')
           AND ISNULL(sl.[ShipRegion], N'') = ISNULL(s.[ShipRegion], N'')
           AND ISNULL(sl.[ShipPostalCode], N'') = ISNULL(s.[ShipPostalCode], N'')
           AND ISNULL(sl.[ShipCountry], N'') = ISNULL(s.[ShipCountry], N'')
    )
    MERGE INTO [dbo].[FactSales] AS target
    USING SourceSales AS source
    ON target.[OrderID] = source.[OrderID]
       AND target.[ProductID] = source.[ProductID]

    WHEN MATCHED AND
    (
           ISNULL(target.[OrderDateKey], 0) <> ISNULL(source.[OrderDateKey], 0)
        OR ISNULL(target.[RequiredDateKey], 0) <> ISNULL(source.[RequiredDateKey], 0)
        OR ISNULL(target.[ShippedDateKey], 0) <> ISNULL(source.[ShippedDateKey], 0)
        OR target.[CustomerKey] <> source.[CustomerKey]
        OR target.[EmployeeKey] <> source.[EmployeeKey]
        OR target.[ProductKey] <> source.[ProductKey]
        OR ISNULL(target.[ShipperKey], 0) <> ISNULL(source.[ShipperKey], 0)
        OR ISNULL(target.[ShipLocationKey], 0) <> ISNULL(source.[ShipLocationKey], 0)
        OR target.[UnitPrice] <> source.[UnitPrice]
        OR target.[Quantity] <> source.[Quantity]
        OR target.[Discount] <> source.[Discount]
        OR ISNULL(target.[Freight], 0) <> ISNULL(source.[Freight], 0)
    ) THEN
        UPDATE SET
            [OrderDateKey] = source.[OrderDateKey],
            [RequiredDateKey] = source.[RequiredDateKey],
            [ShippedDateKey] = source.[ShippedDateKey],
            [CustomerKey] = source.[CustomerKey],
            [EmployeeKey] = source.[EmployeeKey],
            [ProductKey] = source.[ProductKey],
            [ShipperKey] = source.[ShipperKey],
            [ShipLocationKey] = source.[ShipLocationKey],
            [UnitPrice] = source.[UnitPrice],
            [Quantity] = source.[Quantity],
            [Discount] = source.[Discount],
            [Freight] = source.[Freight],
            [LoadDate] = SYSUTCDATETIME()

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [OrderID],
            [ProductID],
            [OrderDateKey],
            [RequiredDateKey],
            [ShippedDateKey],
            [CustomerKey],
            [EmployeeKey],
            [ProductKey],
            [ShipperKey],
            [ShipLocationKey],
            [UnitPrice],
            [Quantity],
            [Discount],
            [Freight]
        )
        VALUES
        (
            source.[OrderID],
            source.[ProductID],
            source.[OrderDateKey],
            source.[RequiredDateKey],
            source.[ShippedDateKey],
            source.[CustomerKey],
            source.[EmployeeKey],
            source.[ProductKey],
            source.[ShipperKey],
            source.[ShipLocationKey],
            source.[UnitPrice],
            source.[Quantity],
            source.[Discount],
            source.[Freight]
        );
END
GO
