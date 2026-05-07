CREATE PROCEDURE [dbo].[DW_MergeDimGeography]
    @LastRowVersion BIGINT,
    @CurrentRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Obtener el máximo RowVersion combinado de Region y Territories
    SELECT @CurrentRowVersion = ISNULL(MAX(RowVersion), @LastRowVersion)
    FROM (
        SELECT RowVersion FROM [staging].[Region]
        UNION ALL
        SELECT RowVersion FROM [staging].[Territories]
    ) AS all_versions;
    
    -- MERGE de geografía (Región + Territorio)
    MERGE INTO [dim].[DimGeography] AS target
    USING (
        SELECT 
            t.TerritoryID AS TerritoryID_NK,
            t.TerritoryDescription,
            r.RegionID AS RegionID_NK,
            r.RegionDescription,
            CASE 
                WHEN r.RegionDescription LIKE '%North%' THEN 'North America'
                WHEN r.RegionDescription LIKE '%South%' THEN 'South America'
                WHEN r.RegionDescription LIKE '%Europe%' THEN 'Europe'
                ELSE 'Other'
            END AS RegionGroup,
            CASE 
                WHEN t.TerritoryDescription LIKE '%Boston%' THEN 'New England'
                WHEN t.TerritoryDescription LIKE '%Seattle%' THEN 'Pacific Northwest'
                ELSE 'Standard'
            END AS TerritoryGroup,
            GETDATE() AS CreatedDate,
            ROW_NUMBER() OVER (PARTITION BY t.TerritoryID ORDER BY t.ModifiedDate DESC) AS rn
        FROM [staging].[Territories] t
        INNER JOIN [staging].[Region] r ON t.RegionID = r.RegionID
        WHERE t.RowVersion > @LastRowVersion OR r.RowVersion > @LastRowVersion
    ) AS source
    ON target.TerritoryID_NK = source.TerritoryID_NK AND source.rn = 1
    
    WHEN MATCHED THEN
        UPDATE SET
            TerritoryDescription = source.TerritoryDescription,
            RegionID_NK = source.RegionID_NK,
            RegionDescription = source.RegionDescription,
            RegionGroup = source.RegionGroup,
            TerritoryGroup = source.TerritoryGroup
    
    WHEN NOT MATCHED AND source.rn = 1 THEN
        INSERT (
            TerritoryID_NK, TerritoryDescription, RegionID_NK, RegionDescription,
            RegionGroup, TerritoryGroup, CreatedDate
        )
        VALUES (
            source.TerritoryID_NK, source.TerritoryDescription, source.RegionID_NK, source.RegionDescription,
            source.RegionGroup, source.TerritoryGroup, source.CreatedDate
        );
END