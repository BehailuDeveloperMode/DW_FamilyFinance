---

# Components

## DW_FamilyFinance

Contains the supporting files and resources required by the SSIS solution, including project metadata, solution assets, and deployment resources used during ETL development and execution.

---

## ETL_FamilyFinance

Contains the complete SQL Server Integration Services (SSIS) project.

### Contents

- SSIS Packages (`.dtsx`)
- Connection Managers
- Project Parameters
- Project Configuration Files
- Package Configurations

### Core Packages

| Package | Purpose |
|----------|---------|
| Load_Bank_Transactions.dtsx | Prepares manually downloaded Citi and Wells Fargo bank transactions for incremental loading. |
| DW_Initial_Setup.dtsx | Performs the initial setup of the data warehouse environment. |
| DW_Load_FamilyFinance.dtsx | Executes the complete Data Warehouse ETL process. |
| STG_LoadDescriptionData.dtsx | Loads and maintains the description lookup staging table. |
| STG_LoadExpenseData.dtsx | Loads expense transactions into the staging database. |
| STG_LoadIncomeData.dtsx | Loads payroll and income data into the staging database. |
| STG_Master_FullLoad.dtsx | Executes a complete staging reload. |
| STG_Master_Incremental.dtsx | Executes the incremental staging ETL workflow. |

---

## ScriptTasks

Contains custom Script Task source code and supporting documentation used throughout the SSIS solution.

### Contents

| File | Purpose |
|------|---------|
| ExtractFileMetadata.vb | Extracts metadata from source files. |
| ExtractFileMetadata.md | Technical documentation for the metadata extraction script. |
| ExtractFileMetadata_Task.png | Screenshot of the Script Task implementation. |
| ScriptTasks.md | Documentation describing all custom Script Tasks used in the SSIS solution. |

---

## DW_FamilyFinance.sln

Visual Studio solution file used to organize, manage, build, and maintain the complete SSIS solution.

---

# Key Features

- Source data preparation
- Automated ETL processing
- Incremental loading
- Dynamic file path configuration
- Dynamic worksheet configuration
- Dynamic file processing
- File metadata extraction
- Audit logging
- Data validation
- Duplicate prevention
- Master package orchestration
- Enterprise ETL design standards

---

# ETL Workflow

```text
Manual Bank File Download
        │
        ▼
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

# Documentation

Technical documentation for the SSIS solution is organized throughout the repository.

| Document | Purpose |
|----------|---------|
| STG Environment Documentation | Documents the staging environment and architecture. |
| ETL Process Documentation | Describes the complete ETL workflow. |
| Data Warehouse Documentation | Documents the enterprise data warehouse implementation. |
| Database Architecture | Describes the overall SQL Server architecture. |
| Load Bank Transactions Documentation | Documents the manual bank transaction preparation package. |
| Script Task Documentation | Explains custom Script Task implementations. |
| Variable Standards Documentation | Defines SSIS variable naming conventions and standards. |

---

# Summary

The **SSIS** solution provides the enterprise ETL framework for the **DW_FamilyFinance** project. It automates the preparation, validation, transformation, and loading of financial and payroll data into the SQL Server staging environment. Through incremental loading, dynamic configuration, metadata management, audit logging, and standardized ETL practices, the solution delivers a scalable, maintainable, and production-ready data integration platform that supports the downstream Data Warehouse and Power BI reporting environment.