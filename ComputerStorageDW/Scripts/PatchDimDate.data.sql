IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[DimDate]
              WHERE [DateKey] = 0)
BEGIN
    INSERT INTO [dbo].[DimDate]
               ([DateKey]
               ,[FullDate]
               ,[Day]
               ,[Month]
               ,[MonthName]
               ,[Quarter]
               ,[Year]
               ,[WeekOfYear]
               ,[DayOfWeek]
               ,[DayName]
               ,[IsWeekend])
         VALUES
               (0
               ,'1900-01-01'
               ,0
               ,0
               ,''
               ,0
               ,1900
               ,0
               ,0
               ,''
               ,0);
END
GO
