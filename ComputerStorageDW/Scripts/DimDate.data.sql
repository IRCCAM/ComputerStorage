IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dim].[DimDate])
BEGIN
    BEGIN TRAN 
        DECLARE @startdate DATE = '1990-01-01',
                @enddate   DATE = '2028-12-31';
        DECLARE @datelist TABLE(FullDate DATE);

    IF @startdate IS NULL
        BEGIN
            SELECT TOP 1 
                   @startdate = FullDate
            FROM dim.DimDate 
            ORDER By DateKey ASC;
        END

    WHILE (@startdate <= @enddate)
    BEGIN 
        INSERT INTO @datelist(FullDate)
        SELECT @startdate

        SET @startdate = DATEADD(dd,1,@startdate);
    END

    INSERT INTO dim.DimDate(DateKey, FullDate, Year, Quarter, QuarterName, Month, MonthName, DayOfMonth, DayOfWeek, DayName, WeekOfYear, IsWeekend, IsHoliday, FiscalYear, FiscalQuarter)
    SELECT DateKey           = CONVERT(INT,CONVERT(VARCHAR,dl.FullDate,112))
          ,FullDate          = dl.FullDate
          ,Year              = YEAR(dl.FullDate)
          ,Quarter           = DATEPART(qq, dl.FullDate)
          ,QuarterName       = 'Q' + CAST(DATEPART(qq, dl.FullDate) AS VARCHAR) + ' ' + CAST(YEAR(dl.FullDate) AS VARCHAR)
          ,Month             = MONTH(dl.FullDate)
          ,MonthName         = DATENAME(MONTH, dl.FullDate)
          ,DayOfMonth        = DAY(dl.FullDate)
          ,DayOfWeek         = DATEPART(dw, dl.FullDate)
          ,DayName           = DATENAME(WEEKDAY, dl.FullDate)
          ,WeekOfYear        = DATEPART(wk, dl.FullDate)
          ,IsWeekend         = CASE WHEN DATEPART(dw, dl.FullDate) IN (1,7) THEN 1 ELSE 0 END
          ,IsHoliday         = 0
          ,FiscalYear        = CASE WHEN MONTH(dl.FullDate) >= 7 THEN YEAR(dl.FullDate) + 1 ELSE YEAR(dl.FullDate) END
          ,FiscalQuarter     = CASE 
                                  WHEN MONTH(dl.FullDate) BETWEEN 7 AND 9 THEN 1
                                  WHEN MONTH(dl.FullDate) BETWEEN 10 AND 12 THEN 2
                                  WHEN MONTH(dl.FullDate) BETWEEN 1 AND 3 THEN 3
                                  ELSE 4
                               END
    FROM @datelist dl 
    LEFT OUTER JOIN dim.DimDate dd ON (dl.FullDate = dd.FullDate)
    WHERE dd.FullDate IS NULL;
    COMMIT TRAN
END
GO