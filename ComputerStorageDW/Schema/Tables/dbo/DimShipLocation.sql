CREATE TABLE [dbo].[DimShipLocation]
(
    [ShipLocationKey]  INT IDENTITY(1,1) NOT NULL,
    [ShipName]         NVARCHAR(40)      NULL,
    [ShipAddress]      NVARCHAR(60)      NULL,
    [ShipCity]         NVARCHAR(15)      NULL,
    [ShipRegion]       NVARCHAR(15)      NULL,
    [ShipPostalCode]   NVARCHAR(10)      NULL,
    [ShipCountry]      NVARCHAR(15)      NULL,

    CONSTRAINT [PK_DimShipLocation]
        PRIMARY KEY CLUSTERED ([ShipLocationKey]),

    CONSTRAINT [UQ_DimShipLocation]
        UNIQUE
        (
            [ShipName],
            [ShipAddress],
            [ShipCity],
            [ShipRegion],
            [ShipPostalCode],
            [ShipCountry]
        )
);