IF NOT EXISTS(SELECT TOP(1) 1 FROM [dbo].[categories])
BEGIN
    SET IDENTITY_INSERT [dbo].[categories] ON;
    
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (3, N'Confections', N'Desserts, candies, and sweet breads', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (4, N'Dairy Products', N'Cheeses', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (6, N'Meat/Poultry', N'Prepared meats', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (7, N'Produce', N'Dried fruit and bean curd', NULL)
    INSERT [dbo].[categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (8, N'Seafood', N'Seaweed and fish', NULL)
    
    SET IDENTITY_INSERT [dbo].[categories] OFF;
END
GO