PRINT 'societyLedgerSnapshotsFunctions.sql'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocietyLedgerSnapshots_GetSocietyLedgerSnapshotByID
-- Parameters: Direct match
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocietyLedgerSnapshots_GetSocietyLedgerSnapshotByID
    @id [int]
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societyLedgerSnapshots WHERE id=@id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocietyLedgerSnapshots_GetSocietyLedgerSnapshotBySocietyName
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocietyLedgerSnapshots_GetSocietyLedgerSnapshotBySocietyName
    @society_name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societyLedgerSnapshots ledger
        right join dbo.societies society on ledger.society_id = society.id
        WHERE society.name = @society_name
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocietyLedgerSnapshots_GetSocietyLedgerSnapshots
-- Parameters: Get them ledgers
--  it uses 'like' else it uses '='.  Defaults to full match.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocietyLedgerSnapshots_GetSocietyLedgerSnapshots
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societyLedgerSnapshots
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocietyLedgerSnapshots_InsertSocietyLedgerSnapshot
-- Parameters: the only required is the steam ID
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocietyLedgerSnapshots_InsertSocietyLedgerSnapshot
    @society_id [int],
    @money [float] = 0.00
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            INSERT INTO dbo.societyLedgerSnapshots (society_id, money) VALUES
                (@society_id, @money)
            COMMIT TRAN
        END try
        BEGIN catch
            ROLLBACK TRAN
            SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
        END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocietyLedgerSnapshots_UpdateSocietyLedgerSnapshot
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO TOP() sounds like a horrible solution... need to verify if that's the official way...fuck this documentation.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocietyLedgerSnapshots_UpdateSocietyLedgerSnapshot
    @id [int],
    @money [float] = 0.00
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN TRAN T1
        BEGIN try
            UPDATE TOP (1) dbo.societyLedgerSnapshots 
            SET money=@money, timestampModified=GETDATE()
            WHERE id=@id
            COMMIT TRAN T1
        END try
        BEGIN catch
            ROLLBACK TRAN T1
            SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
        END catch
    PRINT @resp
END
GO
