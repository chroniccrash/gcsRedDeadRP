PRINT 'createTable_items.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[items](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[label] [varchar](50) NOT NULL,
	[limit] [int] NOT NULL,
    [type_id] [int] NOT NULL,
	[description] [varchar](255) NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
    CONSTRAINT FK_items_itemTypes FOREIGN KEY (type_id) REFERENCES [dbo].[itemTypes] (id) ON DELETE CASCADE ON UPDATE CASCADE,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[items] ADD CONSTRAINT [DF_items_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[items] ADD CONSTRAINT [DF_items_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
