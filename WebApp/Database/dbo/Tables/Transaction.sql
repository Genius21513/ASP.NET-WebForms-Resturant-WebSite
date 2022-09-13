CREATE TABLE [dbo].[Transaction]
(
	[Id] UNIQUEIDENTIFIER PRIMARY KEY,
	[OrdemId] UNIQUEIDENTIFIER NULL,
	[In] DECIMAL(17,2),
    [Out] DECIMAL(17,2),
    [MethodId] INT DEFAULT 1,
    [Reference] VARCHAR(8000) DEFAULT '-',
    [At] DATETIME DEFAULT getdate()
    
)
