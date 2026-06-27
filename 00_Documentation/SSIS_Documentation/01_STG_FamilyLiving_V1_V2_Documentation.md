# STG_FamilyLiving Staging Environment Documentation

## Project

DW_FamilyFinance

## Layer

STG_FamilyLiving

## Purpose

The **STG_FamilyLiving** staging environment loads raw source data from Excel and Google Sheets into SQL Server staging tables before the data is transformed and loaded into the **DW_FamilyFinance** enterprise data warehouse.

The staging layer is responsible for data ingestion, validation, incremental loading, metadata tracking, and audit logging.

---

# Version 1.0 – Basic Staging Load

## Goal

Develop the initial SSIS packages to load source files into SQL Server staging tables.

---

## Packages

### STG_LoadExpenseData.dtsx

Loads expense Excel files into:

```text
STG_FamilyLiving.dbo.STG_FamilySourceData
```

Basic Data Flow:

```text
Excel Source
      │
      ▼
Row Count
      │
      ▼
OLE DB Destination
```

---

### STG_LoadIncomeData.dtsx

Loads payroll and income data into:

```text
STG_FamilyLiving.dbo.Family_Income
```

Basic Data Flow:

```text
Excel Source
      │
      ▼
Row Count
      │
      ▼
OLE DB Destination
```

---

### STG_LoadDescriptionData.dtsx

Loads description lookup data into:

```text
STG_FamilyLiving.dbo.STG_Description_LookUp
```

Basic Data Flow:

```text
Excel Source
      │
      ▼
Lookup
      │
      ▼
Insert New Descriptions Only
```

---

# Version 2.0 – Incremental and Audited Staging Load

## Goal

Enhance the staging environment by implementing incremental loading, metadata extraction, audit logging, and process automation.

---

# Expense Package Version 2.0

## Package

STG_LoadExpenseData.dtsx

## Final Control Flow

```text
FELC_LoadExpenseFiles
        │
        ▼
ST_ParseExpenseFileMetadata
        │
        ▼
EST_CheckFileAlreadyLoaded
        │
        ▼
EST_DeleteOldExpenseFileRows
        │
        ▼
DFT_LoadExpenseData
        │
        ▼
EST_InsertFileLoadAudit
```

### Features

* Processes all expense Excel files automatically
* Reads source files from OneDrive
* Uses dynamic Excel file paths
* Extracts file metadata
* Captures File Name
* Captures Source Name
* Captures File Year
* Captures File Modified Date
* Stores metadata in staging tables
* Converts source names to standardized bank names
* Prevents duplicate file processing
* Reloads modified files automatically
* Maintains complete audit history

### Incremental Loading Rule

```text
FileName + FileModifiedDate
```

If the same **FileName** and **FileModifiedDate** already exist in the audit table:

* Skip the file.

If the **FileName** exists but the **FileModifiedDate** has changed:

* Delete existing records for that file.
* Reload the updated file.
* Update the audit history.

---

# Income Package Version 2.0

## Package

STG_LoadIncomeData.dtsx

## Final Control Flow

```text
EST_Income_MaxDate
        │
        ▼
DFT_LoadIncomeData
        │
        ▼
EST_GetNewMaxIncomeDate
        │
        ▼
EST_InsertIncomeLoadAudit
```

### Features

* Loads payroll and income data
* Uses Pay Day for incremental processing
* Captures previous maximum Pay Day
* Loads only new payroll records
* Updates the maximum processed Pay Day
* Writes audit information

### Incremental Loading Rule

```text
Pay_Day > MaxIncomeDate
```

Only records with a **Pay_Day** greater than the current maximum processed date are loaded.

---

# Description Package Version 2.0

## Package

STG_LoadDescriptionData.dtsx

## Final Data Flow

```text
EXL_DescriptionSource
        │
        ▼
LKP_Description
        │
        ▼
RC_DescriptionRowCount
        │
        ▼
OLED_Description
```

