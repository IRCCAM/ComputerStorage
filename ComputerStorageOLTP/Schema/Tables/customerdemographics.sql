CREATE TABLE [dbo].[customerdemographics](
    [CustomerTypeID] NCHAR(10)      NOT NULL,
    [CustomerDesc]   NVARCHAR(MAX)  NULL,
    [rowversion]     ROWVERSION     NULL,
    CONSTRAINT [PK_customerdemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID] ASC)
);
GO