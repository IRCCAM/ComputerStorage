IF NOT EXISTS(SELECT TOP(1) 1 FROM [production].[region])
BEGIN
    INSERT [production].[region] ([RegionID], [RegionDescription]) VALUES (1, N'Eastern')
    INSERT [production].[region] ([RegionID], [RegionDescription]) VALUES (2, N'Western')
    INSERT [production].[region] ([RegionID], [RegionDescription]) VALUES (3, N'Northern')
    INSERT [production].[region] ([RegionID], [RegionDescription]) VALUES (4, N'Southern')
END
GO