### Features

* Loads description lookup records
* Validates existing descriptions
* Inserts only new lookup values
* Prevents duplicate records
* Captures row counts
* Supports audit logging

### Incremental Loading Rule

```text
LookUp_Description_Name
```

If **LookUp_Description_Name** already exists:

* Skip the record.

If **LookUp_Description_Name** does not exist:

* Insert the new record.

---

# Master Staging Package

## Package

STG_Master_Incremental.dtsx

## Final Control Flow

```text
EPT_STG_LoadDescriptionData
          │
          ▼
EPT_STG_LoadIncomeData
          │
          ▼
EPT_STG_LoadExpenseData
```

## Purpose

Executes all staging packages in the correct sequence.

## Execution Order

1. Load Description Lookup
2. Load Income Data
3. Load Expense Data

This execution order ensures that all lookup data is available before loading transactional data.

---

# Staging Tables

## dbo.STG_FamilySourceData

Stores imported expense transactions.

### Key Columns

* ExpenseSourceID
* Transaction_ID
* Date
* Description
* Debit
* Credit
* Category
* SourceName
* FileName
* FileYear
* LoadDate

---

## dbo.Family_Income

Stores payroll and income records.

### Key Columns

* IncomeSourceID
* Period_Beginning
* Period_Ending
* Pay_Day
* Work_Place
* Employee_FullName
* Gross_Payment
* Taxes
* Employer_NetPay
* Total_Tax
* Payment_Validation

---

## dbo.STG_Description_LookUp

Stores expense classification rules.

### Key Columns

* LookUp_Description_Name
* LookUp_Description
* LookUp_SubCategory
* LookUp_ExpenseType
* LookUp_Category
* LoadDate

---

# Audit Tables

## dbo.STG_FileLoadAudit

Tracks expense file processing.

### Used By

STG_LoadExpenseData.dtsx

### Key Columns

* FileName
* FilePath
* SourceName
* FileYear
* SourceRowCount
* FileModifiedDate
* LoadStatus
* LoadDateTime
* LoadedBy

---

## dbo.STG_IncomeLoadAudit

Tracks payroll package execution.

### Used By

STG_LoadIncomeData.dtsx

### Key Columns

* PackageName
* MaxIncomeDate
* RowCountLoaded
* LoadDateTime
* LoadedBy

---

## dbo.STG_DescriptionLoadAudit

Tracks description lookup processing.

### Used By

STG_LoadDescriptionData.dtsx

### Key Columns

* PackageName
* RowCountLoaded
* LoadDateTime
* LoadedBy

---

# Data Flow

```text
Google Forms
      │
      ▼
Excel Files
      │
      ▼
OneDrive
      │
      ▼
SSIS
      │
      ▼
STG_FamilyLiving
      │
      ▼
DW_FamilyFinance
      │
      ▼
Power BI
```

---

# Current Status

## Version 1.0

✅ Completed

Successfully implemented the initial Excel-to-STG loading process.

---

## Version 2.0

✅ Completed

Implemented:

* Incremental loading
* Metadata extraction
* Audit logging
* Master package orchestration
* Automated file processing

---

# Final STG Environment Status

| Package                      | Status     |
| ---------------------------- | ---------- |
| STG_LoadExpenseData.dtsx     | ✅ Complete |
| STG_LoadIncomeData.dtsx      | ✅ Complete |
| STG_LoadDescriptionData.dtsx | ✅ Complete |
| STG_Master_Incremental.dtsx  | ✅ Complete |

---

# Summary

The **STG_FamilyLiving** staging environment has been fully implemented and validated.

The environment is responsible for importing, validating, auditing, and preparing financial source data before loading it into the **DW_FamilyFinance** enterprise data warehouse.

The staging layer provides a reliable, scalable, and maintainable foundation for downstream ETL processing, reporting, and business intelligence analytics.
