PRINT 'createTable_users.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[users](
	[id] [varchar](21) PRIMARY KEY NOT NULL,
	[steam_name] [varchar](50) NULL,
	[handle_id] [int] NULL,
	[discord_id] [int] NULL,
	[email_id] [int] NULL,
	[lastLogin] [datetime2](7) NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[users] ADD CONSTRAINT [DF_users_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[users] ADD CONSTRAINT [DF_users_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
