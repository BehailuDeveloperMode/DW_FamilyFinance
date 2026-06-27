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
├── Documentation
├── Packages
├── ScriptTasks
└── README.md
```

---

# Components

## Documentation

Contains technical documentation describing the SSIS solution, package design, ETL workflow, version history, and implementation details.

## Packages

Contains all SSIS packages used throughout the project.

Examples include:

* STG_LoadExpenseData.dtsx
* STG_LoadIncomeData.dtsx
* STG_LoadDescriptionData.dtsx
* STG_Master_Incremental.dtsx

## ScriptTasks

Contains custom Script Task code used by SSIS packages.

Examples include:

* File metadata extraction
* Dynamic file processing
* Custom ETL logic

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

Additional SSIS documentation is available in the **Documentation** folder.

Topics include:

* STG Environment Documentation
* SSIS Package Design
* Incremental Loading
* Audit Framework
* ETL Process

---

# Summary

The **SSIS** folder contains the complete ETL solution for the DW_FamilyFinance project. It automates the movement of financial data from source files into the SQL Server staging environment while ensuring data quality, auditability, and reliable downstream reporting.
