CREATE TABLE [dbo].[Table]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[Description] VARCHAR(200) NOT NULL,
	[Active] BIT DEFAULT 0,
	[Seats] INT DEFAULT 1,
	[CustomerId] INT,
	[HoldOrder] TEXT
)
