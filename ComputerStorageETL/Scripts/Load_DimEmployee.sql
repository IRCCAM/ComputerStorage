USE ComputerStorageDW;
GO

TRUNCATE TABLE dbo.DimEmployee;
GO

INSERT INTO dbo.DimEmployee
(
    EmployeeID_NK,
    LastName,
    FirstName,
    FullName,
    Title,
    TitleOfCourtesy,
    BirthDate,
    HireDate,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    HomePhone,
    Extension,
    Notes,
    ReportsTo_NK,

    Age,
    YearsOfExperience,

    IsActive,
    CreatedDate
)

SELECT
    EmployeeID,
    LastName,
    FirstName,

    FirstName + ' ' + LastName,

    Title,
    TitleOfCourtesy,
    BirthDate,
    HireDate,
    Address,
    City,
    Region,
    PostalCode,
    Country,
    HomePhone,
    Extension,
    Notes,
    ReportsTo,

    DATEDIFF(YEAR, BirthDate, GETDATE()),

    DATEDIFF(YEAR, HireDate, GETDATE()),

    1,
    GETDATE()

FROM ComputerStorageOLTP.sales.employees;
GO