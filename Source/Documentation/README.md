# Source Layer Documentation

## Purpose

The Source layer represents the origin of all data used within the DW_FamilyFinance platform.

Source files are maintained outside the Git repository to protect sensitive financial and payroll information.

## Source Location

OneDrive\Family Finance

## Source Folders

### STG_FamilyLiving_Expense

Stores bank transaction source files used for expense reporting.

### Income_Statement

Stores payroll and income source files.

### STG_Description

Stores description lookup files used for categorization and standardization.

### Description_NoMatching

Stores descriptions that require review and mapping.

### STG_Report

Stores legacy reporting and validation files.

## Data Flow

Google Forms
↓
Excel Files
↓
OneDrive
↓
SSIS
↓
STG_FamilyLiving
↓
DW_DataWarehouse
↓
Power BI

## Git Policy

Real financial data, payroll files, bank statements, and personally identifiable information (PII) are not stored in the Git repository.

Only documentation, templates, and sanitized sample files may be stored in Source\Samples.
