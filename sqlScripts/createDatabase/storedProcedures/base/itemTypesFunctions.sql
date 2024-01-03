PRINT 'itemTypesFunctions.sql'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris Bostwick
-- Create date: 30Dec2023
-- Function: spItemTypes_GetItemTypeByID
-- Parameters: Direct match
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_GetItemTypeByID
    @id [int]
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.itemTypes WHERE id=@id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 30Dec2023
-- Function: spItemTypes_GetItemTypeByName
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_GetItemTypeByName
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.itemTypes WHERE name = @name
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 30Dec2023
-- Function: spItemTypes_GetItemTypeByGameID
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_GetItemTypeByGameID
    @game_id [int]
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.itemTypes WHERE game_id = @game_id
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 30Dec2023
-- Function: spItemTypes_GetItemTypes
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_GetItemTypes
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.itemTypes
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 30Dec2023
-- Function: spItemTypes_InsertItemType
-- Parameters: the only required is the steam ID
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_InsertItemType
    @game_id [int] = NULL,
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            INSERT INTO dbo.itemTypes (game_id, name) VALUES
                (@game_id, @name)
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
-- Create date: 30Dec2023
-- Function: spItemTypes_UpdateItemType
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO TOP() sounds like a horrible solution... need to verify if that's the official way...fuck this documentation.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spItemTypes_UpdateItemType
    @id [int],
    @game_id [int] = NULL,
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN TRAN T1
        BEGIN try
            UPDATE TOP (1) dbo.itemTypes 
            SET game_id=@game_id, name=@name, timestampModified=GETDATE()
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
