CREATE TABLE [staging].[Territories] (
    [TerritoryID]          NVARCHAR(20) NOT NULL,
    [TerritoryDescription] NCHAR(50)    NOT NULL,
    [RegionID]             INT          NOT NULL,
    [RowVersion]           BIGINT       NOT NULL,
    [CreatedDate]          DATETIME     DEFAULT GETDATE(),
    [ModifiedDate]         DATETIME     DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingTerritories] PRIMARY KEY CLUSTERED ([TerritoryID] ASC)
);