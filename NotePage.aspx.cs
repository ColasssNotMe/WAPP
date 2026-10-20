
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class MaterialPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPDF();
            }
        }

        private void LoadPDF()
        {
            if (Session["materialId"] == null)
            {
                ShowError();
                return;
            }

            int materialId;

            if (!int.TryParse(
                Session["materialId"].ToString(),
                out materialId))
            {
                ShowError();
                return;
            }

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["WAPP"]
                    .ConnectionString;

            string query = @"
                SELECT fileURL
                FROM Material
                WHERE materialID = @materialID
                  AND status = 'Active'";

            using (SqlConnection conn =
                new SqlConnection(connectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            {
                cmd.Parameters.Add(
                    "@materialID", SqlDbType.Int
                ).Value = materialId;

                conn.Open();

                object result = cmd.ExecuteScalar();

                if (result == null ||
                    result == DBNull.Value)
                {
                    ShowError();
                    return;
                }

                string fileURL = result.ToString();

                if (fileURL.StartsWith("~/"))
                {
                    fileURL = ResolveUrl(fileURL);
                }

                pdfFrame.Attributes["src"] = fileURL;
            }
        }

        private void ShowError()
        {
            pdfFrame.Visible = false;
            materialNotFound.Visible = true;
        }
    }
}
