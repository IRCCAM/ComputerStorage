CREATE TABLE [staging].[Categories] (
    [CategoryID]   INT           NOT NULL,
    [CategoryName] NVARCHAR(15)  NOT NULL,
    [Description]  NTEXT         NULL,
    [Picture]      IMAGE         NULL,
    [RowVersion]   BIGINT        NOT NULL,
    [CreatedDate]  DATETIME      DEFAULT GETDATE(),
    [ModifiedDate] DATETIME      DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingCategories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);