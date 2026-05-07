IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dim].[DimDate]
              WHERE [DateKey] = 0)
BEGIN
    INSERT INTO [dim].[DimDate]
               ([DateKey]
               ,[FullDate]
               ,[Year]
               ,[Quarter]
               ,[QuarterName]
               ,[Month]
               ,[MonthName]
               ,[DayOfMonth]
               ,[DayOfWeek]
               ,[DayName]
               ,[WeekOfYear]
               ,[IsWeekend]
               ,[IsHoliday]
               ,[FiscalYear]
               ,[FiscalQuarter])
         VALUES
               (0
               ,GETDATE()
               ,1900
               ,0
               ,''
               ,0
               ,''
               ,0
               ,0
               ,''
               ,0
               ,0
               ,0
               ,1900
               ,0);
END
GO

IF EXISTS(SELECT TOP(1) 1
          FROM [dim].[DimDate]
          WHERE [Month] = 12 AND [DayOfMonth] = 25)
BEGIN
    UPDATE [dim].[DimDate]
    SET [IsHoliday] = 1
    WHERE [Month] = 12 AND [DayOfMonth] = 25
END
GO

IF EXISTS(SELECT TOP(1) 1
          FROM [dim].[DimDate]
          WHERE [Month] = 1 AND [DayOfMonth] = 1)
BEGIN
    UPDATE [dim].[DimDate]
    SET [IsHoliday] = 1
    WHERE [Month] = 1 AND [DayOfMonth] = 1
END
GO

IF EXISTS(SELECT TOP(1) 1
          FROM [dim].[DimDate]
          WHERE [Month] = 7 AND [DayOfMonth] = 4)
BEGIN
    UPDATE [dim].[DimDate]
    SET [IsHoliday] = 1
    WHERE [Month] = 7 AND [DayOfMonth] = 4
END
GO