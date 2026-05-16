IF NOT EXISTS(SELECT TOP(1) 1 FROM [production].[shippers])
BEGIN
    SET IDENTITY_INSERT [production].[shippers] ON;
    
    INSERT [production].[shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (1, N'Speedy Express', N'(503) 555-9831')
    INSERT [production].[shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (2, N'United Package', N'(503) 555-3199')
    INSERT [production].[shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (3, N'Federal Shipping', N'(503) 555-9931')
    
    SET IDENTITY_INSERT [production].[shippers] OFF;
END
GO