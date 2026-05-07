IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimCustomer')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimCustomer', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimDate')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimDate', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimEmployee')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimEmployee', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimGeography')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimGeography', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimProduct')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimProduct', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeDimShipper')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeDimShipper', 0)
END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
              WHERE [PackageName] = 'DW_MergeFactSales')
BEGIN
    INSERT [dbo].[PackageConfig] ([PackageName], [LastRowVersion]) VALUES ('DW_MergeFactSales', 0)
END
GO