# SSIS

## Overview

The **SSIS** folder contains the SQL Server Integration Services (SSIS) solution used to automate the Extract, Transform, and Load (ETL) processes for the **DW_FamilyFinance** project.

The SSIS solution imports raw financial and payroll data, applies validation and transformation rules, supports incremental loading, maintains audit logs, and loads data into the SQL Server staging environment.

---

# Purpose

The SSIS solution is responsible for:

* Importing source data from Excel and Google Sheets
* Processing payroll and expense files
* Supporting incremental data loading
* Extracting file metadata
* Maintaining audit logs
* Validating source data
* Automating ETL workflows
* Loading data into the STG_FamilyLiving database

---

# Folder Structure

```text
04_SSIS
│
├── DW_FamilyFinance
├── ETL_FamilyFinance
├── ScriptTasks
├── DW_FamilyFinance.sln
└── README.md
```

---

# Components

## DW_FamilyFinance

Contains supporting files and solution resources used by the SSIS project.

## ETL_FamilyFinance

Contains the complete SSIS project, including:

* SSIS Packages (.dtsx)
* Project configuration files
* Connection Managers
* Project Parameters

Key packages include:

* DW_Initial_Setup.dtsx
* DW_Load_FamilyFinance.dtsx
* STG_LoadDescriptionData.dtsx
* STG_LoadExpenseData.dtsx
* STG_LoadIncomeData.dtsx
* STG_Master_FullLoad.dtsx
* STG_Master_Incremental.dtsx

## ScriptTasks

Contains custom Script Task source code and supporting documentation.

Examples include:

* ExtractFileMetadata.vb
* ExtractFileMetadata.md
* ExtractFileMetadata_Task.png

## DW_FamilyFinance.sln

Visual Studio solution file used to manage and develop the complete SSIS solution.

---

# Key Features

* Automated ETL processing
* Incremental loading
* Dynamic file processing
* File metadata extraction
* Audit logging
* Data validation
* Duplicate prevention
* Master package orchestration

---

# ETL Workflow

```text
Source Files
      │
      ▼
SSIS Packages
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

The SSIS solution is supported by technical documentation located throughout the repository, including:

* STG Environment Documentation
* ETL Process Documentation
* Data Warehouse Documentation
* Database Architecture
* Script Task Documentation

---

# Summary

The **SSIS** solution provides the automated ETL framework for the DW_FamilyFinance project. It manages the movement of financial data from source files into the SQL Server staging environment while ensuring data quality, incremental processing, auditability, and reliable downstream reporting.
