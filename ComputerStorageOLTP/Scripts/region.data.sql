IF NOT EXISTS(SELECT TOP(1) 1 FROM [dbo].[region])
BEGIN
    INSERT [dbo].[region] ([RegionID], [RegionDescription]) VALUES (1, N'Eastern')
    INSERT [dbo].[region] ([RegionID], [RegionDescription]) VALUES (2, N'Western')
    INSERT [dbo].[region] ([RegionID], [RegionDescription]) VALUES (3, N'Northern')
    INSERT [dbo].[region] ([RegionID], [RegionDescription]) VALUES (4, N'Southern')
END
GO