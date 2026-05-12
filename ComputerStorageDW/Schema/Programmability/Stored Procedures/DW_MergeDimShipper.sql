CREATE PROCEDURE [dbo].[DW_MergeDimShipper]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO [dbo].[DimShipper] AS target
    USING
    (
        SELECT
            s.[ShipperID],
            s.[CompanyName],
            s.[Phone]
        FROM [staging].[Shipper] s
    ) AS source
    ON target.[ShipperID] = source.[ShipperID]

    WHEN MATCHED AND
    (
           ISNULL(target.[CompanyName], N'') <> ISNULL(source.[CompanyName], N'')
        OR ISNULL(target.[Phone], N'') <> ISNULL(source.[Phone], N'')
    ) THEN
        UPDATE SET
            [CompanyName] = source.[CompanyName],
            [Phone] = source.[Phone]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [ShipperID],
            [CompanyName],
            [Phone]
        )
        VALUES
        (
            source.[ShipperID],
            source.[CompanyName],
            source.[Phone]
        );
END
GO
