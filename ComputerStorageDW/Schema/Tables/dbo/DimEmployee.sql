CREATE TABLE [dbo].[DimEmployee]
(
    [EmployeeKey]          INT IDENTITY(1,1) NOT NULL,
    [EmployeeID]           INT               NOT NULL,
    [FullName]             NVARCHAR(60)      NOT NULL,
    [FirstName]            NVARCHAR(10)      NOT NULL,
    [LastName]             NVARCHAR(20)      NOT NULL,
    [Title]                NVARCHAR(30)      NULL,
    [TitleOfCourtesy]      NVARCHAR(25)      NULL,
    [BirthDate]            DATE              NULL,
    [HireDate]             DATE              NULL,
    [City]                 NVARCHAR(15)      NULL,
    [Region]               NVARCHAR(15)      NULL,
    [Country]              NVARCHAR(15)      NULL,
    [ReportsToEmployeeID]  INT               NULL,

    CONSTRAINT [PK_DimEmployee]
        PRIMARY KEY CLUSTERED ([EmployeeKey]),

    CONSTRAINT [UQ_DimEmployee_EmployeeID]
        UNIQUE ([EmployeeID])
);