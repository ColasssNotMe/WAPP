using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public static class Logger
    {
        private static readonly string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        public static void LogActivity(string description)
        {
            try
            {
                string sql = @"
                    INSERT INTO [Syslog] (Id, description, createdAt) 
                    VALUES (
                        (SELECT ISNULL(MAX(Id), 0) + 1 FROM [Syslog] WITH (UPDLOCK, HOLDLOCK)), 
                        @description, 
                        GETDATE()
                    )";

                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@description", description);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // If it fails, show the error on the screen so you know why!
                if (System.Web.HttpContext.Current != null && System.Web.HttpContext.Current.Handler is Page page)
                {
                    page.Response.Write("<div style='background:red;color:white;padding:10px;position:fixed;top:0;z-index:9999;'>LOGGER ERROR: " + ex.Message + "</div>");
                }
            }
        }
    }
}