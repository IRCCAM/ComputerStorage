DELETE FROM [sales].[employeeterritories];
GO

DELETE FROM [sales].[orderdetails];
GO

DELETE FROM [sales].[orders];
GO
DBCC CHECKIDENT ('[sales].[orders]', RESEED);
GO

DELETE FROM [production].[products];
GO
DBCC CHECKIDENT ('[production].[products]', RESEED);
GO

DELETE FROM [sales].[customers];
GO

DELETE FROM [sales].[employees];
GO
DBCC CHECKIDENT ('[sales].[employees]', RESEED);
GO

DELETE FROM [production].[territories];
GO

DELETE FROM [production].[region];
GO

DELETE FROM [production].[shippers];
GO
DBCC CHECKIDENT ('[production].[shippers]', RESEED);
GO

DELETE FROM [production].[suppliers];
GO
DBCC CHECKIDENT ('[production].[suppliers]', RESEED);
GO

DELETE FROM [production].[categories];
GO
DBCC CHECKIDENT ('[production].[categories]', RESEED);
GO