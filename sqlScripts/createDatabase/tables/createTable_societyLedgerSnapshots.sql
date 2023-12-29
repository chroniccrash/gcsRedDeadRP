PRINT 'createTable_societyLedgerSnapshot.sql:'

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[societyLedgerSnapshots](
	[id] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[society_id] [int] NOT NULL,
    [money] [float] DEFAULT(0.00) NULL,
	[timestampCreated] [datetime2](7) NOT NULL,
	[timestampModified] [datetime2](7) NOT NULL,
    CONSTRAINT FK_societyLedgerSnapshots_societies FOREIGN KEY (society_id) REFERENCES [dbo].[societies] (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[societyLedgerSnapshots] ADD CONSTRAINT [DF_societyLedgerSnapshots_timestampcreated] DEFAULT (GETDATE()) FOR [timestampCreated]
GO

ALTER TABLE [dbo].[societyLedgerSnapshots] ADD CONSTRAINT [DF_societyLedgerSnapshots_timestampmodified] DEFAULT (GETDATE()) FOR [timestampModified]
GO
