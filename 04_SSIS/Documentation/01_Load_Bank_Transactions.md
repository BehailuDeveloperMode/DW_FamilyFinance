# Load_Bank_Transactions.dtsx

## Overview

The **Load_Bank_Transactions.dtsx** package is the starting point of the expense ETL process within the **DW_FamilyFinance** project.

Unlike the remaining ETL packages, this package does not connect directly to online banking systems. For security and privacy reasons, monthly transaction statements are manually downloaded from financial institutions before the automated ETL process begins.

Once the source files have been downloaded, this package prepares and standardizes the data before supplying it to the staging ETL framework.

---

# Business Purpose

The purpose of this package is to separate the manual acquisition of confidential financial data from the automated ETL process.

This design protects sensitive banking credentials while allowing the remainder of the ETL framework to execute automatically.

Benefits include:

- Protects confidential banking information
- Eliminates direct connections to financial institutions
- Separates manual and automated processes
- Standardizes source files
- Supports fully automated downstream ETL
- Improves maintainability and security

---

# Data Flow

```text
Online Banking
        │
        │
Manual Download
        │
        ▼
Monthly Bank Statements
        │
        ▼
Load_Bank_Transactions.dtsx
        │
        ▼
STG_FamilyLiving_Expense
        │
        ▼
STG_LoadExpenseData.dtsx
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

# Source Systems

The package currently processes transaction files from:

- Wells Fargo Bank
- Citi Bank

Each financial institution is processed independently to simplify maintenance and future enhancements.

---

# Package Architecture

The package contains two independent Data Flow Tasks.

## DFT_LoadTransactions_Citi

Processes Citi Bank transaction files.

Components

- EX_SRC_CitiBank
- SCR_ExtractDateString_Citi
- EST_GetMaxDate_Citi
- EX_DST_CitiBank

---

## DFT_LoadTransactions_WellsFargo

Processes Wells Fargo transaction files.

Components

- EX_SRC_WellsFargo
- SCR_ExtractDateString_WellsFargo
- EST_GetMaxDate_WellsFargo
- EX_DST_WellsFargoBank

---

# Incremental Loading Strategy

The package uses an incremental loading strategy based on the latest transaction date stored in the destination workbook.

Workflow:

1. Retrieve the maximum transaction date from the destination workbook.
2. Read the newly downloaded source file.
3. Compare transaction dates.
4. Load only transactions newer than the stored maximum date.
5. Ignore records that have already been processed.

---

# Benefits of Using MAX(Date)

Using the maximum transaction date provides several advantages.

- Prevents duplicate transactions
- Processes only new records
- Improves execution performance
- Reduces unnecessary processing
- Supports unattended execution
- Automatically adapts to the latest processed transaction

No manual date updates are required because the package dynamically determines where the previous execution ended.

---

# SSIS Variables

## Incremental Loading Variables

| Variable | Data Type | Description |
|----------|-----------|-------------|
| Citi_MaxDate_Obj | Object | Stores the latest transaction date retrieved from the Citi destination workbook. |
| Citi_MaxDate_Str | String | Converts the Citi maximum date into a string for comparison. |
| WellsFargo_MaxDate_Obj | Object | Stores the latest transaction date retrieved from the Wells Fargo destination workbook. |
| WellsFargo_MaxDate_Str | String | Converts the Wells Fargo maximum date into a string for comparison. |

---

## Folder Variables

| Variable | Data Type | Description |
|----------|-----------|-------------|
| SourceFolderPath | String | Folder containing manually downloaded bank statements. |
| DestinationFolderPath | String | Folder containing standardized ETL source files. |

---

## File Name Variables

| Variable | Data Type | Description |
|----------|-----------|-------------|
| Citi_SourceFileName | String | Citi source workbook name. |
| WellsFargo_SourceFileName | String | Wells Fargo source workbook name. |
| Citi_DestinationFileName | String | Citi destination workbook name. |
| WellsFargo_DestinationFileName | String | Wells Fargo destination workbook name. |

---

## Dynamic File Path Expressions

### Citi Source File

```text
@[User::SourceFolderPath]
+
@[User::Citi_SourceFileName]
```

### Wells Fargo Source File

```text
@[User::SourceFolderPath]
+
@[User::WellsFargo_SourceFileName]
```

### Citi Destination File

```text
@[User::DestinationFolderPath]
+
@[User::Citi_DestinationFileName]
```

### Wells Fargo Destination File

```text
@[User::DestinationFolderPath]
+
@[User::WellsFargo_DestinationFileName]
```

---

# Integration with the ETL Framework

This package is executed before the staging load process.

```text
Load_Bank_Transactions.dtsx
            │
            ▼
STG_LoadExpenseData.dtsx
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

# Key Features

- Secure handling of confidential financial data
- Manual source acquisition
- Dynamic file path configuration
- Incremental loading using MAX(Transaction Date)
- Duplicate prevention
- Independent processing for multiple financial institutions
- Reusable SSIS variables
- Modular ETL design
- Integration with the enterprise staging framework

---

# Summary

The **Load_Bank_Transactions.dtsx** package serves as the secure entry point for the expense ETL pipeline within the **DW_FamilyFinance** project. By separating manual acquisition of confidential banking data from automated ETL processing, the solution provides a secure, maintainable, and scalable architecture while supporting incremental loading, dynamic configuration, and efficient downstream processing.