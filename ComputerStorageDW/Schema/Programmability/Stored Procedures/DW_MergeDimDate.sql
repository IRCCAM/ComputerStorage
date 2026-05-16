CREATE PROCEDURE [dbo].[DW_MergeDimDate]
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    IF @StartDate IS NULL OR @EndDate IS NULL OR @StartDate > @EndDate
    BEGIN
        THROW 50001, 'Rango de fechas invalido para DW_MergeDimDate.', 1;
    END;

    ;WITH DateCTE AS
    (
        SELECT @StartDate AS FullDate
        UNION ALL
        SELECT DATEADD(DAY, 1, FullDate)
        FROM DateCTE
        WHERE FullDate < @EndDate
    )
    MERGE INTO [dbo].[DimDate] AS target
    USING
    (
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
    ) AS source
    ON target.[DateKey] = source.[DateKey]

    WHEN MATCHED AND
    (
           target.[FullDate] <> source.[FullDate]
        OR target.[Day] <> source.[Day]
        OR target.[Month] <> source.[Month]
        OR target.[MonthName] <> source.[MonthName]
        OR target.[Quarter] <> source.[Quarter]
        OR target.[Year] <> source.[Year]
        OR target.[WeekOfYear] <> source.[WeekOfYear]
        OR target.[DayOfWeek] <> source.[DayOfWeek]
        OR target.[DayName] <> source.[DayName]
        OR target.[IsWeekend] <> source.[IsWeekend]
    ) THEN
        UPDATE SET
            [FullDate] = source.[FullDate],
            [Day] = source.[Day],
            [Month] = source.[Month],
            [MonthName] = source.[MonthName],
            [Quarter] = source.[Quarter],
            [Year] = source.[Year],
            [WeekOfYear] = source.[WeekOfYear],
            [DayOfWeek] = source.[DayOfWeek],
            [DayName] = source.[DayName],
            [IsWeekend] = source.[IsWeekend]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
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
        VALUES
        (
            source.[DateKey],
            source.[FullDate],
            source.[Day],
            source.[Month],
            source.[MonthName],
            source.[Quarter],
            source.[Year],
            source.[WeekOfYear],
            source.[DayOfWeek],
            source.[DayName],
            source.[IsWeekend]
        )
    OPTION (MAXRECURSION 0);
END
GO
