CREATE PROCEDURE [sales].[GetShipLocationChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
        o.[ShipName],
        o.[ShipAddress],
        o.[ShipCity],
        o.[ShipRegion],
        o.[ShipPostalCode],
        o.[ShipCountry]
    FROM [sales].[orders] o
    WHERE
        o.[rowversion] > CONVERT(ROWVERSION, @startRow)
        AND o.[rowversion] <= CONVERT(ROWVERSION, @endRow);
END
GO
