USE ComputerStorageDW;
GO

TRUNCATE TABLE staging.Territories;
GO

INSERT INTO staging.Territories
(
    TerritoryID,
    TerritoryDescription,
    RegionID,
    RowVersion,
    CreatedDate
)
SELECT
    TerritoryID,
    TerritoryDescription,
    RegionID,
    1,
    GETDATE()
FROM ComputerStorageOLTP.production.territories;
GO