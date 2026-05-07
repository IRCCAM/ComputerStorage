CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
    @PackageName NVARCHAR(100),
    @LastRowVersion BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE [dbo].[PackageConfig]
    SET LastRowVersion = @LastRowVersion,
        LastRunDate = GETDATE()
    WHERE PackageName = @PackageName;
    
    -- Si no existe, insertar
    IF @@ROWCOUNT = 0
    BEGIN
        INSERT INTO [dbo].[PackageConfig] (PackageName, LastRowVersion, LastRunDate)
        VALUES (@PackageName, @LastRowVersion, GETDATE());
    END
END