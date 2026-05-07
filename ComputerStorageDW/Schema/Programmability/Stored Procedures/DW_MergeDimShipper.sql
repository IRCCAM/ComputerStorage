CREATE PROCEDURE [dbo].[DW_MergeDimShipper]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion de staging
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM [staging].[Shippers];
    
    -- MERGE de transportistas
    MERGE INTO [dim].[DimShipper] AS target
    USING (
        SELECT 
            ShipperID AS ShipperID_NK,
            CompanyName,
            Phone,
            CASE 
                WHEN CompanyName LIKE '%Speedy%' THEN 'Express'
                WHEN CompanyName LIKE '%United%' THEN 'Ground'
                ELSE 'Standard'
            END AS ShippingType,
            NULL AS AvgDeliveryDays,
            1 AS IsActive,
            GETDATE() AS CreatedDate,
            GETDATE() AS UpdatedDate,
            ROW_NUMBER() OVER (PARTITION BY ShipperID ORDER BY ModifiedDate DESC) AS rn
        FROM [staging].[Shippers]
        WHERE RowVersion > @LastRowVersion
    ) AS source
    ON target.ShipperID_NK = source.ShipperID_NK AND source.rn = 1
    
    WHEN MATCHED AND target.UpdatedDate < source.UpdatedDate THEN
        UPDATE SET
            CompanyName = source.CompanyName,
            Phone = source.Phone,
            ShippingType = source.ShippingType,
            UpdatedDate = source.UpdatedDate
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            ShipperID_NK, CompanyName, Phone, ShippingType, AvgDeliveryDays,
            IsActive, CreatedDate, UpdatedDate
        )
        VALUES (
            source.ShipperID_NK, source.CompanyName, source.Phone, source.ShippingType, source.AvgDeliveryDays,
            source.IsActive, source.CreatedDate, source.UpdatedDate
        );
END