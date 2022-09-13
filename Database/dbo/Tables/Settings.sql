CREATE TABLE [dbo].[Settings]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (1,1),
	[UserId] INT NOT NULL,
	[DisplayCategoryCards] BIT NOT NULL,
	[EnableSounds] BIT NOT NULL,
	[PageWidth] INT NOT NULL DEFAULT(150),
	[PageHeight] INT NOT NULL DEFAULT(300),
	[PageMargin] INT NOT NULL DEFAULT(10)
)
