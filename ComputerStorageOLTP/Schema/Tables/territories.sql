CREATE TABLE [production].[territories](
    [TerritoryID]          NVARCHAR(20)  NOT NULL,
    [TerritoryDescription] NCHAR(50)     NOT NULL,
    [RegionID]             INT           NOT NULL,
    [rowversion]           ROWVERSION    NULL,
    CONSTRAINT [PK_territories] PRIMARY KEY NONCLUSTERED ([TerritoryID] ASC)
);
GO