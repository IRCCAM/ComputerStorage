IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[DimDate])
BEGIN
    BEGIN TRAN;

    DECLARE @startdate DATE = '1990-01-01',
            @enddate   DATE = '2028-12-31';

    ;WITH DateCTE AS
    (
        SELECT @startdate AS FullDate
        UNION ALL
        SELECT DATEADD(DAY, 1, FullDate)
        FROM DateCTE
        WHERE FullDate < @enddate
    )
    INSERT INTO [dbo].[DimDate]
    (
        [DateKey],
        [FullDate],
        [Day],
        [Month],
        [MonthName],
        [Quarter],
        [Year],
        [WeekOfYear],
        [DayOfWeek],
        [DayName],
        [IsWeekend]
    )
    SELECT
        CONVERT(INT, CONVERT(VARCHAR(8), d.FullDate, 112)) AS [DateKey],
        d.FullDate,
        DATEPART(DAY, d.FullDate) AS [Day],
        DATEPART(MONTH, d.FullDate) AS [Month],
        DATENAME(MONTH, d.FullDate) AS [MonthName],
        DATEPART(QUARTER, d.FullDate) AS [Quarter],
        DATEPART(YEAR, d.FullDate) AS [Year],
        DATEPART(WEEK, d.FullDate) AS [WeekOfYear],
        DATEPART(WEEKDAY, d.FullDate) AS [DayOfWeek],
        DATENAME(WEEKDAY, d.FullDate) AS [DayName],
        CASE WHEN DATEPART(WEEKDAY, d.FullDate) IN (1, 7) THEN 1 ELSE 0 END AS [IsWeekend]
    FROM DateCTE d
    OPTION (MAXRECURSION 0);

    COMMIT TRAN;
END
GO
