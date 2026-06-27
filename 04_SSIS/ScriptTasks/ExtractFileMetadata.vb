'================================================================================
' Script Task  : Extract File Metadata
' Project      : DW_FamilyFinance
' Author       : Behailu Tessema
' Purpose      :
'   Extract metadata from incoming source files and populate SSIS variables.
'
' Description  :
'   This script reads the full file path from an SSIS variable, extracts the file
'   name, standardizes the source/bank name, extracts the file year from the file
'   name, captures the last modified date, and stores the results back into SSIS
'   variables for downstream ETL processing and audit logging.
'
' Business Rules:
'   1. Extract FileName from FullFilePath.
'   2. Extract SourceName from the file name before the first underscore.
'   3. Remove leading/trailing spaces from SourceName.
'   4. Remove embedded spaces from SourceName.
'   5. Standardize known source names such as WellsFargo and Citi.
'   6. Extract FileYear using Regex pattern 20XX.
'   7. Capture FileModifiedDate from the source file.
'
' SSIS Variables:
'   Input:
'       User::FullFilePath
'
'   Output:
'       User::FileName
'       User::SourceName
'       User::FileYear
'       User::FileModifiedDate
'================================================================================

Imports System
Imports System.IO
Imports System.Text.RegularExpressions
Imports Microsoft.SqlServer.Dts.Runtime

<Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute()>
<System.CLSCompliant(False)>
Partial Public Class ScriptMain
    Inherits Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase

    Public Sub Main()

        Try
            Dim fullPath As String
            Dim fileName As String
            Dim sourceName As String
            Dim fileYear As Integer = 0
            Dim fileModifiedDate As DateTime

            ' Read the full file path from the SSIS variable.
            fullPath = Dts.Variables("User::FullFilePath").Value.ToString()

            ' Extract only the file name from the full file path.
            fileName = Path.GetFileName(fullPath)

            ' Extract the source name from the file name.
            ' Example: WellsFargo_2020_YTD.xlsx becomes WellsFargo.
            If fileName.Contains("_") Then
                sourceName = fileName.Split("_"c)(0)
            Else
                sourceName = Path.GetFileNameWithoutExtension(fileName)
            End If

            ' Remove leading and trailing spaces.
            sourceName = sourceName.Trim()

            ' Remove embedded spaces to avoid duplicate source names.
            ' Example: "WellsFargo " and "WellsFargo" both become "WellsFargo".
            sourceName = sourceName.Replace(" ", "")

            ' Standardize known source names.
            Select Case sourceName.ToUpper()
                Case "WELLSFARGO"
                    sourceName = "WellsFargo"

                Case "CITI"
                    sourceName = "Citi"
            End Select

            ' Extract the first year value matching 20XX from the file name.
            Dim match As Match = Regex.Match(fileName, "(20\d{2})")

            If match.Success Then
                fileYear = Convert.ToInt32(match.Value)
            End If

            ' Capture the source file last modified date/time.
            fileModifiedDate = File.GetLastWriteTime(fullPath)

            ' Store extracted metadata into SSIS variables.
            Dts.Variables("User::FileName").Value = fileName
            Dts.Variables("User::SourceName").Value = sourceName
            Dts.Variables("User::FileYear").Value = fileYear
            Dts.Variables("User::FileModifiedDate").Value = fileModifiedDate

            ' Optional debug logging.
            ' Uncomment this section when troubleshooting the SSIS package.
            '
            'Dts.Events.FireInformation(0, "File Metadata", _
            '    "FileName=" & fileName & _
            '    ", SourceName=" & sourceName & _
            '    ", FileYear=" & fileYear & _
            '    ", FileModifiedDate=" & fileModifiedDate.ToString(), _
            '    "", 0, True)

            Dts.TaskResult = ScriptResults.Success

        Catch ex As Exception

            ' Send error details to the SSIS package execution log.
            Dts.Events.FireError(0, "Extract File Metadata Script Task", ex.Message, "", 0)
            Dts.TaskResult = ScriptResults.Failure

        End Try

    End Sub

End Class

Enum ScriptResults
    Success = DTSExecResult.Success
    Failure = DTSExecResult.Failure
End Enum
