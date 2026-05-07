CREATE TABLE [staging].[Shippers] (
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR(40)  NOT NULL,
    [Phone]       NVARCHAR(24)  NULL,
    [RowVersion]  BIGINT        NOT NULL,
    [CreatedDate] DATETIME      DEFAULT GETDATE(),
    [ModifiedDate] DATETIME     DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingShippers] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
);