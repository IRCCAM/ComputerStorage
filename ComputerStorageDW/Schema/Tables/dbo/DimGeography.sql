CREATE TABLE [dbo].[DimGeography] (
    [GeographyKey]        INT            IDENTITY(1,1) NOT NULL,
    [TerritoryID_NK]      NVARCHAR(20)   NOT NULL,
    [TerritoryDescription]NCHAR(50)      NOT NULL,
    [RegionID_NK]         INT            NOT NULL,
    [RegionDescription]   NCHAR(50)      NOT NULL,
    [RegionGroup]         VARCHAR(50)    NULL,
    [TerritoryGroup]      VARCHAR(50)    NULL,
    [CreatedDate]         DATETIME       NULL,
    CONSTRAINT [PK_DimGeography] PRIMARY KEY CLUSTERED ([GeographyKey] ASC)
);