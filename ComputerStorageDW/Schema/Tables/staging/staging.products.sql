CREATE TABLE [staging].[Products] (
    [ProductID]       INT           NOT NULL,
    [ProductName]     NVARCHAR(40)  NOT NULL,
    [SupplierID]      INT           NULL,
    [CategoryID]      INT           NULL,
    [QuantityPerUnit] NVARCHAR(20)  NULL,
    [UnitPrice]       MONEY         NULL,
    [UnitsInStock]    SMALLINT      NULL,
    [UnitsOnOrder]    SMALLINT      NULL,
    [ReorderLevel]    SMALLINT      NULL,
    [Discontinued]    BIT           NOT NULL,
    [RowVersion]      BIGINT        NOT NULL,
    [CreatedDate]     DATETIME      DEFAULT GETDATE(),
    [ModifiedDate]    DATETIME      DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingProducts] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);