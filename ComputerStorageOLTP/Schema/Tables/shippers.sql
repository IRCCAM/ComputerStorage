CREATE TABLE [production].[shippers] (
    [ShipperID]   INT           IDENTITY(1,1) NOT NULL,
    [CompanyName] NVARCHAR(40)  NOT NULL,
    [Phone]       NVARCHAR(24)  NULL,
    [rowversion]  ROWVERSION    NULL,
    CONSTRAINT [PK_shippers] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
);
GO