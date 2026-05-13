CREATE TABLE [sales].[employeeterritories] (
    [EmployeeID]  INT           NOT NULL,
    [TerritoryID] NVARCHAR(20)  NOT NULL,
    [rowversion]  ROWVERSION    NULL,
    CONSTRAINT [PK_employeeterritories]
        PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC, [TerritoryID] ASC)
);
GO
-- FK: employeeterritories -> employees
ALTER TABLE [sales].[employeeterritories]
    ADD CONSTRAINT [FK_employeeterritories_employees]
    FOREIGN KEY ([EmployeeID])
    REFERENCES [sales].[employees] ([EmployeeID]);
GO
-- FK: employeeterritories -> territories
ALTER TABLE [sales].[employeeterritories]
    ADD CONSTRAINT [FK_employeeterritories_territories]
    FOREIGN KEY ([TerritoryID])
    REFERENCES [production].[territories] ([TerritoryID]);
GO
