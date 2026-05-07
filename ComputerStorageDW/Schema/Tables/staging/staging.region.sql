CREATE TABLE [staging].[Region] (
    [RegionID]          INT           NOT NULL,
    [RegionDescription] NCHAR(50)     NOT NULL,
    [RowVersion]        BIGINT        NOT NULL,
    [CreatedDate]       DATETIME      DEFAULT GETDATE(),
    [ModifiedDate]      DATETIME      DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingRegion] PRIMARY KEY CLUSTERED ([RegionID] ASC)
);