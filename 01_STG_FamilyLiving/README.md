# STG_FamilyLiving

## Overview

The **STG_FamilyLiving** database is the staging layer of the DW_FamilyFinance solution.

Its primary responsibility is to collect, validate, and prepare raw financial data before it is loaded into the **DW_FamilyFinance** enterprise data warehouse.

The staging database acts as a controlled landing zone where source data is validated, standardized, audited, and processed through the ETL framework.

---

# Purpose

The STG_FamilyLiving database is responsible for:

* Importing raw source data
* Validating incoming records
* Applying data quality rules
* Preventing duplicate records
* Tracking file metadata
* Maintaining audit history
* Preparing data for the data warehouse

---

# Folder Structure

```text
01_STG_FamilyLiving
│
├── Database
├── StoredProcedures
├── Tables
├── Views
└── Documentation
```

---

# Components

## Database

Contains scripts used to create the staging database.

## Stored Procedures

Contains utility procedures used for staging operations, validation, lookup maintenance, and data quality checks.

## Tables

Contains the staging tables and audit tables used during the ETL process.

## Views

Contains validation and reporting views that support staging operations.

## Documentation

Contains technical documentation describing the staging environment, ETL process, and implementation details.

---

# Key Features

* Raw data ingestion
* Incremental loading support
* Data validation
* Audit logging
* Metadata tracking
* Duplicate prevention
* Lookup management
* ETL preparation

---

# Integration

The staging database receives data from external source files and supplies validated data to the **DW_FamilyFinance** enterprise data warehouse.

```text
Source Files
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

# Summary

The **STG_FamilyLiving** staging database serves as the foundation of the DW_FamilyFinance ETL framework by ensuring that source data is accurate, validated, and ready for loading into the enterprise data warehouse.
