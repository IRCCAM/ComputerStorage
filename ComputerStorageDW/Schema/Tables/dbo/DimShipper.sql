CREATE TABLE [dbo].[DimShipper] (
    [ShipperKey]      INT            IDENTITY(1,1) NOT NULL,
    [ShipperID_NK]    INT            NOT NULL,
    [CompanyName]     NVARCHAR(40)   NOT NULL,
    [Phone]           NVARCHAR(24)   NULL,
    [ShippingType]    VARCHAR(30)    NULL,
    [AvgDeliveryDays] DECIMAL(5,2)   NULL,
    [IsActive]        BIT            NULL,
    [CreatedDate]     DATETIME       NULL,
    [UpdatedDate]     DATETIME       NULL,
    CONSTRAINT [PK_DimShipper] PRIMARY KEY CLUSTERED ([ShipperKey] ASC)
);