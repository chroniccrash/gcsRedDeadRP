PRINT 'createTable_itemTypes.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[itemTypes](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [game_id] [int] NOT NULL,
	[name] [varchar](50) NOT NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[itemTypes] ADD CONSTRAINT [DF_itemtypes_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[itemTypes] ADD CONSTRAINT [DF_itemtypes_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
