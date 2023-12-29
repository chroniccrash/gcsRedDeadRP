PRINT 'createTable_characters.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[characters](
	[id] [int] PRIMARY KEY NOT NULL,
	[user_id] [varchar](21) NOT NULL,
	[character_id] [int] NOT NULL,
	[firstname] [varchar](50) NOT NULL,
	[lastname] [varchar](50) NOT NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
	CONSTRAINT AK_userId_characterId UNIQUE(user_id, character_id),
    CONSTRAINT FK_characters_users FOREIGN KEY (user_id) REFERENCES [dbo].[users] (id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[characters] ADD CONSTRAINT [DF_characters_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[characters] ADD CONSTRAINT [DF_characters_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
