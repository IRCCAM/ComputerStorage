CREATE TABLE stocks
(
	[store_id]   [int]       NOT NULL,
	[product_id] [int]       NOT NULL,
	[quantity]   [int]       NULL,
	[rowversion] [timestamp] NOT NULL
);
GO

ALTER TABLE stocks ADD CONSTRAINT PK_stocks PRIMARY KEY(store_id, product_id);
GO

ALTER TABLE stocks ADD CONSTRAINT FK_stocks_products  FOREIGN KEY([product_id]) REFERENCES products ([product_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE stocks ADD CONSTRAINT FK_stocks_stores FOREIGN KEY([store_id]) REFERENCES stores ([store_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO