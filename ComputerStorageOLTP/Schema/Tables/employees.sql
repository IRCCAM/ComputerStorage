CREATE TABLE [sales].[employees](
    [EmployeeID]      INT            IDENTITY(1,1) NOT NULL,
    [LastName]        NVARCHAR(20)   NOT NULL,
    [FirstName]       NVARCHAR(10)   NOT NULL,
    [Title]           NVARCHAR(30)   NULL,
    [TitleOfCourtesy] NVARCHAR(25)   NULL,
    [BirthDate]       DATETIME       NULL,
    [HireDate]        DATETIME       NULL,
    [Address]         NVARCHAR(60)   NULL,
    [City]            NVARCHAR(15)   NULL,
    [Region]          NVARCHAR(15)   NULL,
    [PostalCode]      NVARCHAR(10)   NULL,
    [Country]         NVARCHAR(15)   NULL,
    [HomePhone]       NVARCHAR(24)   NULL,
    [Extension]       NVARCHAR(4)    NULL,
    [Photo]           IMAGE          NULL,
    [Notes]           NVARCHAR(MAX)  NULL,
    [ReportsTo]       INT            NULL,
    [PhotoPath]       NVARCHAR(255)  NULL,
    [rowversion]      ROWVERSION     NULL,
    CONSTRAINT [PK_employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_employees_LastName] ON [dbo].[employees]([LastName] ASC);
CREATE NONCLUSTERED INDEX [IX_employees_PostalCode] ON [dbo].[employees]([PostalCode] ASC);
GO