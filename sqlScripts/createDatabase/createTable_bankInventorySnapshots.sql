PRINT 'createTable_bankInventorySnapshot.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[bankInventorySnapshots](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[character_id] [int] NOT NULL,
	[item_id] [int] NOT NULL,
	[metadata] [varchar](255) NULL,
	[count] [int] NOT NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
    CONSTRAINT FK_bankInventorySnapshots_characters FOREIGN KEY (character_id) REFERENCES [dbo].[characters] (id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_bankInventorySnapshots_items FOREIGN KEY (item_id) REFERENCES [dbo].[items] (id) ON DELETE CASCADE ON UPDATE CASCADE
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[bankInventorySnapshots] ADD CONSTRAINT [DF_bankInventorySnapshots_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[bankInventorySnapshots] ADD CONSTRAINT [DF_bankInventorySnapshots_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
