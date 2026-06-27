USE [STG_FamilyLiving];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
Table Name : dbo.STG_FileLoadAudit
Author : Behailu Tessema
Created Date : 06/16/2026
Database : STG_FamilyLiving
Schema : dbo
Project : DW_FamilyFinance Data Platform

Purpose:
Tracks source file load activity into the STG_FamilyLiving staging database.

Description:
This table stores audit information for each source file loaded through
the SSIS staging process. It captures file metadata, source information,
row counts, load status, file modification date, load timestamp, and
execution details to support ETL monitoring, validation, reconciliation,
and troubleshooting activities.

Source:
SSIS File Load Process

Target:
STG_FamilyLiving staging audit framework

Business Rules:
1. One row represents one file load event.
2. FileName is required for every load record.
3. SourceRowCount stores the number of source records loaded from the file.
4. LoadStatus defaults to 'SUCCESS' unless otherwise specified.
5. LoadDateTime defaults to the current system date and time.
6. LoadedBy defaults to the SQL Server login executing the load.
7. FileModifiedDate stores the last modified timestamp of the source file.
8. Audit records support ETL monitoring, validation, reconciliation,
and troubleshooting.

Used By:
- SSIS File Load Packages
- ETL Monitoring Process
- Data Validation Process
- File Load Reconciliation
- Audit and Troubleshooting Reviews

Example:
SELECT *
FROM dbo.STG_FileLoadAudit
ORDER BY LoadDateTime DESC;

Modification History:
Date Author Description

06/05/2026 Behailu Tessema Initial table creation.
06/16/2026 Behailu Tessema Added FileModifiedDate and enhanced audit tracking.
***************************************************************************************************/
IF OBJECT_ID(N'dbo.STG_FileLoadAudit', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.STG_FileLoadAudit (
            -- Surrogate key for each file load event
        FileLoadAuditID  BIGINT          IDENTITY (1, 1) NOT NULL,
            -- SSIS package name executing the load
        PackageName      NVARCHAR (255)  NULL,
            -- Source file name
        FileName         NVARCHAR (255)  NOT NULL,
            -- Full source file path
        FilePath         NVARCHAR (1000) NULL,
            -- Source system or bank name
        SourceName       NVARCHAR (100)  NULL,
            -- File reporting year
        FileYear         INT             NULL,
            -- Number of rows loaded from the source file
        SourceRowCount   BIGINT          NULL,
            -- Load execution status
        LoadStatus       NVARCHAR (50)   CONSTRAINT DF_STG_FileLoadAudit_LoadStatus DEFAULT ('SUCCESS') NOT NULL,
            -- Date and time the load occurred
        LoadDateTime     DATETIME2 (0)   CONSTRAINT DF_STG_FileLoadAudit_LoadDateTime DEFAULT (SYSDATETIME()) NOT NULL,
            -- SQL Server login executing the load
        LoadedBy         NVARCHAR (100)  CONSTRAINT DF_STG_FileLoadAudit_LoadedBy DEFAULT (SUSER_SNAME()) NOT NULL,
            -- Last modified date of the source file
        FileModifiedDate DATETIME2 (0)   NULL,
            CONSTRAINT PK_STG_FileLoadAudit PRIMARY KEY CLUSTERED (FileLoadAuditID)
        );
    END