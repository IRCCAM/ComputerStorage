CREATE TABLE [dbo].[DimDate] (
    [DateKey]       INT           NOT NULL,
    [FullDate]      DATE          NOT NULL,
    [Year]          INT           NOT NULL,
    [Quarter]       INT           NOT NULL,
    [QuarterName]   VARCHAR(10)   NOT NULL,
    [Month]         INT           NOT NULL,
    [MonthName]     VARCHAR(20)   NOT NULL,
    [DayOfMonth]    INT           NOT NULL,
    [DayOfWeek]     INT           NOT NULL,
    [DayName]       VARCHAR(20)   NOT NULL,
    [WeekOfYear]    INT           NOT NULL,
    [IsWeekend]     BIT           NOT NULL,
    [IsHoliday]     BIT           NOT NULL,
    [FiscalYear]    INT           NULL,
    [FiscalQuarter] INT           NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);