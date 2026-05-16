CREATE TABLE [production].[categories] (
    [CategoryID]   INT            IDENTITY(1,1) NOT NULL,
    [CategoryName] NVARCHAR(15)   NOT NULL,
    [Description]  NVARCHAR(MAX)  NULL,
    [Picture]      VARBINARY(MAX) NULL,
    [rowversion]   ROWVERSION     NOT NULL,
    CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_categories_CategoryName]
    ON [production].[categories] ([CategoryName] ASC);
GO