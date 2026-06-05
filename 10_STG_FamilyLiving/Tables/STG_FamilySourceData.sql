USE [STG_FamilyLiving];
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

/***************************************************************************************************
Table Name   : dbo.STG_FamilySourceData
Author       : Behailu Tessema
Created Date : 06/05/2026
Database     : STG_FamilyLiving
Schema       : dbo
Project      : DW_FamilyFinance Data Platform

Purpose:
    Stores staged family expense transaction data loaded from source files
    before transformation into DW_FamilyFinance.

Business Rules:
    1. ExpenseSourceID uniquely identifies each staged expense transaction.
    2. Transaction_ID is a computed helper column using Description and SourceName.
    3. Debit represents expense/outflow amount.
    4. Credit represents credit/refund amount.
    5. SourceName identifies the originating bank/source.
    6. LoadDate is calculated as the 3rd day of the following month.

Modification History:
-----------------------------------------------------------------------------------------------
Date         Author              Description
-----------------------------------------------------------------------------------------------
06/05/2026   Behailu Tessema     Initial table creation script.
***************************************************************************************************/

IF OBJECT_ID(N'dbo.STG_FamilySourceData', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.STG_FamilySourceData
    (
        ExpenseSourceID BIGINT IDENTITY(1,1) NOT NULL,

        Transaction_ID AS
        (
            CONCAT
            (
                TRIM([Description]),
                TRIM([SourceName])
            )
        ),

        [Date] DATE NULL,
        [Description] NVARCHAR(255) NULL,
        Debit DECIMAL(18,2) NULL,
        Credit DECIMAL(18,2) NULL,
        Category NVARCHAR(255) NULL,
        SourceName NVARCHAR(255) NULL,

        LoadDate AS
        (
            CONVERT
            (
                DATE,
                DATEADD
                (
                    DAY,
                    2,
                    DATEADD
                    (
                        MONTH,
                        DATEDIFF(MONTH, 0, [Date]) + 1,
                        0
                    )
                )
            )
        ) PERSISTED,

        CONSTRAINT PK_STG_FamilySourceData
            PRIMARY KEY CLUSTERED (ExpenseSourceID)
    );
END;
GO