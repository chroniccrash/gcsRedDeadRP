PRINT 'createTable_society.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[societies](
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[name] [varchar](50) NOT NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[societies] ADD CONSTRAINT [DF_societies_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[societies] ADD CONSTRAINT [DF_societies_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
