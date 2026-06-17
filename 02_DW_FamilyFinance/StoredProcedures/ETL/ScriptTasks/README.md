# SSIS Script Task: Extract File Metadata

## Project
**DW_FamilyFinance**

## Purpose
This SSIS Script Task extracts metadata from incoming bank source files before the ETL load process begins. It standardizes the source name, extracts the file year, captures the file name, and stores the file modified date into SSIS variables.

This helps the ETL package load files consistently and supports audit tracking in the staging database.

## Business Problem
Some source files may have inconsistent spacing in the file name, such as:

```text
WellsFargo_2020_YTD.xlsx
WellsFargo _2020_YTD.xlsx
```

Without cleaning the source name, the ETL process may treat these as different banks. This script fixes that problem by trimming spaces and standardizing source names before loading data.

## Input Example

```text
WellsFargo _2020_YTD.xlsx
```

## Output Example

```text
FileName         = WellsFargo _2020_YTD.xlsx
SourceName       = WellsFargo
FileYear         = 2020
FileModifiedDate = File last modified date/time
```

## SSIS Variables Used

| Variable Name | Direction | Description |
|---|---:|---|
| `User::FullFilePath` | Input | Full path of the source file being processed |
| `User::FileName` | Output | File name only, without folder path |
| `User::SourceName` | Output | Standardized bank/source name |
| `User::FileYear` | Output | Year extracted from the file name |
| `User::FileModifiedDate` | Output | Last modified date/time of the source file |

## Business Rules

1. Extract the file name from the full file path.
2. Extract the source name from the text before the first underscore.
3. Remove leading and trailing spaces.
4. Remove embedded spaces to prevent duplicate source names.
5. Standardize known source names:
   - `WELLSFARGO` becomes `WellsFargo`
   - `CITI` becomes `Citi`
6. Extract the first year matching the pattern `20XX`.
7. Capture the file last modified date/time.
8. Store all extracted metadata in SSIS variables.

## Technologies Demonstrated

- SQL Server Integration Services, SSIS
- VB.NET Script Task
- File metadata extraction
- Regex pattern matching
- ETL automation
- Source name standardization
- Audit-ready ETL design

## Suggested GitHub Location

```text
DW_FamilyFinance/
└── ETL/
    └── ScriptTasks/
        ├── ExtractFileMetadata.vb
        └── README.md
```

## Author
**Behailu Tessema**

