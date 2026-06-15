# DW_FamilyFinance -- SSIS ETL Project

## Overview

DW_FamilyFinance is a SQL Server Data Warehouse project designed to load
and manage family income and expense data from multiple sources
including Citi Bank, Wells Fargo, payroll systems, and lookup files.

**Platform:** SQL Server 2022 / SSIS 2022 **Development Tool:** Visual
Studio 2022 **Database:** STG_FamilyLiving

## Current SSIS Packages

-   STG_LoadExpenseData.dtsx
-   STG_LoadIncomeData.dtsx
-   STG_LoadDescriptionData.dtsx

## Expense Package Architecture

FELC_LoadExpenseFiles - ST_ParseExpenseFileMetadata -
EST_CheckFileAlreadyLoaded - EST_DeleteOldExpenseFileRows -
DFT_LoadExpenseData - EST_InsertFileLoadAudit

## Dynamic File Processing

-   Dynamic Excel Connection using User::FullFilePath
-   OneDrive source folder processing
-   Foreach Loop Container

## Metadata Extraction

-   FileName
-   SourceName
-   FileYear

## Data Flow Design

EXL_ExpenseSource → DC_AddFileMetadata → RC_ExpenseRowCount →
OLED_STG_FamilySourceData

## Audit Framework

Table: dbo.STG_FileLoadAudit

Columns: - FileLoadAuditID - PackageName - FileName - FilePath -
SourceName - FileYear - SourceRowCount - LoadStatus - LoadDateTime -
LoadedBy

## Incremental Load Logic (Version 1.0)

-   If FileName exists in audit table: Skip
-   Otherwise: Load and Audit

## Current Features

-   Dynamic file processing
-   OneDrive integration
-   Metadata extraction
-   Audit logging
-   Duplicate load prevention
-   Row count capture

## Future Enhancement (Version 2.0)

-   FileName + RowCount validation
-   YTD file refresh support

## Status

Expense Package Version 1.0 Complete
