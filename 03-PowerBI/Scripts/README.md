# Power BI Scripts

## Overview

This folder contains utility scripts used during the development and documentation of the **DW_FamilyFinance** Power BI solution.

These scripts are not part of the Power BI semantic model. Instead, they automate common development tasks such as exporting DAX measures, documenting calculated objects, and supporting model maintenance.

---

# Current Scripts

## Export_DAX_From_TabularEditor.cs

Exports the following objects from the Power BI semantic model using **Tabular Editor**:

* DAX Measures
* Calculated Columns
* Calculated Tables

The script generates a text file containing all DAX expressions, making it easier to:

* Document business logic
* Maintain version history
* Review DAX changes
* Share calculations without distributing the Power BI (.pbix) file

---

# Requirements

* Power BI Desktop
* Tabular Editor
* A Power BI semantic model

---

# Purpose

The scripts in this folder support documentation, development, and maintenance of the Power BI solution while following enterprise Business Intelligence development practices.
