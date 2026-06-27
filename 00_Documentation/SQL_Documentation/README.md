# SQL Documentation

## Overview

This folder contains the SQL documentation for the **DW_FamilyFinance** project.

The documentation describes the SQL Server architecture, staging database, enterprise data warehouse, ETL processes, and supporting database objects used throughout the solution.

---

## Documentation Included

The SQL documentation covers the following components:

* STG_FamilyLiving Database
* DW_FamilyFinance Database
* Database Architecture
* ETL Process
* Star Schema Design
* SQL Stored Procedures
* Database Maintenance
* Reporting Views

---

## Source Data

The DW_FamilyFinance project uses financial and payroll data collected from multiple source systems.

Source files are maintained **outside** the Git repository to protect sensitive financial information and personally identifiable information (PII).

### Source Location

```text
OneDrive
└── Family Finance
```

### Source Folders

#### STG_FamilyLiving_Expense

Stores bank transaction files used for expense reporting.

#### Income_Statement

Stores payroll and income source files.

#### STG_Description

Stores lookup files used to standardize expense descriptions.

#### Description_NoMatching

Stores descriptions that require manual review and mapping.

#### STG_Report

Stores legacy reporting and validation files.

---

## Data Flow

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

## Git Repository Policy

To protect sensitive financial information, the following items are **not** stored in this Git repository:

* Bank statements
* Payroll files
* Personal financial data
* Personally Identifiable Information (PII)
* Production source files

The repository contains only:

* SQL scripts
* Documentation
* Sample templates
* Architecture diagrams
* Sanitized examples

---

## Purpose

The SQL documentation serves as a reference for understanding the database architecture, ETL framework, and reporting components of the DW_FamilyFinance solution.

It is intended to support development, maintenance, knowledge sharing, and future enhancements while following enterprise SQL Server development practices.
