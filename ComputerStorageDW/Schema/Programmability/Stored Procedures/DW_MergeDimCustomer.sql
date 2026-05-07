CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion de staging
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM [staging].[Customers];
    
    -- MERGE de clientes
    MERGE INTO [dim].[DimCustomer] AS target
    USING (
        SELECT 
            CustomerID AS CustomerID_NK,
            CompanyName,
            ContactName,
            ContactTitle,
            Address,
            City,
            Region,
            PostalCode,
            Country,
            Phone,
            Fax,
            NULL AS CustomerTypeID,
            NULL AS CustomerTypeDesc,
            NULL AS CustomerSegment,
            NULL AS FirstOrderDate,
            NULL AS LastOrderDate,
            NULL AS TotalOrders,
            NULL AS LifetimeValue,
            1 AS IsActive,
            GETDATE() AS CreatedDate,
            GETDATE() AS UpdatedDate,
            ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY ModifiedDate DESC) AS rn
        FROM [staging].[Customers]
        WHERE RowVersion > @LastRowVersion
    ) AS source
    ON target.CustomerID_NK = source.CustomerID_NK AND source.rn = 1
    
    WHEN MATCHED AND target.UpdatedDate < source.UpdatedDate THEN
        UPDATE SET
            CompanyName = source.CompanyName,
            ContactName = source.ContactName,
            ContactTitle = source.ContactTitle,
            Address = source.Address,
            City = source.City,
            Region = source.Region,
            PostalCode = source.PostalCode,
            Country = source.Country,
            Phone = source.Phone,
            Fax = source.Fax,
            UpdatedDate = source.UpdatedDate
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            CustomerID_NK, CompanyName, ContactName, ContactTitle,
            Address, City, Region, PostalCode, Country, Phone, Fax,
            CustomerTypeID, CustomerTypeDesc, CustomerSegment,
            FirstOrderDate, LastOrderDate, TotalOrders, LifetimeValue,
            IsActive, CreatedDate, UpdatedDate
        )
        VALUES (
            source.CustomerID_NK, source.CompanyName, source.ContactName, source.ContactTitle,
            source.Address, source.City, source.Region, source.PostalCode, source.Country, source.Phone, source.Fax,
            source.CustomerTypeID, source.CustomerTypeDesc, source.CustomerSegment,
            source.FirstOrderDate, source.LastOrderDate, source.TotalOrders, source.LifetimeValue,
            source.IsActive, source.CreatedDate, source.UpdatedDate
        );
END