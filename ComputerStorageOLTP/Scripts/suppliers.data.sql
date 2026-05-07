IF NOT EXISTS(SELECT TOP(1) 1 FROM [dbo].[suppliers])
BEGIN
    SET IDENTITY_INSERT [dbo].[suppliers] ON;
    
    INSERT [dbo].[suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (1, N'Exotic Liquids', N'Charlotte Cooper', N'Purchasing Manager', N'49 Gilbert St.', N'London', NULL, N'EC1 4SD', N'UK', N'(171) 555-2222', NULL, NULL)
    INSERT [dbo].[suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (2, N'New Orleans Cajun Delights', N'Shelley Burke', N'Order Administrator', N'P.O. Box 78934', N'New Orleans', N'LA', N'70117', N'USA', N'(100) 555-4822', NULL, N'#CAJUN.HTM#')
    INSERT [dbo].[suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (3, N'Grandma Kelly''s Homestead', N'Regina Murphy', N'Sales Representative', N'707 Oxford Rd.', N'Ann Arbor', N'MI', N'48104', N'USA', N'(313) 555-5735', N'(313) 555-3349', NULL)
    INSERT [dbo].[suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (4, N'Tokyo Traders', N'Yoshi Nagase', N'Marketing Manager', N'9-8 Sekimai Musashino-shi', N'Tokyo', NULL, N'100', N'Japan', N'(03) 3555-5011', NULL, NULL)
    INSERT [dbo].[suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (5, N'Cooperativa de Quesos ''Las Cabras''', N'Antonio del Valle Saavedra', N'Export Administrator', N'Calle del Rosal 4', N'Oviedo', N'Asturias', N'33007', N'Spain', N'(98) 598 76 54', NULL, NULL)
    
    SET IDENTITY_INSERT [dbo].[suppliers] OFF;
END
GO