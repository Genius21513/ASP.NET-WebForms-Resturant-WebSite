/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

IF NOT EXISTS (SELECT 1 FROM [dbo].[User] WHERE [UserName] = 'system')
BEGIN
INSERT INTO [dbo].[User]
           ([UserName]
           ,[HasPw]
           ,[FirstName]
           ,[LastName]
           ,[Email])
     VALUES
           ('system'
           ,'29ac25660e3078e87e3097d3822e50d7'
           ,'system'
           ,'system'
           ,'system@email.com')
END
GO

DECLARE @UserId INT = (SELECT TOP 1 ID FROM [dbo].[User] WHERE [UserName] = 'system')

IF NOT EXISTS (SELECT 1 FROM [dbo].[Settings] WHERE [UserId] = @UserId)
BEGIN
INSERT INTO [dbo].[Settings]
           ([UserId]
           ,[DisplayCategoryCards]
           ,[EnableSounds]
           ,[PageWidth]
           ,[PageHeight]
           ,[PageMargin])
     VALUES
           (@UserId
           ,1
           ,1
           ,150
           ,300
           ,10)
END

GO

IF NOT EXISTS (SELECT 1 FROM MethodPay)
BEGIN
    INSERT INTO MethodPay (Id, Description) VALUES (2,'Open Cash Drawer Amount'),(1,'Cash on Delivery'),(3,'Manual')
END

IF NOT EXISTS (SELECT 1 FROM Product)
BEGIN
INSERT INTO Product
           ([Description]
           ,[Price]
           ,[UrlImg]
           ,[CategoryId])
     VALUES
           ('Cheese Burger'
           ,120
           ,''
           ,1),
		   ('Chicken Burger'
           ,120
           ,''
           ,1)
END
GO

IF NOT EXISTS (SELECT 1 FROM [Customer])
BEGIN
INSERT INTO [Customer]
           ([FirstName]
           ,[LastName]
           ,[Email]
           ,[PhoneNumber]
           ,[Address1]
           ,[Address2]
           ,[CountryId]
           ,[StateId]
           ,[CityId]
           ,[PostalCode])
     VALUES
           ('Customer'
           ,'Customer'
           ,'email@email.com'
           ,'88888888'
           ,'Address1'
           ,'Address2'
           ,1
           ,1
           ,1
           ,1)
END
GO

IF NOT EXISTS (SELECT 1 FROM [Category])
BEGIN
    INSERT INTO [dbo].[Category]
           ([Description]
           ,[UrlImg])
     VALUES
           ('Category 1'
           ,'')
END