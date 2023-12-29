PRINT 'createTable_characterSnapshots.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[characterSnapshots](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[character_id] [int] NOT NULL,
	[groups] [varchar](25) NOT NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
    CONSTRAINT FK_characterSnapshots_characters FOREIGN KEY (character_id) REFERENCES [dbo].[characters] (id) ON DELETE CASCADE ON UPDATE CASCADE,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[characterSnapshots] ADD CONSTRAINT [DF_characterSnapshots_group] DEFAULT 'user' FOR [groups]
GO

ALTER TABLE [dbo].[characterSnapshots] ADD CONSTRAINT [DF_characterSnapshots_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[characterSnapshots] ADD CONSTRAINT [DF_characterSnapshots_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
