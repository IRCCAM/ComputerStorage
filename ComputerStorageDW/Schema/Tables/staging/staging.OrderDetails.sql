CREATE TABLE [staging].[OrderDetails] (
    [OrderID]   INT      NOT NULL,
    [ProductID] INT      NOT NULL,
    [UnitPrice] MONEY    NOT NULL,
    [Quantity]  SMALLINT NOT NULL,
    [Discount]  REAL     NOT NULL,
    [RowVersion] BIGINT  NOT NULL,
    [CreatedDate]  DATETIME DEFAULT GETDATE(),
    [ModifiedDate] DATETIME DEFAULT GETDATE(),
    CONSTRAINT [PK_StagingOrderDetails] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC)
);