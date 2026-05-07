CREATE TABLE [dbo].[PackageConfig] (
    [ConfigID]       INT            IDENTITY(1,1) NOT NULL,
    [PackageName]    NVARCHAR(100)  NOT NULL,
    [LastRowVersion] BIGINT         NOT NULL DEFAULT 0,
    [LastRunDate]    DATETIME       NOT NULL DEFAULT GETDATE(),
    [IsEnabled]      BIT            NOT NULL DEFAULT 1,
    [CreatedDate]    DATETIME       NOT NULL DEFAULT GETDATE(),
    [ModifiedDate]   DATETIME       NOT NULL DEFAULT GETDATE(),
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([ConfigID] ASC)
);
GO

CREATE UNIQUE NONCLUSTERED INDEX [IX_PackageConfig_PackageName]
ON [dbo].[PackageConfig] ([PackageName] ASC);
GO