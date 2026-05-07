CREATE PROCEDURE [dbo].[DW_MergeFactSales]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion combinado de Orders y OrderDetails
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM (
        SELECT RowVersion FROM [staging].[Orders]
        UNION ALL
        SELECT RowVersion FROM [staging].[OrderDetails]
    ) AS all_versions;
    
    -- MERGE de hechos de ventas
    MERGE INTO [fact].[FactSales] AS target
    USING (
        SELECT 
            od.OrderID,
            dp.ProductKey,
            dc.CustomerKey,
            de.EmployeeKey,
            ds.ShipperKey,
            dg.GeographyKey,
            dd_order.DateKey AS OrderDateKey,
            dd_required.DateKey AS RequiredDateKey,
            dd_shipped.DateKey AS ShippedDateKey,
            od.Quantity,
            od.UnitPrice,
            od.Discount,
            o.Freight,
            GETDATE() AS CreatedDate,
            o.RowVersion AS SourceRowVersion,
            NULL AS RowHash,
            ROW_NUMBER() OVER (PARTITION BY od.OrderID, od.ProductID ORDER BY o.ModifiedDate DESC) AS rn
        FROM [staging].[OrderDetails] od
        INNER JOIN [staging].[Orders] o ON od.OrderID = o.OrderID
        INNER JOIN [dim].[DimProduct] dp ON od.ProductID = dp.ProductID_NK
        INNER JOIN [dim].[DimCustomer] dc ON o.CustomerID = dc.CustomerID_NK
        INNER JOIN [dim].[DimEmployee] de ON o.EmployeeID = de.EmployeeID_NK
        INNER JOIN [dim].[DimShipper] ds ON o.ShipVia = ds.ShipperID_NK
        INNER JOIN [dim].[DimDate] dd_order ON CAST(o.OrderDate AS DATE) = dd_order.FullDate
        LEFT JOIN [dim].[DimDate] dd_required ON CAST(o.RequiredDate AS DATE) = dd_required.FullDate
        LEFT JOIN [dim].[DimDate] dd_shipped ON CAST(o.ShippedDate AS DATE) = dd_shipped.FullDate
        LEFT JOIN [dim].[DimGeography] dg ON o.ShipCountry = dg.TerritoryID_NK  -- Simplificado, ajusta según lógica real
        WHERE o.RowVersion > @LastRowVersion OR od.RowVersion > @LastRowVersion
    ) AS source
    ON target.OrderID = source.OrderID 
       AND target.ProductKey = source.ProductKey 
       AND source.rn = 1
    
    WHEN MATCHED AND target.SourceRowVersion < source.SourceRowVersion THEN
        UPDATE SET
            CustomerKey = source.CustomerKey,
            EmployeeKey = source.EmployeeKey,
            ShipperKey = source.ShipperKey,
            GeographyKey = source.GeographyKey,
            OrderDateKey = source.OrderDateKey,
            RequiredDateKey = source.RequiredDateKey,
            ShippedDateKey = source.ShippedDateKey,
            Quantity = source.Quantity,
            UnitPrice = source.UnitPrice,
            Discount = source.Discount,
            Freight = source.Freight,
            CreatedDate = source.CreatedDate,
            SourceRowVersion = source.SourceRowVersion
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            OrderID, ProductKey, CustomerKey, EmployeeKey, ShipperKey, GeographyKey,
            OrderDateKey, RequiredDateKey, ShippedDateKey, Quantity, UnitPrice,
            Discount, Freight, CreatedDate, SourceRowVersion, RowHash
        )
        VALUES (
            source.OrderID, source.ProductKey, source.CustomerKey, source.EmployeeKey, source.ShipperKey, source.GeographyKey,
            source.OrderDateKey, source.RequiredDateKey, source.ShippedDateKey, source.Quantity, source.UnitPrice,
            source.Discount, source.Freight, source.CreatedDate, source.SourceRowVersion, source.RowHash
        );
        
    -- Actualizar DimCustomer con FirstOrderDate, LastOrderDate, TotalOrders, LifetimeValue después del MERGE
    UPDATE [dim].[DimCustomer]
    SET 
        FirstOrderDate = stats.FirstOrderDate,
        LastOrderDate = stats.LastOrderDate,
        TotalOrders = stats.TotalOrders,
        LifetimeValue = stats.LifetimeValue
    FROM (
        SELECT 
            c.CustomerKey,
            MIN(od.FullDate) AS FirstOrderDate,
            MAX(od.FullDate) AS LastOrderDate,
            COUNT(DISTINCT fs.OrderID) AS TotalOrders,
            SUM(fs.LineTotal) AS LifetimeValue
        FROM [fact].[FactSales] fs
        INNER JOIN [dim].[DimCustomer] c ON fs.CustomerKey = c.CustomerKey
        INNER JOIN [dim].[DimDate] od ON fs.OrderDateKey = od.DateKey
        GROUP BY c.CustomerKey
    ) stats
    WHERE [dim].[DimCustomer].CustomerKey = stats.CustomerKey;
END