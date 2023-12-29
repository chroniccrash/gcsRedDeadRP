PRINT 'societiesFunctions.sql'

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocieties_GetSocietyByID
-- Parameters: Direct match
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocieties_GetSocietyByID
    @id [varchar](21)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societies WHERE id=@id;
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocieties_GetSocietyByName
-- Parameters: Searches name
-- TODO: Work on wild carded searches...I just need to get this shit out the door for now.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocieties_GetSocietyByName
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societies WHERE name = @name
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocieties_GetSocieties
-- Parameters: Get all societies
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocieties_GetSocieties
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN try
        SELECT * FROM dbo.societies
    END try
    BEGIN catch
        SET @resp = (convert(varchar,ERROR_LINE()) + ERROR_MESSAGE() )
    END catch
END
GO

-- =============================================
-- Author:		Chris Bostwick
-- Create date: 29Dec2023
-- Function: spSocieties_InsertSociety
-- Parameters: Just feed it a name and watch it grow...
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocieties_InsertSociety
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @resp [varchar](200)
    BEGIN TRAN
        BEGIN try
            INSERT INTO dbo.societies (name) VALUES
                (@name)
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
-- Function: spSocieties_UpdateSociety
-- Parameters: Give ID and the name you want to update it with
-- TODO TOP() sounds like a horrible solution... need to verify if that's the official way...fuck this documentation.
-- =============================================
CREATE or ALTER PROCEDURE dbo.spSocieties_UpdateSociety
    @id [varchar](21),
    @name [varchar](50)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @resp [varchar](200)
    BEGIN TRAN T1
        BEGIN try
            UPDATE TOP (1) dbo.societies 
            SET name=@name, timestampModified=GETDATE()
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
