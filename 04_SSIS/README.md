# SSIS

## Overview

The **SSIS** folder contains the SQL Server Integration Services (SSIS) solution used to automate the Extract, Transform, and Load (ETL) processes for the **DW_FamilyFinance** project.

The SSIS solution prepares manually downloaded bank transaction files, imports financial and payroll data, applies validation and transformation rules, supports incremental loading, maintains audit logs, and loads validated data into the SQL Server staging environment.

---

# Purpose

The SSIS solution is responsible for:

- Preparing manually downloaded bank transaction files
- Importing source data from Excel and Google Sheets
- Processing payroll and expense files
- Supporting incremental data loading
- Extracting file metadata
- Maintaining audit logs
- Validating source data
- Automating ETL workflows
- Loading data into the STG_FamilyLiving database

---

# Folder Structure

```text
04_SSIS
│
├── DW_FamilyFinance
├── ETL_FamilyFinance
├── ScriptTasks
├── Documentation
├── DW_FamilyFinance.sln
└── README.md
```

---

# Components

## DW_FamilyFinance

Contains supporting files and resources required by the SSIS solution, including project metadata, solution assets, and deployment resources.

---

## ETL_FamilyFinance

Contains the complete SQL Server Integration Services (SSIS) project.

### Contents

- SSIS Packages (`.dtsx`)
- Connection Managers
- Project Parameters
- Project Configuration Files

### Core Packages

| Package | Purpose |
|----------|---------|
| **Load_Bank_Transactions.dtsx** | Prepares manually downloaded Citi Bank and Wells Fargo transaction files for incremental loading. |
| **DW_Initial_Setup.dtsx** | Performs one-time initialization of the data warehouse by loading static dimensions (such as **DimDate**) and preparing the environment for ETL processing. |
| **DW_Load_FamilyFinance.dtsx** | Executes the complete Data Warehouse ETL process by loading dimension and fact tables from the staging database. |
| **STG_LoadDescriptionData.dtsx** | Loads and maintains the Description Lookup staging table. |
| **STG_LoadExpenseData.dtsx** | Loads expense transactions into the staging database. |
| **STG_LoadIncomeData.dtsx** | Loads payroll and income data into the staging database. |
| **STG_Master_FullLoad.dtsx** | Executes a complete reload of the staging environment. |
| **STG_Master_Incremental.dtsx** | Executes the incremental staging ETL workflow. |

---

## ScriptTasks

Contains custom Script Task source code and supporting documentation used throughout the SSIS solution.

### Contents

| File | Purpose |
|------|---------|
| **ExtractFileMetadata.vb** | Extracts metadata from source files. |
| **ExtractFileMetadata.md** | Technical documentation for the metadata extraction script. |
| **ExtractFileMetadata_Task.png** | Screenshot of the Script Task implementation. |
| **ScriptTasks.md** | Documentation describing all custom Script Tasks used within the SSIS solution. |

---

## Documentation

Contains technical documentation describing the architecture, implementation, standards, and ETL processes used throughout the SSIS solution.

Examples include:

- Variable Standards
- Script Task Documentation
- Load Bank Transactions Documentation
- ETL Process Documentation

---

## DW_FamilyFinance.sln

Visual Studio solution file used to organize, develop, maintain, and deploy the complete SSIS solution.

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
| ETL Process Documentation | Documents the complete ETL workflow. |
| Data Warehouse Documentation | Documents the Data Warehouse implementation. |
| Database Architecture | Documents the SQL Server architecture. |
| Load Bank Transactions Documentation | Documents the bank transaction preparation package. |
| Script Task Documentation | Documents the custom Script Tasks used within the SSIS solution. |
| Variable Standards Documentation | Defines SSIS variable naming conventions and development standards. |

---

# Summary

The **SSIS** solution provides the enterprise ETL framework for the **DW_FamilyFinance** project. It automates the preparation, validation, transformation, and loading of financial and payroll data into the SQL Server staging environment. Through incremental loading, dynamic configuration, metadata management, audit logging, and standardized ETL practices, the solution delivers a scalable, maintainable, and production-ready data integration platform that supports the downstream Data Warehouse and Power BI reporting environment.