﻿CREATE TABLE [dbo].[OrdemItem]
(
	[Id] UNIQUEIDENTIFIER PRIMARY KEY,
	[OrdemId] UNIQUEIDENTIFIER,
	[Price] NUMERIC(17,2),
	[Quant] INT,
	[ProductId] INT
)
