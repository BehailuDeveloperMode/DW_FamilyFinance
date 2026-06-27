# DW_FamilyFinance

## Overview

The **DW_FamilyFinance** folder contains the SQL Server Enterprise Data Warehouse for the Family Finance project.

This layer stores cleansed, validated, and business-ready data using a Star Schema design to support business intelligence reporting, analytics, and Power BI dashboards.

The implementation includes database creation scripts, schemas, dimension and fact tables, ETL stored procedures, reporting views, maintenance scripts, and technical documentation.

---

# Folder Structure

```text
02_DW_FamilyFinance
│
├── Database
├── Documentation
├── Maintenance
├── Schemas
├── StoredProcedures
├── Tables
└── Views
```

---

# Components

## Database

Contains the database creation script.

## Documentation

Contains detailed technical documentation for the data warehouse, including:

* Data Warehouse Documentation
* Database Architecture
* Star Schema Design
* ETL Process

## Maintenance

Contains maintenance scripts used for warehouse administration and data reload operations.

## Schemas

Contains scripts that create the database schemas used throughout the warehouse.

Schemas include:

* dim
* fact
* etl
* rpt

## StoredProcedures

Contains ETL and maintenance stored procedures used to load and maintain the warehouse.

Categories include:

* Dimensions
* Facts
* Master
* ScriptTasks
* Maintenance

## Tables

Contains the SQL scripts that create all dimension and fact tables.

## Views

Contains reporting, audit, and reconciliation views used by Power BI and validation processes.

---

# Key Features

* Enterprise Star Schema
* SQL Server Data Warehouse
* Dimension and Fact Modeling
* Incremental ETL Processing
* Reporting Views
* Audit Framework
* Data Validation
* Reconciliation Framework
* Maintenance Framework
* Power BI Integration

---

# Documentation

Detailed technical documentation is available in the **Documentation** folder.

Topics include:

* Data Warehouse Documentation
* Database Architecture
* Star Schema Design
* ETL Process

---

# Summary

The **DW_FamilyFinance** folder contains the complete enterprise data warehouse implementation for the project. It provides the database objects, ETL processes, reporting layer, and supporting documentation required to deliver a scalable and maintainable Business Intelligence solution.
