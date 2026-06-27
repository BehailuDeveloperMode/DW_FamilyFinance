# STG_FamilyLiving – Staging Environment Documentation

## Project
DW_FamilyFinance

## Layer
STG_FamilyLiving

## Purpose
The staging environment loads raw source data from Excel/Google Sheet exports into SQL Server staging tables before the data is loaded into DW_FamilyFinance.

---

# Version 1.0 – Basic Staging Load

## Goal
Create working SSIS packages that load source files into staging tables.

## Packages

### STG_LoadExpenseData.dtsx
Loads expense Excel files into:

STG_FamilyLiving.dbo.STG_FamilySourceData

Basic flow:

Excel Source
→ Row Count
→ OLE DB Destination

---

### STG_LoadIncomeData.dtsx
Loads income/payroll Excel data into:

STG_FamilyLiving.dbo.Family_Income

Basic flow:

Excel Source
→ Row Count
→ OLE DB Destination

---

### STG_LoadDescriptionData.dtsx
Loads description lookup data into:

STG_FamilyLiving.dbo.STG_Description_LookUp

Basic flow:

Excel Source
→ Lookup
→ Insert new descriptions only

---

# Version 2.0 – Incremental and Audited Staging Load

## Goal
Add automation, metadata tracking, audit tables, and incremental loading.

---

# Expense Package Version 2.0

## Package
STG_LoadExpenseData.dtsx

## Final Control Flow

FELC_LoadExpenseFiles
→ ST_ParseExpenseFileMetadata
→ EST_CheckFileAlreadyLoaded
→ EST_DeleteOldExpenseFileRows
→ DFT_LoadExpenseData
→ EST_InsertFileLoadAudit

## Features

- Loops through all expense Excel files
- Uses OneDrive folder source
- Uses dynamic Excel file path
- Extracts FileName
- Extracts SourceName
- Extracts FileYear
- Extracts FileModifiedDate
- Adds FileName and FileYear to staging table
- Converts SourceName to bank format
- Prevents duplicate file loads
- Reloads modified files
- Stores audit history

## Incremental Rule

FileName + FileModifiedDate

If the same FileName and same FileModifiedDate already exist in audit table:

Skip file.

If FileName exists but FileModifiedDate changed:

Delete old rows for that file and reload.

---

# Income Package Version 2.0

## Package
STG_LoadIncomeData.dtsx

## Final Control Flow

EST_Income_MaxDate
→ DFT_LoadIncomeData
→ EST_GetNewMaxIncomeDate
→ EST_InsertIncomeLoadAudit

## Features

- Loads one income Excel file
- Uses Pay_Day for incremental load
- Captures old max Pay_Day
- Loads only new income rows
- Captures new max Pay_Day after load
- Inserts income audit record

## Incremental Rule

Pay_Day > MaxIncomeDate

Only rows with Pay_Day greater than the current maximum Pay_Day in Family_Income are loaded.

---

# Description Package Version 2.0

## Package
STG_LoadDescriptionData.dtsx

## Final Data Flow

EXL_DescriptionSource
→ LKP_Description
→ RC_DescriptionRowCount
→ OLED_Description

## Features

- Loads lookup descriptions
- Checks existing descriptions
- Inserts only new descriptions
- Prevents duplicate lookup rows
- Captures description row count
- Supports audit logging

## Incremental Rule

LookUp_Description_Name

If LookUp_Description_Name already exists:

Skip.

If LookUp_Description_Name does not exist:

Insert.

---

# Master Staging Package

## Package
STG_Master_Incremental.dtsx

## Final Control Flow

EPT_STG_LoadDescriptionData
→ EPT_STG_LoadIncomeData
→ EPT_STG_LoadExpenseData

## Purpose
Runs all staging packages in the correct order.

## Load Order Reason

1. Description lookup loads first
2. Income loads second
3. Expense loads third

---

# Staging Tables

## dbo.STG_FamilySourceData
Stores expense transactions.

Important columns:

- ExpenseSourceID
- Transaction_ID
- Date
- Description
- Debit
- Credit
- Category
- SourceName
- FileName
- FileYear
- LoadDate

---

## dbo.Family_Income
Stores payroll and income records.

Important columns:

- IncomeSourceID
- Period_Bginning
- Period_Ending
- Pay_Day
- Work_Place
- Employee_FullName
- Gross_Payment
- Taxes
- Employer_NetPay
- Total_Tax
- Payment_Validation

---

## dbo.STG_Description_LookUp
Stores expense classification rules.

Important columns:

- LookUp_Description_Name
- LookUp_Description
- LookUp_SubCategory
- LookUp_ExpenseType
- LookUp_Category
- LoadDate

---

# Audit Tables

## dbo.STG_FileLoadAudit
Tracks expense file loads.

Used by:

STG_LoadExpenseData.dtsx

Important columns:

- FileName
- FilePath
- SourceName
- FileYear
- SourceRowCount
- FileModifiedDate
- LoadStatus
- LoadDateTime
- LoadedBy

---

## dbo.STG_IncomeLoadAudit
Tracks income package loads.

Used by:

STG_LoadIncomeData.dtsx

Important columns:

- PackageName
- MaxIncomeDate
- RowCountLoaded
- LoadDateTime
- LoadedBy

---

## dbo.STG_DescriptionLoadAudit
Tracks description lookup loads.

Used by:

STG_LoadDescriptionData.dtsx

Important columns:

- PackageName
- RowCountLoaded
- LoadDateTime
- LoadedBy

---

# Current Status

## Version 1.0
Completed.

Basic Excel-to-STG loading was successfully built and tested.

## Version 2.0
Completed.

Incremental loading, metadata extraction, audit logging, and master package orchestration were added.

---

# Final STG Environment Status

STG_LoadExpenseData.dtsx: Complete  
STG_LoadIncomeData.dtsx: Complete  
STG_LoadDescriptionData.dtsx: Complete  
STG_Master_Incremental.dtsx: Complete  

The STG_FamilyLiving layer is ready to feed DW_FamilyFinance.