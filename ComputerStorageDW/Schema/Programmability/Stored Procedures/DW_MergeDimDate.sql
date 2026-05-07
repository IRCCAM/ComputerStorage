CREATE PROCEDURE [dbo].[DW_MergeDimDate]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CurrentDate DATE = @StartDate;
    DECLARE @DateKey INT;
    
    WHILE @CurrentDate <= @EndDate
    BEGIN
        SET @DateKey = CONVERT(INT, FORMAT(@CurrentDate, 'yyyyMMdd'));
        
        MERGE INTO [dim].[DimDate] AS target
        USING (
            SELECT
                @DateKey AS DateKey,
                @CurrentDate AS FullDate,
                YEAR(@CurrentDate) AS Year,
                DATEPART(QUARTER, @CurrentDate) AS Quarter,
                'Q' + CAST(DATEPART(QUARTER, @CurrentDate) AS VARCHAR) + ' ' + CAST(YEAR(@CurrentDate) AS VARCHAR) AS QuarterName,
                MONTH(@CurrentDate) AS Month,
                DATENAME(MONTH, @CurrentDate) AS MonthName,
                DAY(@CurrentDate) AS DayOfMonth,
                DATEPART(WEEKDAY, @CurrentDate) AS DayOfWeek,
                DATENAME(WEEKDAY, @CurrentDate) AS DayName,
                DATEPART(WEEK, @CurrentDate) AS WeekOfYear,
                CASE WHEN DATEPART(WEEKDAY, @CurrentDate) IN (1,7) THEN 1 ELSE 0 END AS IsWeekend,
                0 AS IsHoliday,
                CASE WHEN MONTH(@CurrentDate) >= 7 THEN YEAR(@CurrentDate) + 1 ELSE YEAR(@CurrentDate) END AS FiscalYear,
                CASE 
                    WHEN MONTH(@CurrentDate) BETWEEN 7 AND 9 THEN 1
                    WHEN MONTH(@CurrentDate) BETWEEN 10 AND 12 THEN 2
                    WHEN MONTH(@CurrentDate) BETWEEN 1 AND 3 THEN 3
                    ELSE 4
                END AS FiscalQuarter
        ) AS source
        ON target.DateKey = source.DateKey
        
        WHEN MATCHED THEN
            UPDATE SET
                FullDate = source.FullDate,
                Year = source.Year,
                Quarter = source.Quarter,
                QuarterName = source.QuarterName,
                Month = source.Month,
                MonthName = source.MonthName,
                DayOfMonth = source.DayOfMonth,
                DayOfWeek = source.DayOfWeek,
                DayName = source.DayName,
                WeekOfYear = source.WeekOfYear,
                IsWeekend = source.IsWeekend,
                IsHoliday = source.IsHoliday,
                FiscalYear = source.FiscalYear,
                FiscalQuarter = source.FiscalQuarter
        
        WHEN NOT MATCHED THEN
            INSERT (
                DateKey, FullDate, Year, Quarter, QuarterName,
                Month, MonthName, DayOfMonth, DayOfWeek, DayName,
                WeekOfYear, IsWeekend, IsHoliday, FiscalYear, FiscalQuarter
            )
            VALUES (
                source.DateKey, source.FullDate, source.Year, source.Quarter, source.QuarterName,
                source.Month, source.MonthName, source.DayOfMonth, source.DayOfWeek, source.DayName,
                source.WeekOfYear, source.IsWeekend, source.IsHoliday, source.FiscalYear, source.FiscalQuarter
            );
        
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END