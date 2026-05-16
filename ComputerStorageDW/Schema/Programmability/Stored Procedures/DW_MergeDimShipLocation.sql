CREATE PROCEDURE [dbo].[DW_MergeDimShipLocation]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO [dbo].[DimShipLocation] AS target
    USING
    (
        SELECT DISTINCT
            s.[ShipName],
            s.[ShipAddress],
            s.[ShipCity],
            s.[ShipRegion],
            s.[ShipPostalCode],
            s.[ShipCountry]
        FROM [staging].[ShipLocation] s
    ) AS source
    ON ISNULL(target.[ShipName], N'') = ISNULL(source.[ShipName], N'')
       AND ISNULL(target.[ShipAddress], N'') = ISNULL(source.[ShipAddress], N'')
       AND ISNULL(target.[ShipCity], N'') = ISNULL(source.[ShipCity], N'')
       AND ISNULL(target.[ShipRegion], N'') = ISNULL(source.[ShipRegion], N'')
       AND ISNULL(target.[ShipPostalCode], N'') = ISNULL(source.[ShipPostalCode], N'')
       AND ISNULL(target.[ShipCountry], N'') = ISNULL(source.[ShipCountry], N'')

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [ShipName],
            [ShipAddress],
            [ShipCity],
            [ShipRegion],
            [ShipPostalCode],
            [ShipCountry]
        )
        VALUES
        (
            source.[ShipName],
            source.[ShipAddress],
            source.[ShipCity],
            source.[ShipRegion],
            source.[ShipPostalCode],
            source.[ShipCountry]
        );
END
GO
