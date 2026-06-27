# Power BI

## Overview

The **Power BI** layer is the presentation and analytics component of the **DW_FamilyFinance** solution.

It transforms the curated data stored in the SQL Server data warehouse into interactive dashboards, executive reports, and business intelligence insights. The semantic model is built on a Star Schema design and uses enterprise DAX measures to deliver consistent, reusable, and high-performance analytics.

---

# Purpose

The Power BI solution is responsible for:

* Visualizing family income and expense data
* Monitoring key financial performance indicators (KPIs)
* Supporting executive decision-making
* Providing interactive reporting and drill-down analysis
* Delivering reusable business calculations through DAX
* Presenting historical trends and financial insights

---

# Folder Structure

```text
03_PowerBI
│
├── Documentation
├── DAX
├── Images
└── README.md
```

---

# Components

## Documentation

Contains technical documentation for the Power BI solution, including the Enterprise DAX Measure Library and dashboard documentation.

## DAX

Contains reusable DAX measures, calculated columns, calculated tables, and supporting business logic used throughout the semantic model.

## Images

Contains screenshots of report pages, dashboard layouts, data models, and other visual documentation used throughout the project.

---

# Power BI Features

* Enterprise semantic model
* Interactive dashboards
* Executive KPI reporting
* Dynamic report titles
* Time intelligence calculations
* Conditional formatting
* Financial analytics
* Payroll analysis
* Expense analysis
* Savings analysis
* Drill-through reporting

---

# Report Pages

The Power BI solution includes the following report pages:

* Executive Summary
* Expense Analysis
* Income Analysis
* Savings Analysis
* Validation Dashboard

---

# Data Source

The Power BI semantic model connects to the **DW_FamilyFinance** SQL Server data warehouse, which is populated through the **STG_FamilyLiving** staging environment and SSIS ETL framework.

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

# Documentation

Additional technical documentation for the Power BI solution is available in the **Documentation** folder.

Topics include:

* Enterprise DAX Measure Library
* Dashboard Design
* KPI Framework
* Semantic Model
* Report Documentation

---

# Summary

The **Power BI** layer provides the DW_FamilyFinance solution's business intelligence and reporting capabilities. By combining a well-designed semantic model, enterprise DAX measures, and interactive dashboards, it delivers meaningful financial insights while following modern business intelligence best practices.
