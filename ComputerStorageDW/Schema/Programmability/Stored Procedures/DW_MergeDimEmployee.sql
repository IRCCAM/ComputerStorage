CREATE PROCEDURE [dbo].[DW_MergeDimEmployee]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO [dbo].[DimEmployee] AS target
    USING
    (
        SELECT
            e.[EmployeeID],
            e.[FirstName],
            e.[LastName],
            CAST(e.[FirstName] + N' ' + e.[LastName] AS NVARCHAR(60)) AS [FullName],
            e.[Title],
            e.[TitleOfCourtesy],
            CAST(e.[BirthDate] AS DATE) AS [BirthDate],
            CAST(e.[HireDate] AS DATE) AS [HireDate],
            e.[City],
            e.[Region],
            e.[Country],
            e.[ReportsTo] AS [ReportsToEmployeeID]
        FROM [staging].[Employee] e
    ) AS source
    ON target.[EmployeeID] = source.[EmployeeID]

    WHEN MATCHED AND
    (
           ISNULL(target.[FullName], N'') <> ISNULL(source.[FullName], N'')
        OR ISNULL(target.[FirstName], N'') <> ISNULL(source.[FirstName], N'')
        OR ISNULL(target.[LastName], N'') <> ISNULL(source.[LastName], N'')
        OR ISNULL(target.[Title], N'') <> ISNULL(source.[Title], N'')
        OR ISNULL(target.[TitleOfCourtesy], N'') <> ISNULL(source.[TitleOfCourtesy], N'')
        OR ISNULL(target.[BirthDate], '19000101') <> ISNULL(source.[BirthDate], '19000101')
        OR ISNULL(target.[HireDate], '19000101') <> ISNULL(source.[HireDate], '19000101')
        OR ISNULL(target.[City], N'') <> ISNULL(source.[City], N'')
        OR ISNULL(target.[Region], N'') <> ISNULL(source.[Region], N'')
        OR ISNULL(target.[Country], N'') <> ISNULL(source.[Country], N'')
        OR ISNULL(target.[ReportsToEmployeeID], -1) <> ISNULL(source.[ReportsToEmployeeID], -1)
    ) THEN
        UPDATE SET
            [FullName] = source.[FullName],
            [FirstName] = source.[FirstName],
            [LastName] = source.[LastName],
            [Title] = source.[Title],
            [TitleOfCourtesy] = source.[TitleOfCourtesy],
            [BirthDate] = source.[BirthDate],
            [HireDate] = source.[HireDate],
            [City] = source.[City],
            [Region] = source.[Region],
            [Country] = source.[Country],
            [ReportsToEmployeeID] = source.[ReportsToEmployeeID]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [EmployeeID],
            [FullName],
            [FirstName],
            [LastName],
            [Title],
            [TitleOfCourtesy],
            [BirthDate],
            [HireDate],
            [City],
            [Region],
            [Country],
            [ReportsToEmployeeID]
        )
        VALUES
        (
            source.[EmployeeID],
            source.[FullName],
            source.[FirstName],
            source.[LastName],
            source.[Title],
            source.[TitleOfCourtesy],
            source.[BirthDate],
            source.[HireDate],
            source.[City],
            source.[Region],
            source.[Country],
            source.[ReportsToEmployeeID]
        );
END
GO
