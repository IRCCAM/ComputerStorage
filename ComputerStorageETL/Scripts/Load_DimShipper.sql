USE ComputerStorageDW;
GO

TRUNCATE TABLE dbo.DimShipper;
GO

INSERT INTO dbo.DimShipper
(
    ShipperID_NK,
    CompanyName,
    Phone,
    IsActive,
    CreatedDate
)
SELECT
    ShipperID,
    CompanyName,
    Phone,
    1,
    GETDATE()
FROM ComputerStorageOLTP.production.shippers;
GO