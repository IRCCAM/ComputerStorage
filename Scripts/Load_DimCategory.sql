USE ComputerStorageDW;
GO

TRUNCATE TABLE staging.Categories;
GO

INSERT INTO staging.Categories
(
    CategoryID,
    CategoryName,
    Description,
    Picture,
    RowVersion,
    CreatedDate
)
SELECT
    CategoryID,
    CategoryName,
    Description,
    Picture,
    1,
    GETDATE()
FROM ComputerStorageOLTP.production.categories;
GO