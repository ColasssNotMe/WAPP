
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
                SELECT fileURL,title,chapter
                FROM Material
                WHERE materialID = @materialID
                  AND status = 'Published'";

            using (SqlConnection conn =
                new SqlConnection(connectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            {
                cmd.Parameters.Add(
                    "@materialID", SqlDbType.Int
                ).Value = materialId;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        string fileURL = reader["fileURL"].ToString();
                        string title = reader["title"].ToString();
                        string chapter = reader["chapter"].ToString();
                        titleLabel.InnerText = " / " + title;
                        chapterLabel.InnerText = " / " + chapter;
                        if (fileURL.StartsWith("~/"))
                        {
                            fileURL = ResolveUrl(fileURL);
                        }
                        pdfFrame.Attributes["src"] = fileURL;
                    }
                    else
                    {
                        ShowError();
                    }
                }
            }
        }

        private void ShowError()
        {
            pdfFrame.Visible = false;
            materialNotFound.Visible = true;
        }
    }
}
