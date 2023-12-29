PRINT 'charactersFunctions.sql'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spCharacters_GetCharacterByID
-- Parameters: Just put in the id, mix and swig
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_GetCharacterByID
    @id [int]
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.characters WHERE id=@id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spCharacters_GetCharacterByUserIDAndCharIdentifier
-- Parameters: Match by knowing the user_id (steam id) and the character identifier.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_GetCharacterByUserIDAndCharIdentifier
    @user_id [varchar](21),
    @character_id [int]
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.characters WHERE character_id=@character_id AND user_id=@user_id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spCharacters_GetCharacterByName
-- Parameters: Lookup by using the first and last name.  Good luck on the special character shit.
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_GetCharacterByName
    @first_name [varchar](50),
    @last_name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.characters WHERE firstname = @first_name AND lastname = @last_name
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spCharacters_GetCharacters
-- Parameters: Get all the characters
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_GetCharacters
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.characters
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spCharacters_InsertCharacter
-- Parameters: All get inserted and no nulls allowed.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_InsertCharacter
    @user_id [varchar](21),
    @character_id [int],
    @first_name [varchar](50),
    @last_name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            INSERT INTO dbo.characters (user_id, character_id, firstname, lastname) VALUES
                (@user_id, @character_id, @first_name, @last_name)
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
-- Function: spCharacters_UpdateCharacter
-- Parameters: Searches steam_name, if fullmatch = 0, 
--  it uses 'like' else it uses '='.  Defaults to full match.
-- TODO TOP() sounds like a horrible solution... need to verify if that's the official way...fuck this documentation.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spCharacters_UpdateCharacter
    @id [int],
    @user_id [varchar](21),
    @character_id [int],
    @first_name [varchar](50),
    @last_name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN TRAN T1
        BEGIN try
            UPDATE TOP (1) dbo.characters 
            SET user_id=@user_id, character_id=@character_id, firstname=@first_name, lastname=@last_name, timestampModified=GETDATE()
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
