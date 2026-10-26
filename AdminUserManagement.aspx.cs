using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class AdminUserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserID"] == null)
            //{
            //    Response.Redirect("Login.aspx");
            //    return;
            //}

            if (!IsPostBack)
            {
                ViewState["UserType"] = "All";

                if (Request.QueryString["tab"] == "pending")
                {
                    ViewState["UserType"] = "Pending";
                }
                loadUsers();
            }
        }

        protected void btnAllUsers_Click(object sender, EventArgs e)
        {
            ViewState["UserType"] = "All";
            txtSearch.Text = "";
            loadUsers();
        }

        protected void btnStudents_Click(object sender, EventArgs e)
        {
            ViewState["UserType"] = "Student";
            txtSearch.Text = "";
            loadUsers();
        }

        protected void btnTeachers_Click(object sender, EventArgs e)
        {
            ViewState["UserType"] = "Teacher";
            txtSearch.Text = "";
            loadUsers();
        }

        protected void btnPendingTeachers_Click(object sender, EventArgs e)
        {
            ViewState["UserType"] = "Pending";
            txtSearch.Text = "";
            loadUsers();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loadUsers();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            loadUsers();
        }

        private void loadUsers()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string userType = ViewState["UserType"].ToString();

            string query = @"
        SELECT U.*, T.approved
        FROM [User] U
        LEFT JOIN Teacher T ON U.UserID = T.UserID";

            if (userType == "Student")
            {
                query += " WHERE U.[role] = @role";
            }
            else if (userType == "Teacher")
            {
                query += " WHERE U.[role] = @role AND T.[approved] = @approved";
            }
            else if (userType == "Pending")
            {
                query += " WHERE U.[role] = @role AND T.[approved] = @approved";
            }

            string search = txtSearch.Text.Trim();

            if (search != "")
            {
                if (query.Contains("WHERE"))
                {
                    query += " AND ";
                }
                else
                {
                    query += " WHERE ";
                }

                query += @"(
            (U.firstName + ' ' + U.lastName) LIKE @search
            OR U.username LIKE @search
            OR U.email LIKE @search
        )";
            }

            query += " ORDER BY U.firstName, U.lastName";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (userType == "Student")
                {
                    cmd.Parameters.AddWithValue("@role", "Student");
                }
                else if (userType == "Teacher" || userType == "Pending")
                {
                    cmd.Parameters.AddWithValue("@role", "Teacher");
                    cmd.Parameters.AddWithValue(
                        "@approved", userType == "Teacher");
                }

                if (search != "")
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                UserRepeater.DataSource = dt;
                UserRepeater.DataBind();

                lblSectionCount.Text = dt.Rows.Count.ToString();
                lblShowing.Text = dt.Rows.Count.ToString();
                lblTotal.Text = dt.Rows.Count.ToString();

                emptyMessage.Visible = dt.Rows.Count == 0;

                if (dt.Rows.Count == 0)
                {
                    emptyMessage.Controls.Clear();
                    emptyMessage.Controls.Add(
                        new System.Web.UI.LiteralControl("No user accounts found."));
                }
            }

            btnAllUsers.CssClass =
                userType == "All" ? "tab active" : "tab";

            btnStudents.CssClass =
                userType == "Student" ? "tab active" : "tab";

            btnTeachers.CssClass =
                userType == "Teacher" ? "tab active" : "tab";

            btnPendingTeachers.CssClass =
                userType == "Pending" ? "tab active" : "tab";

            if (userType == "Student")
                lblSectionTitle.Text = "Students";
            else if (userType == "Teacher")
                lblSectionTitle.Text = "Teachers";
            else if (userType == "Pending")
                lblSectionTitle.Text = "Pending Teachers";
            else
                lblSectionTitle.Text = "All Users";

            loadCounts();
        }

        private void loadCounts()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand totalCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM [User]", conn);

                lblTotalUsers.Text = totalCmd.ExecuteScalar().ToString();

                SqlCommand pendingCmd = new SqlCommand(@"
                    SELECT COUNT(*)
                    FROM [User] U
                    INNER JOIN Teacher T ON U.UserID = T.UserID
                    WHERE U.[role] = @role
                    AND T.[approved] = @approved", conn);

                pendingCmd.Parameters.AddWithValue("@role", "Teacher");
                pendingCmd.Parameters.AddWithValue("@approved", false);

                lblPendingCount.Text =
                    pendingCmd.ExecuteScalar().ToString();
            }
        }

        protected string GetStatusText(object approved)
        {
            if (approved == null || approved == DBNull.Value)
            {
                return "Active";
            }

            if (Convert.ToBoolean(approved))
            {
                return "Approved";
            }
            else
            {
                return "Pending";
            }
        }
    }
}