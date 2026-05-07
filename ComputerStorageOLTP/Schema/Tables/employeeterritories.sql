CREATE TABLE [dbo].[employeeterritories](
    [EmployeeID]  INT           NOT NULL,
    [TerritoryID] NVARCHAR(20)  NOT NULL,
    [rowversion]  ROWVERSION    NULL,
    CONSTRAINT [PK_employeeterritories] PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC, [TerritoryID] ASC)
);
GO