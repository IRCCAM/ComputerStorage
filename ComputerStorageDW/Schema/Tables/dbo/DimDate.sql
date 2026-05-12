CREATE TABLE [dbo].[DimDate]
(
    [DateKey]       INT           NOT NULL,
    [FullDate]      DATE          NOT NULL,
    [Day]           TINYINT       NOT NULL,
    [Month]         TINYINT       NOT NULL,
    [MonthName]     NVARCHAR(20)  NOT NULL,
    [Quarter]       TINYINT       NOT NULL,
    [Year]          SMALLINT      NOT NULL,
    [WeekOfYear]    TINYINT       NOT NULL,
    [DayOfWeek]     TINYINT       NOT NULL,
    [DayName]       NVARCHAR(20)  NOT NULL,
    [IsWeekend]     BIT           NOT NULL,

    CONSTRAINT [PK_DimDate]
        PRIMARY KEY CLUSTERED ([DateKey]),

    CONSTRAINT [UQ_DimDate_FullDate]
        UNIQUE ([FullDate])
);