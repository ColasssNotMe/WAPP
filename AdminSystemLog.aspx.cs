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
        private const int PageSize = 12;

        private int CurrentPage
        {
            get { return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1; }
            set { ViewState["CurrentPage"] = value; }
        }

        private int TotalPages
        {
            get { return ViewState["TotalPages"] != null ? (int)ViewState["TotalPages"] : 1; }
            set { ViewState["TotalPages"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                CurrentPage = 1;
                LoadLogs();
            }
        }

        private void LoadLogs()
        {
            string searchTerm = txtSearch.Text.Trim();
            string searchParam = string.IsNullOrEmpty(searchTerm) ? "" : "%" + searchTerm + "%";

            string countSql = "SELECT COUNT(*) FROM [Syslog] WHERE (@Search = '' OR description LIKE @Search)";
            int totalRecords = 0;

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(countSql, conn))
            {
                cmd.Parameters.AddWithValue("@Search", searchParam);
                conn.Open();
                totalRecords = Convert.ToInt32(cmd.ExecuteScalar());
            }

            TotalPages = (int)Math.Ceiling((double)totalRecords / PageSize);
            if (TotalPages == 0) TotalPages = 1;
            if (CurrentPage > TotalPages) CurrentPage = TotalPages;

            
            string sql = @"
                SELECT description, createdAt
                FROM [Syslog]
                WHERE (@Search = '' OR description LIKE @Search)
                ORDER BY createdAt DESC, Id DESC
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Search", searchParam);
                cmd.Parameters.AddWithValue("@Offset", (CurrentPage - 1) * PageSize);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }

            rptLogs.DataSource = dt;
            rptLogs.DataBind();

            int startRecord = totalRecords == 0 ? 0 : ((CurrentPage - 1) * PageSize) + 1;
            int endRecord = Math.Min(CurrentPage * PageSize, totalRecords);

            totalLogs.InnerText = totalRecords + " logs";
            lblTotalRecords.Text = totalRecords.ToString();
            lblShowing.Text = startRecord.ToString();
            lblEndRecord.Text = endRecord.ToString();

            lblPageInfo.Text = $"Page {CurrentPage} of {TotalPages}";

            btnPrevPage.Enabled = CurrentPage > 1;
            btnNextPage.Enabled = CurrentPage < TotalPages;
        }

        protected void btnPrevPage_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
                LoadLogs();
            }
        }

        protected void btnNextPage_Click(object sender, EventArgs e)
        {
            if (CurrentPage < TotalPages)
            {
                CurrentPage++;
                LoadLogs();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 1;
            LoadLogs();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            CurrentPage = 1;
            LoadLogs();
        }
    }
}