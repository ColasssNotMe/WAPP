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
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["UserType"] = "All";
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

            string query = "SELECT * FROM [User]";

            if (userType == "Student")
            {
                query = "SELECT * FROM [User] WHERE [role] = @role";
            }
            else if (userType == "Teacher")
            {
                query = "SELECT * FROM [User] WHERE [role] = @role AND [status] <> 'Pending'";
            }
            else if (userType == "Pending")
            {
                query = "SELECT * FROM [User] WHERE [role] = @role AND [status] = @status";
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

                query += "((firstName + ' ' + lastName) LIKE @search OR username LIKE @search OR email LIKE @search)";
            }

            query += " ORDER BY firstName, lastName";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (userType == "Student")
                {
                    cmd.Parameters.AddWithValue("@role", "Student");
                }
                else if (userType == "Teacher")
                {
                    cmd.Parameters.AddWithValue("@role", "Teacher");
                }
                else if (userType == "Pending")
                {
                    cmd.Parameters.AddWithValue("@role", "Teacher");
                    cmd.Parameters.AddWithValue("@status", "Pending");
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

            // Update the selected tab
            btnAllUsers.CssClass = userType == "All" ? "tab active" : "tab";
            btnStudents.CssClass = userType == "Student" ? "tab active" : "tab";
            btnTeachers.CssClass = userType == "Teacher" ? "tab active" : "tab";
            btnPendingTeachers.CssClass = userType == "Pending" ? "tab active" : "tab";

            // Update the section title
            if (userType == "Student")
            {
                lblSectionTitle.Text = "Students";
            }
            else if (userType == "Teacher")
            {
                lblSectionTitle.Text = "Teachers";
            }
            else if (userType == "Pending")
            {
                lblSectionTitle.Text = "Pending Teachers";
            }
            else
            {
                lblSectionTitle.Text = "All Users";
            }

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

                SqlCommand pendingCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM [User] WHERE [role] = @role AND [status] = @status",
                    conn);

                pendingCmd.Parameters.AddWithValue("@role", "Teacher ");
                pendingCmd.Parameters.AddWithValue("@status", "Pending");

                lblPendingCount.Text = pendingCmd.ExecuteScalar().ToString();
            }
        }

        protected string GetStatusClass(object status)
        {
            string value = Convert.ToString(status);

            if (value == "Active")
            {
                return "status status--active";
            }
            else if (value == "Pending")
            {
                return "status status--pending";
            }
            else
            {
                return "status status--disabled";
            }
        }
    }
}