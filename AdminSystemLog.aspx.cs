using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class AdminSystemLog : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadLogs();
            }
        }

        private void LoadLogs()
        {
            string sql = @"
                SELECT Id, description, createdAt
                FROM [Syslog]
                WHERE (@Search = '' OR description LIKE @Search)
                ORDER BY createdAt DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                string searchTerm = txtSearch.Text.Trim();
                cmd.Parameters.AddWithValue("@Search", string.IsNullOrEmpty(searchTerm) ? "" : "%" + searchTerm + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }

            rptLogs.DataSource = dt;
            rptLogs.DataBind();

            totalLogs.InnerText = dt.Rows.Count + " logs";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadLogs();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadLogs();
        }
    }
}