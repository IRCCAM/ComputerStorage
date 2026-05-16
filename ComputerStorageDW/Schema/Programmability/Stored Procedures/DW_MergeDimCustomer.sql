CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE INTO [dbo].[DimCustomer] AS target
    USING
    (
        SELECT
            c.[CustomerID],
            c.[CompanyName],
            c.[ContactName],
            c.[ContactTitle],
            c.[Address],
            c.[City],
            c.[Region],
            c.[PostalCode],
            c.[Country],
            c.[Phone],
            c.[Fax]
        FROM [staging].[Customer] c
    ) AS source
    ON target.[CustomerID] = source.[CustomerID]

    WHEN MATCHED AND
    (
           ISNULL(target.[CompanyName], N'') <> ISNULL(source.[CompanyName], N'')
        OR ISNULL(target.[ContactName], N'') <> ISNULL(source.[ContactName], N'')
        OR ISNULL(target.[ContactTitle], N'') <> ISNULL(source.[ContactTitle], N'')
        OR ISNULL(target.[Address], N'') <> ISNULL(source.[Address], N'')
        OR ISNULL(target.[City], N'') <> ISNULL(source.[City], N'')
        OR ISNULL(target.[Region], N'') <> ISNULL(source.[Region], N'')
        OR ISNULL(target.[PostalCode], N'') <> ISNULL(source.[PostalCode], N'')
        OR ISNULL(target.[Country], N'') <> ISNULL(source.[Country], N'')
        OR ISNULL(target.[Phone], N'') <> ISNULL(source.[Phone], N'')
        OR ISNULL(target.[Fax], N'') <> ISNULL(source.[Fax], N'')
    ) THEN
        UPDATE SET
            [CompanyName] = source.[CompanyName],
            [ContactName] = source.[ContactName],
            [ContactTitle] = source.[ContactTitle],
            [Address] = source.[Address],
            [City] = source.[City],
            [Region] = source.[Region],
            [PostalCode] = source.[PostalCode],
            [Country] = source.[Country],
            [Phone] = source.[Phone],
            [Fax] = source.[Fax]

    WHEN NOT MATCHED BY TARGET THEN
        INSERT
        (
            [CustomerID],
            [CompanyName],
            [ContactName],
            [ContactTitle],
            [Address],
            [City],
            [Region],
            [PostalCode],
            [Country],
            [Phone],
            [Fax]
        )
        VALUES
        (
            source.[CustomerID],
            source.[CompanyName],
            source.[ContactName],
            source.[ContactTitle],
            source.[Address],
            source.[City],
            source.[Region],
            source.[PostalCode],
            source.[Country],
            source.[Phone],
            source.[Fax]
        );
END
GO
