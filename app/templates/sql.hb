USE [{{sqlDatabaseName}}]
GO

{{#each tables}}

/****** Object:  Table [dbo].[{{sqlTableName}}]    Script Date: 11/26/2012 13:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[{{sqlTableName}}](
             [{{ sqlIdName }}ID] int IDENTITY(1,1) NOT NULL{{#each fields}}
            ,{{sqlFieldName}} {{type}} NOT NULL{{/each}}
            ,[Created] datetime NOT NULL
            ,[LastModified] datetime NOT NULL
CONSTRAINT [PK_{{sqlTableName}}] PRIMARY KEY CLUSTERED
(
    [{{ sqlIdName }}ID] ASC
) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 60) ON [PRIMARY]
GO


/****** Object:  StoredProcedure [dbo].[{{sqlGetAllName}}]    Script Date: 11/26/2012 13:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Bryan J Schoeff
-- Create date: {{ RunDate }}
-- Description:    
-- =============================================
CREATE PROCEDURE [dbo].[{{sqlGetAllName}}]
    -- Add the parameters for the stored procedure here
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    SELECT [{{sqlIdName}}ID]{{#each fields}}
          ,{{sqlFieldName}}{{/each}}
          ,[Created]
          ,[LastModified]
      FROM [{{parent.databaseName}}].[dbo].[{{sqlTableName}}]

END
GO

/****** Object:  StoredProcedure [dbo].[{{sqlGetName}}]    Script Date: 11/26/2012 13:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Bryan J Schoeff
-- Create date: {{ RunDate }}
-- Description:    
-- =============================================
CREATE PROCEDURE [dbo].[{{sqlGetName}}]
    -- Add the parameters for the stored procedure here
    @{{sqlIdName}}ID int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    SELECT [{{sqlIdName}}ID]{{#each fields }}
          ,{{sqlFieldName}}{{/each}}
          ,[Created]
          ,[LastModified]
      FROM [{{parent.databaseName }}].[dbo].[{{sqlTableName}}]
     WHERE [{{sqlIdName}}ID] = @{{sqlIdName}}ID

END
GO


/****** Object:  StoredProcedure [dbo].[{{sqlDeleteName}}]    Script Date: 11/26/2012 13:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Bryan J Schoeff
-- Create date: {{ RunDate }}
-- Description:    
-- =============================================
CREATE PROCEDURE [dbo].[{{sqlDeleteName}}]
    -- Add the parameters for the stored procedure here
    @{{sqlIdName}}ID int 
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    DELETE FROM [{{parent.databaseName}}].[dbo].[{{sqlTableName}}]
          WHERE [{{sqlIdName}}ID] = @{{sqlIdName}}ID

END
GO

/****** Object:  StoredProcedure [dbo].[{{sqlInsertName}}]    Script Date: 11/26/2012 13:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Bryan J Schoeff
-- Create date: {{ RunDate }}
-- Description:    
-- =============================================
CREATE PROCEDURE [dbo].[{{sqlInsertName}}]
    -- Add the parameters for the stored procedure here
    {{#each fields }}
    {{sqlParameterName}} {{type}}{{#unless @last }},{{/unless}}{{/each}}
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    INSERT INTO [{{parent.databaseName}}].[dbo].[{{sqlTableName}}]
               ({{#each fields }}{{#unless @first}},{{/unless}}{{sqlFieldName}}
               {{/each}},[Created]
               ,[LastModified])
        VALUES ({{#each fields }}{{sqlParameterName}},
               {{/each}}GETDATE(),
               GETDATE())

    SELECT SCOPE_IDENTITY()
END
GO

/****** Object:  StoredProcedure [dbo].[{{sqlUpdateName}}]    Script Date: 11/26/2012 13:45:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        Bryan J Schoeff
-- Create date: {{ RunDate }}
-- Description:    
-- =============================================
CREATE PROCEDURE [dbo].[{{sqlUpdateName}}]
    -- Add the parameters for the stored procedure here
    @{{sqlIdName}}ID int{{#each fields }},
    {{sqlParameterName}} {{type}}{{/each}}
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    UPDATE [{{parent.databaseName}}].[dbo].[{{sqlTableName}}]
       SET{{#each fields }}{{#unless @first}},{{else}} {{/unless}}{{sqlFieldName}} = {{sqlParameterName}}
          {{/each}},[LastModified] = GETDATE()
     WHERE [{{sqlIdName}}ID] = @{{sqlIdName}}ID

END
GO

GRANT EXECUTE ON [dbo].[{{sqlGetAllName}}] TO Intranet
GRANT EXECUTE ON [dbo].[{{sqlGetName}}] TO Intranet
GRANT EXECUTE ON [dbo].[{{sqlDeleteName}}] TO Intranet
GRANT EXECUTE ON [dbo].[{{sqlInsertName}}] TO Intranet
GRANT EXECUTE ON [dbo].[{{sqlUpdateName}}] TO Intranet

GRANT EXECUTE ON [dbo].[{{sqlGetAllName}}] TO Internet
GRANT EXECUTE ON [dbo].[{{sqlGetName}}] TO Internet
GRANT EXECUTE ON [dbo].[{{sqlDeleteName}}] TO Internet
GRANT EXECUTE ON [dbo].[{{sqlInsertName}}] TO Internet
GRANT EXECUTE ON [dbo].[{{sqlUpdateName}}] TO Internet



{{/each}}
