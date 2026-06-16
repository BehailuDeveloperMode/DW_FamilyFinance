USE [STG_FamilyLiving];


GO
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
/***************************************************************************************************
Table Name : dbo.STG_IncomeLoadAudit
Author : Behailu Tessema
Created Date : 06/16/2026
Database : STG_FamilyLiving
Schema : dbo
Project : DW_FamilyFinance Data Platform

Purpose:
Tracks income data load activity into the STG_FamilyLiving staging database.

Description:
This table stores audit information for each income load process executed
through SSIS. It captures package execution details, maximum income date
loaded, row counts, load timestamps, and execution login information to
support ETL monitoring, validation, reconciliation, and troubleshooting.

Source:
SSIS Income Load Process

Target:
STG_FamilyLiving staging audit framework

Business Rules:
1. One row represents one income load execution.
2. MaxIncomeDate stores the most recent income date loaded.
3. RowCountLoaded stores the number of income records loaded.
4. LoadDateTime defaults to the current system date and time.
5. LoadedBy defaults to the SQL Server login executing the load.
6. Audit records support ETL monitoring and validation activities.

Used By:
- SSIS Income Load Packages
- ETL Monitoring Process
- Data Validation Process
- Load Reconciliation Process
- Audit and Troubleshooting Reviews

Example:
SELECT *
FROM dbo.STG_IncomeLoadAudit
ORDER BY LoadDateTime DESC;

Modification History:
Date Author Description

06/16/2026 Behailu Tessema Initial table creation.
***************************************************************************************************/
IF OBJECT_ID(N'dbo.STG_IncomeLoadAudit', N'U') IS NULL
    BEGIN
        CREATE TABLE dbo.STG_IncomeLoadAudit (
            -- Surrogate key for each income load execution
        IncomeLoadAuditID BIGINT        IDENTITY (1, 1) NOT NULL,
            -- SSIS package name executing the load
        PackageName       VARCHAR (255) NULL,
            -- Most recent income date loaded during execution
        MaxIncomeDate     DATE          NULL,
            -- Number of records loaded
        RowCountLoaded    INT           NULL,
            -- Date and time the load occurred
        LoadDateTime      DATETIME2 (0) CONSTRAINT DF_STG_IncomeLoadAudit_LoadDateTime DEFAULT (SYSDATETIME()) NOT NULL,
            -- SQL Server login executing the load
        LoadedBy          VARCHAR (100) CONSTRAINT DF_STG_IncomeLoadAudit_LoadedBy DEFAULT (SUSER_SNAME()) NOT NULL,
            CONSTRAINT PK_STG_IncomeLoadAudit PRIMARY KEY CLUSTERED (IncomeLoadAuditID)
        );
    END