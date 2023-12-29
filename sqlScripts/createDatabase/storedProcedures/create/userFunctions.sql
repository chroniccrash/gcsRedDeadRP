SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris Bostwick
-- Create date: 28Dec2023
-- Function: spUsers_InsertUser
-- Parameters: the only required is the steam ID
-- =============================================
CREATE or ALTER PROCEDURE dbo.spUsers_InsertUser
    @steam_id [varchar](21),
    @steam_name [varchar](50) = NULL,
    @handle_id [int] = NULL,
    @discord_id [int] = NULL,
    @email_id [int] = NULL
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            INSERT INTO dbo.users (id, steam_name, handle_id, discord_id, email_id) VALUES
                (@steam_id, @steam_name, @handle_id, @discord_id, @email_id)
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
-- Create date: 28Dec2023
-- Function: spUsers_GetUserByID
-- Parameters: Direct match
-- =============================================
CREATE or ALTER PROCEDURE dbo.spUsers_GetUserByID
    @steam_id [varchar](21)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM USERS WHERE id=@steam_id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 28Dec2023
-- Function: spUsers_GetUserByName
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spUsers_GetUserByName
    @steam_name [varchar](50),
    @fullmatch [bit] = 1
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        IF @fullmatch = 0
            SELECT * FROM dbo.users WHERE steam_name like '%@steam_name'
        ELSE
            SELECT * FROM dbo.users WHERE steam_name=@steam_name
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 28Dec2023
-- Function: spUsers_GetUserByName
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spUsers_GetUsers
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.users
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 28Dec2023
-- Function: spUsers_GetUserByID
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO TOP() sounds like a horrible solution... need to verify if that's the official way...fuck this documentation.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spUsers_UpdateUser
    @id [varchar](21),
    @steam_name [varchar](50) = NULL,
    @handle_id [int] = NULL,
    @discord_id [int] = NULL,
    @email_id [int] = NULL
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            UPDATE TOP (1) dbo.users 
            SET steam_name=@steam_name, handle_id=@handle_id, discord_id=@discord_id, email_id=@email_id, timestampModified=GETDATE()
            WHERE id=@id
            COMMIT TRAN
        END try
        BEGIN catch
            ROLLBACK TRAN
            SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
        END catch
END
GO