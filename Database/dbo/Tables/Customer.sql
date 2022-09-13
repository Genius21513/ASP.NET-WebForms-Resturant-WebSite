CREATE TABLE [dbo].[Customer]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),	
    [FirstName] VARCHAR(20) NOT NULL,
    [LastName] VARCHAR(20) NOT NULL,
    [Email] VARCHAR(20) NOT NULL,
    [PhoneNumber] VARCHAR(20) NOT NULL,
    [Address1] VARCHAR(20) NOT NULL,
    [Address2] VARCHAR(20) NOT NULL,
    [CountryId] INT NOT NULL,
    [StateId] INT NOT NULL,
    [CityId] INT NOT NULL,
    [PostalCode] VARCHAR(20) NOT NULL
)
