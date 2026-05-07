CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
    @PackageName NVARCHAR(100),
    @LastRowVersion BIGINT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT @LastRowVersion = ISNULL(LastRowVersion, 0)
    FROM [dbo].[PackageConfig]
    WHERE PackageName = @PackageName;
    
    -- Si no existe, insertar registro por defecto
    IF @LastRowVersion IS NULL
    BEGIN
        SET @LastRowVersion = 0;
        INSERT INTO [dbo].[PackageConfig] (PackageName, LastRowVersion, LastRunDate)
        VALUES (@PackageName, 0, GETDATE());
    END
END