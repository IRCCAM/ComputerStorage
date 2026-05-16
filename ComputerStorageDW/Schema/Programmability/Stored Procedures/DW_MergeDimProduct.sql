CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO [dbo].[DimProduct] AS target
    USING
    (
        SELECT
            p.[ProductID],
            p.[ProductName],
            p.[QuantityPerUnit],
            p.[UnitPriceList],
            p.[UnitsInStock],
            p.[UnitsOnOrder],
            p.[ReorderLevel],
            p.[Discontinued],
            p.[CategoryID],
            p.[CategoryName],
            p.[CategoryDescription],
            p.[SupplierID],
            p.[SupplierName],
            p.[SupplierCity],
            p.[SupplierRegion],
            p.[SupplierCountry]
        FROM [staging].[Product] p
    ) AS source
    ON target.[ProductID] = source.[ProductID]

    WHEN MATCHED AND
    (
           ISNULL(target.[ProductName], N'') <> ISNULL(source.[ProductName], N'')
        OR ISNULL(target.[QuantityPerUnit], N'') <> ISNULL(source.[QuantityPerUnit], N'')
        OR ISNULL(target.[UnitPriceList], 0) <> ISNULL(source.[UnitPriceList], 0)
        OR ISNULL(target.[UnitsInStock], -1) <> ISNULL(source.[UnitsInStock], -1)
        OR ISNULL(target.[UnitsOnOrder], -1) <> ISNULL(source.[UnitsOnOrder], -1)
        OR ISNULL(target.[ReorderLevel], -1) <> ISNULL(source.[ReorderLevel], -1)
        OR ISNULL(target.[Discontinued], 0) <> ISNULL(source.[Discontinued], 0)
        OR ISNULL(target.[CategoryID], -1) <> ISNULL(source.[CategoryID], -1)
        OR ISNULL(target.[CategoryName], N'') <> ISNULL(source.[CategoryName], N'')
        OR ISNULL(target.[CategoryDescription], N'') <> ISNULL(source.[CategoryDescription], N'')
        OR ISNULL(target.[SupplierID], -1) <> ISNULL(source.[SupplierID], -1)
        OR ISNULL(target.[SupplierName], N'') <> ISNULL(source.[SupplierName], N'')
        OR ISNULL(target.[SupplierCity], N'') <> ISNULL(source.[SupplierCity], N'')
        OR ISNULL(target.[SupplierRegion], N'') <> ISNULL(source.[SupplierRegion], N'')
        OR ISNULL(target.[SupplierCountry], N'') <> ISNULL(source.[SupplierCountry], N'')
    ) THEN
        UPDATE SET
            [ProductName] = source.[ProductName],
            [QuantityPerUnit] = source.[QuantityPerUnit],
            [UnitPriceList] = source.[UnitPriceList],
            [UnitsInStock] = source.[UnitsInStock],
            [UnitsOnOrder] = source.[UnitsOnOrder],
            [ReorderLevel] = source.[ReorderLevel],
            [Discontinued] = source.[Discontinued],
            [CategoryID] = source.[CategoryID],
            [CategoryName] = source.[CategoryName],
            [CategoryDescription] = source.[CategoryDescription],
            [SupplierID] = source.[SupplierID],
            [SupplierName] = source.[SupplierName],
            [SupplierCity] = source.[SupplierCity],
            [SupplierRegion] = source.[SupplierRegion],
            [SupplierCountry] = source.[SupplierCountry]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [ProductID],
            [ProductName],
            [QuantityPerUnit],
            [UnitPriceList],
            [UnitsInStock],
            [UnitsOnOrder],
            [ReorderLevel],
            [Discontinued],
            [CategoryID],
            [CategoryName],
            [CategoryDescription],
            [SupplierID],
            [SupplierName],
            [SupplierCity],
            [SupplierRegion],
            [SupplierCountry]
        )
        VALUES
        (
            source.[ProductID],
            source.[ProductName],
            source.[QuantityPerUnit],
            source.[UnitPriceList],
            source.[UnitsInStock],
            source.[UnitsOnOrder],
            source.[ReorderLevel],
            source.[Discontinued],
            source.[CategoryID],
            source.[CategoryName],
            source.[CategoryDescription],
            source.[SupplierID],
            source.[SupplierName],
            source.[SupplierCity],
            source.[SupplierRegion],
            source.[SupplierCountry]
        );
END
GO
