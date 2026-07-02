using System;
using System.Data;
using System.Data.OleDb;
using Microsoft.SqlServer.Dts.Runtime;

namespace ST_WellsFargo_MaxDate
{
    [Microsoft.SqlServer.Dts.Tasks.ScriptTask.SSISScriptTaskEntryPointAttribute]
    public partial class ScriptMain : Microsoft.SqlServer.Dts.Tasks.ScriptTask.VSTARTScriptObjectModelBase
    {
        public void Main()
        {
            try
            {
                const string fallbackDate = "1900-01-01";

                object resultObject = Dts.Variables["User::WellsFargo_MaxDate_Obj"].Value;
                string maxDateValue = GetMaxDateFromResultSet(resultObject, fallbackDate);

                Dts.Variables["User::WellsFargo_MaxDate_Str"].Value = maxDateValue;

                bool fireAgain = true;
                Dts.Events.FireInformation(
                    0,
                    "SCR_ConvertMaxDate_WellsFargo",
                    "Wells Fargo maximum transaction date captured: " + maxDateValue,
                    string.Empty,
                    0,
                    ref fireAgain
                );

                Dts.TaskResult = (int)ScriptResults.Success;
            }
            catch (Exception ex)
            {
                Dts.Events.FireError(
                    0,
                    "SCR_ConvertMaxDate_WellsFargo",
                    "Failed to convert Wells Fargo maximum transaction date. Error: " + ex.Message,
                    string.Empty,
                    0
                );

                Dts.TaskResult = (int)ScriptResults.Failure;
            }
        }

        private string GetMaxDateFromResultSet(object resultObject, string fallbackDate)
        {
            if (resultObject == null)
            {
                return fallbackDate;
            }

            DataTable dt = new DataTable();

            using (OleDbDataAdapter adapter = new OleDbDataAdapter())
            {
                adapter.Fill(dt, resultObject);
            }

            if (dt.Rows.Count == 0)
            {
                return fallbackDate;
            }

            object maxDate = dt.Rows[0][0];

            if (maxDate == null || maxDate == DBNull.Value)
            {
                return fallbackDate;
            }

            return maxDate.ToString();
        }

        enum ScriptResults
        {
            Success = DTSExecResult.Success,
            Failure = DTSExecResult.Failure
        }
    }
}