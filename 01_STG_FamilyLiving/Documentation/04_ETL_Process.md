# ETL_Process

# DW_FamilyFinance ETL Process

## Overview

The **DW_FamilyFinance** ETL (Extract, Transform, Load) framework automates the movement of financial data from source files into the enterprise data warehouse.

The ETL process is designed to ensure data quality, prevent duplicate records, support incremental loading, and provide a reliable foundation for reporting and analytics.

---

# ETL Objectives

The ETL framework is designed to:

* Import financial data from multiple sources
* Validate incoming data
* Prevent duplicate records
* Support incremental data loading
* Maintain historical information
* Generate audit logs
* Load data into the enterprise data warehouse
* Prepare data for Power BI reporting

---

# ETL Architecture

```text
Source Files
(Excel / Google Sheets / Payroll)
            │
            ▼
    STG_FamilyLiving
      (Extraction)
            │
            ▼
     Data Validation
            │
            ▼
    Data Transformation
            │
            ▼
   DW_FamilyFinance
            │
            ▼
     Reporting Views
            │
            ▼
 Power BI Semantic Model
```

---

# ETL Workflow

The ETL process follows four major phases.

## Phase 1 – Extract

The extraction process imports raw source data into the staging database.

Source files include:

* Expense transactions
* Payroll records
* Description lookup tables

Imported data is stored without modifying the original business information.

---

## Phase 2 – Transform

The transformation process prepares the data for reporting.

Transformation activities include:

* Data validation
* Data cleansing
* Standardization
* Duplicate detection
* Business rule validation
* Lookup matching
* Metadata generation

---

## Phase 3 – Load

Validated data is loaded into the enterprise data warehouse.

Loading sequence:

1. Dimension Tables
2. Fact Tables
3. Reporting Views

This sequence maintains referential integrity between dimensions and facts.

---

## Phase 4 – Report

The reporting layer exposes curated views used by Power BI.

The semantic model retrieves data from these views to power dashboards and business reports.

---

# SSIS Packages

The ETL framework consists of four primary SSIS packages.

---

## STG_LoadDescriptionData

### Purpose

Loads and maintains the description lookup table.

### Responsibilities

* Import lookup data
* Prevent duplicate records
* Validate descriptions
* Track audit information

---

## STG_LoadIncomeData

### Purpose

Loads payroll and income records.

### Responsibilities

* Import payroll data
* Perform incremental loading using Pay Day
* Validate row counts
* Generate audit records

---

## STG_LoadExpenseData

### Purpose

Loads expense transaction data.

### Responsibilities

* Import expense files
* Process OneDrive source files
* Track file metadata
* Detect updated files
* Reload modified data
* Maintain audit history

---

## STG_Master_Incremental

### Purpose

Coordinates the execution of all ETL packages.

### Execution Order

```text
STG_LoadDescriptionData
          │
          ▼
STG_LoadIncomeData
          │
          ▼
STG_LoadExpenseData
```

The master package ensures that dependent processes execute in the correct order.

---

# Incremental Loading Strategy

The ETL framework minimizes processing time by loading only new or modified records.

## Expense Data

Incremental loading is based on:

* File Modified Date
* Audit history
* Existing warehouse records

## Income Data

Incremental loading is based on:

* Pay Day
* Maximum processed date

## Lookup Data

Incremental loading is based on:

* Description existence
* Duplicate detection

---

# Data Validation

The ETL process performs several validation checks before loading data.

Validation includes:

* Required field validation
* Duplicate detection
* Date validation
* Data type validation
* Lookup verification
* Row count verification

Only validated records are loaded into the data warehouse.

---

# Audit Framework

The ETL process maintains audit information for every load.

Audit information includes:

* Load date
* Source file
* Number of records processed
* Number of records inserted
* Number of records updated
* ETL execution status

The audit framework supports troubleshooting and operational monitoring.

---

# Error Handling

The ETL framework is designed to handle errors gracefully.

Examples include:

* Invalid source files
* Duplicate records
* Missing lookup values
* Data validation failures
* File processing errors

Errors are captured through the audit process to simplify investigation and correction.

---

# Benefits

The ETL framework provides:

* Automated data processing
* Improved data quality
* Reduced manual effort
* Reliable historical reporting
* Faster refresh times
* Consistent business rules
* Scalable data loading

---

# Integration with the Data Warehouse

The ETL framework supplies clean and validated data to the DW_FamilyFinance warehouse.

The warehouse then provides:

* Dimension tables
* Fact tables
* Reporting views

These objects serve as the data source for the Power BI semantic model and executive dashboards.

---

# Summary

The DW_FamilyFinance ETL framework provides a structured, automated, and reliable process for moving financial data from source systems into the enterprise data warehouse.

By combining incremental loading, data validation, audit logging, and SSIS automation, the framework delivers a scalable solution that supports high-quality analytics and business intelligence reporting.
