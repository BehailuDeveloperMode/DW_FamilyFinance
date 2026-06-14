USE [STG_FamilyLiving];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
Table Name   : dbo.STG_FileLoadAudit
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
    Tracks source file load activity into the STG_FamilyLiving staging database.

Description:
    This table records metadata for each file loaded through SSIS, including
    file name, file path, source name, file year, source row count, load timestamp,
    and SQL Server login used during the load.

Source:
    SSIS file load process

Target:
    STG_FamilyLiving audit and validation process

Business Rules:
    1. One row represents one file load event.
    2. FileName is required.
    3. SourceRowCount is required and stores the number of rows loaded from the source file.
    4. LoadDateTime defaults to the current system date and time.
    5. LoadedBy defaults to the SQL Server login executing the load.
    6. This table is used for troubleshooting, audit validation, and ETL monitoring.

Used By:
    - SSIS package execution
    - STG validation process
    - ETL audit review
    - File load troubleshooting

Example:
    SELECT *
    FROM dbo.STG_FileLoadAudit
    ORDER BY LoadDateTime DESC;

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/05/2026   Behailu Tessema     Initial table creation script.
***************************************************************************************************/
IF OBJECT_ID(N'dbo.STG_FileLoadAudit', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.STG_FileLoadAudit (
            FileLoadAuditID BIGINT         IDENTITY (1, 1) NOT NULL,
            FileName        VARCHAR (255)  NOT NULL,
            FilePath        VARCHAR (1000) NULL,
            SourceName      VARCHAR (100)  NULL,
            FileYear        INT            NULL,
            SourceRowCount  BIGINT         NOT NULL,
            LoadDateTime    DATETIME2 (0)  CONSTRAINT DF_STG_FileLoadAudit_LoadDateTime DEFAULT (SYSDATETIME()) NOT NULL,
            LoadedBy        VARCHAR (100)  CONSTRAINT DF_STG_FileLoadAudit_LoadedBy DEFAULT (SUSER_SNAME()) NOT NULL,
            CONSTRAINT PK_STG_FileLoadAudit PRIMARY KEY CLUSTERED (FileLoadAuditID)
        );
    END