CREATE TABLE [production].[categories](
    [CategoryID]   INT            IDENTITY(1,1) NOT NULL,
    [CategoryName] NVARCHAR(15)   NOT NULL,
    [Description]  NVARCHAR(MAX)  NULL,
    [Picture]      IMAGE          NULL,
    [rowversion]   ROWVERSION     NULL,
    CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO

CREATE NONCLUSTERED INDEX [IX_categories_CategoryName] ON [dbo].[categories]([CategoryName] ASC);
GO