CREATE TABLE [dbo].[region](
    [RegionID]          INT           NOT NULL,
    [RegionDescription] NCHAR(50)     NOT NULL,
    [rowversion]        ROWVERSION    NULL,
    CONSTRAINT [PK_region] PRIMARY KEY NONCLUSTERED ([RegionID] ASC)
);
GO