
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminUserManagement : Page
    {
        private string ConnString =>
            ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        private int? SelectedUserId
        {
            get => ViewState["SelectedUserID"] as int?;
            set => ViewState["SelectedUserID"] = value;
        }

        private bool IsEditMode =>
            Convert.ToBoolean(ViewState["EditMode"]);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["UserType"] =
                    Request.QueryString["tab"] == "pending" ? "Pending" : "All";

                ViewState["EditMode"] = false;
                loadUsers();
            }
        }

        // Tabs

        protected void btnAllUsers_Click(object sender, EventArgs e) =>
            ChangeTab("All");

        protected void btnStudents_Click(object sender, EventArgs e) =>
            ChangeTab("Student");

        protected void btnTeachers_Click(object sender, EventArgs e) =>
            ChangeTab("Teacher");

        protected void btnPendingTeachers_Click(object sender, EventArgs e) =>
            ChangeTab("Pending");

        private void ChangeTab(string type)
        {
            ViewState["UserType"] = type;
            ViewState["EditMode"] = false;
            txtSearch.Text = "";
            loadUsers();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["EditMode"] = false;
            loadUsers();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ViewState["EditMode"] = false;
            loadUsers();
        }

        protected void UserRepeater_ItemCommand(
            object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "SelectUser")
                return;

            SelectedUserId = Convert.ToInt32(e.CommandArgument);
            ViewState["EditMode"] = false;
            loadUsers();
        }

        // Edit account

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ViewState["EditMode"] = true;
            ViewState["FillEdit"] = true;
            loadUsers();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ViewState["EditMode"] = false;
            loadUsers();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (SelectedUserId == null)
                return;

            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string school = txtSchool.Text.Trim();
            string grade = txtGrade.Text.Trim();

            if (string.IsNullOrWhiteSpace(firstName) ||
                string.IsNullOrWhiteSpace(lastName) ||
                string.IsNullOrWhiteSpace(username) ||
                string.IsNullOrWhiteSpace(email))
            {
                ShowMessage(
                    "First name, last name, username and email are required.",
                    false);
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", false);
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();

                    string checkSql = @"
                        SELECT COUNT(*)
                        FROM [User]
                        WHERE (username = @username OR email = @email)
                        AND userID <> @userID";

                    using (SqlCommand cmd = new SqlCommand(checkSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue(
                            "@userID", SelectedUserId.Value);

                        if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                        {
                            ShowMessage(
                                "That username or email is already in use.",
                                false);
                            return;
                        }
                    }

                    string role;

                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT [role] FROM [User] WHERE userID = @userID",
                        conn))
                    {
                        cmd.Parameters.AddWithValue(
                            "@userID", SelectedUserId.Value);

                        role = Convert.ToString(cmd.ExecuteScalar());
                    }

                    using (SqlTransaction tx = conn.BeginTransaction())
                    {
                        try
                        {
                            string updateUser = @"
                                UPDATE [User]
                                SET firstName = @firstName,
                                    lastName = @lastName,
                                    username = @username,
                                    email = @email
                                WHERE userID = @userID";

                            using (SqlCommand cmd = new SqlCommand(
                                updateUser, conn, tx))
                            {
                                cmd.Parameters.AddWithValue("@firstName", firstName);
                                cmd.Parameters.AddWithValue("@lastName", lastName);
                                cmd.Parameters.AddWithValue("@username", username);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue(
                                    "@userID", SelectedUserId.Value);

                                cmd.ExecuteNonQuery();
                            }

                            string updateRole = "";

                            if (role == "Student")
                            {
                                updateRole = @"
                                    UPDATE Student
                                    SET school = @school,
                                        gradeLevel = @grade
                                    WHERE userID = @userID";
                            }
                            else if (role == "Teacher")
                            {
                                updateRole = @"
                                    UPDATE Teacher
                                    SET school = @school
                                    WHERE userID = @userID";
                            }

                            if (updateRole != "")
                            {
                                using (SqlCommand cmd = new SqlCommand(
                                    updateRole, conn, tx))
                                {
                                    cmd.Parameters.AddWithValue(
                                        "@school", ToDb(school));

                                    cmd.Parameters.AddWithValue(
                                        "@userID", SelectedUserId.Value);

                                    if (role == "Student")
                                    {
                                        cmd.Parameters.AddWithValue(
                                            "@grade", ToDb(grade));
                                    }

                                    cmd.ExecuteNonQuery();
                                }
                            }

                            tx.Commit();
                        }
                        catch
                        {
                            tx.Rollback();
                            throw;
                        }
                    }
                }

                ViewState["EditMode"] = false;
                loadUsers();
                ShowMessage("Account updated successfully.", true);
            }
            catch (SqlException)
            {
                ShowMessage(
                    "Could not update the account. Please check the values and try again.",
                    false);
            }
        }

        // Delete account

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (SelectedUserId == null)
                return;

            if (Convert.ToString(Session["UserID"]) ==
                SelectedUserId.Value.ToString())
            {
                ShowMessage("You cannot delete your own account.", false);
                return;
            }

            string name = lblDetName.Text;

            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                conn.Open();

                using (SqlTransaction tx = conn.BeginTransaction())
                {
                    try
                    {
                        string[] queries =
                        {
                            "DELETE FROM Student WHERE userID = @userID",
                            "DELETE FROM Teacher WHERE userID = @userID",
                            "DELETE FROM [User] WHERE userID = @userID"
                        };

                        foreach (string query in queries)
                        {
                            using (SqlCommand cmd = new SqlCommand(
                                query, conn, tx))
                            {
                                cmd.Parameters.AddWithValue(
                                    "@userID", SelectedUserId.Value);

                                cmd.ExecuteNonQuery();
                            }
                        }

                        tx.Commit();
                    }
                    catch (SqlException)
                    {
                        tx.Rollback();

                        ShowMessage(
                            "This account cannot be deleted because other records depend on it.",
                            false);
                        return;
                    }
                }
            }

            SelectedUserId = null;
            ViewState["EditMode"] = false;
            loadUsers();
            ShowMessage(name + "'s account has been deleted.", true);
        }

        // Approve / Reject teacher

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            UpdateTeacherApproval(true, "has been approved.");
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            UpdateTeacherApproval(false, "has been rejected.");
        }

        private void UpdateTeacherApproval(bool approved, string message)
        {
            if (SelectedUserId == null)
                return;

            string name = lblDetName.Text;

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE Teacher SET approved = @approved WHERE userID = @userID",
                conn))
            {
                // Keep approved as a Boolean.
                cmd.Parameters.Add("@approved", SqlDbType.Bit).Value = approved;
                cmd.Parameters.AddWithValue(
                    "@userID", SelectedUserId.Value);

                conn.Open();

                if (cmd.ExecuteNonQuery() == 0)
                {
                    ShowMessage("Teacher account was not found.", false);
                    return;
                }
            }

            ViewState["EditMode"] = false;
            loadUsers();
            ShowMessage(name + " " + message, true);
        }

        // Load users

        private void loadUsers()
        {
            string type = Convert.ToString(ViewState["UserType"]);
            if (string.IsNullOrEmpty(type))
                type = "All";

            string search = txtSearch.Text.Trim();

            string sql = @"
                SELECT U.*, T.approved
                FROM [User] U
                LEFT JOIN Teacher T ON U.userID = T.userID";

            if (type == "Student")
                sql += " WHERE U.[role] = @role";
            else if (type == "Teacher" || type == "Pending")
                sql += " WHERE U.[role] = @role AND T.approved = @approved";

            if (search != "")
            {
                sql += sql.Contains("WHERE") ? " AND " : " WHERE ";

                sql += @"
                    (U.firstName + ' ' + U.lastName LIKE @search
                    OR U.username LIKE @search
                    OR U.email LIKE @search)";
            }

            sql += " ORDER BY U.firstName, U.lastName";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (type == "Student" ||
                    type == "Teacher" ||
                    type == "Pending")
                {
                    cmd.Parameters.AddWithValue(
                        "@role", type == "Student" ? "Student" : "Teacher");
                }

                if (type == "Teacher" || type == "Pending")
                {
                    // true = approved teacher; false = pending teacher.
                    cmd.Parameters.Add("@approved", SqlDbType.Bit).Value =
                        type == "Teacher";
                }

                if (search != "")
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            EnsureRowSelected(dt);

            thStatus.Visible = type == "Pending";
            UserRepeater.DataSource = dt;
            UserRepeater.DataBind();

            lblSectionCount.Text = dt.Rows.Count.ToString();
            lblShowing.Text = dt.Rows.Count.ToString();
            lblTotal.Text = dt.Rows.Count.ToString();
            emptyMessage.Visible = dt.Rows.Count == 0;

            btnAllUsers.CssClass =
                type == "All" ? "tab active" : "tab";
            btnStudents.CssClass =
                type == "Student" ? "tab active" : "tab";
            btnTeachers.CssClass =
                type == "Teacher" ? "tab active" : "tab";
            btnPendingTeachers.CssClass =
                type == "Pending" ? "tab active" : "tab";

            lblSectionTitle.Text =
                type == "Student" ? "Students" :
                type == "Teacher" ? "Teachers" :
                type == "Pending" ? "Pending Teachers" : "All Users";

            loadCounts();
            loadDetails();
        }

        private void EnsureRowSelected(DataTable dt)
        {
            if (dt.Rows.Count == 0)
            {
                SelectedUserId = null;
                return;
            }

            if (SelectedUserId != null &&
                dt.Select("userID = " + SelectedUserId.Value).Length > 0)
                return;

            SelectedUserId = Convert.ToInt32(dt.Rows[0]["userID"]);
            ViewState["EditMode"] = false;
        }

        // Counts

        private void loadCounts()
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM [User]", conn))
                {
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Teacher WHERE approved = @approved",
                    conn))
                {
                    // Boolean false, not integer 0.
                    cmd.Parameters.Add("@approved", SqlDbType.Bit).Value = false;

                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    lblPendingCount.Text = count.ToString();
                    pendingNotice.Visible = count > 0;
                }
            }
        }

        // Selected user details

        private void loadDetails()
        {
            pnlMessage.Visible = false;

            if (SelectedUserId == null)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            string sql = @"
                SELECT U.firstName, U.lastName, U.username, U.email,
                       U.[role], U.dateRegistered,
                       S.school AS studentSchool, S.gradeLevel,
                       T.school AS teacherSchool, T.approved
                FROM [User] U
                LEFT JOIN Student S ON U.userID = S.userID
                LEFT JOIN Teacher T ON U.userID = T.userID
                WHERE U.userID = @userID";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            if (dt.Rows.Count == 0)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            pnlDetails.Visible = true;
            pnlNoSelection.Visible = false;

            DataRow row = dt.Rows[0];
            string role = Convert.ToString(row["role"]);
            bool editMode = IsEditMode;
            bool pendingTab =
                Convert.ToString(ViewState["UserType"]) == "Pending";

            lblDetName.Text =
                row["firstName"] + " " + row["lastName"];
            lblDetUsername.Text = GetText(row["username"]);
            lblDetEmail.Text = GetText(row["email"]);
            lblDetRole.Text = role;
            lblDetJoined.Text = GetDate(row["dateRegistered"]);
            lblDetApproval.Text = GetStatusText(row["approved"]);

            string school = role == "Student"
                ? Convert.ToString(row["studentSchool"])
                : role == "Teacher"
                    ? Convert.ToString(row["teacherSchool"])
                    : "";

            lblDetSchool.Text = GetText(school);
            lblDetGrade.Text = GetText(row["gradeLevel"]);

            dtGrade.Visible = ddGrade.Visible = role == "Student";
            fieldGrade.Visible = role == "Student";
            fieldSchool.Visible = role == "Student" || role == "Teacher";

            dtApproval.Visible = ddApproval.Visible = pendingTab;

            pnlView.Visible = !editMode;
            pnlEdit.Visible = editMode;

            // Pending teachers get Approve / Reject buttons.
            pnlActions.Visible = !editMode && !pendingTab;
            pnlApprovalActions.Visible = !editMode && pendingTab;

            if (editMode && ViewState["FillEdit"] != null)
            {
                txtFirstName.Text = Convert.ToString(row["firstName"]);
                txtLastName.Text = Convert.ToString(row["lastName"]);
                txtUsername.Text = Convert.ToString(row["username"]);
                txtEmail.Text = Convert.ToString(row["email"]);
                txtSchool.Text = school;
                txtGrade.Text = Convert.ToString(row["gradeLevel"]);

                ViewState["FillEdit"] = null;
            }
        }

        // Helpers

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = Server.HtmlEncode(message);
            pnlMessage.CssClass = success
                ? "message message--success"
                : "message message--error";

            pnlMessage.Visible = true;
        }

        private static object ToDb(string value) =>
            string.IsNullOrWhiteSpace(value)
                ? (object)DBNull.Value
                : value;

        private static bool IsValidEmail(string email)
        {
            try
            {
                return new MailAddress(email).Address == email;
            }
            catch (FormatException)
            {
                return false;
            }
        }

        protected bool ShowStatus =>
            Convert.ToString(ViewState["UserType"]) == "Pending";

        protected string GetStatusText(object approved)
        {
            if (approved == null || approved == DBNull.Value)
                return "Active";

            return Convert.ToBoolean(approved) ? "Approved" : "Pending";
        }

        protected string GetRowClass(object userID) =>
            Convert.ToString(userID) == Convert.ToString(SelectedUserId)
                ? "selected-row" : "";

        protected string GetText(object value) =>
            string.IsNullOrWhiteSpace(Convert.ToString(value))
                ? "—" : Convert.ToString(value);

        protected string GetDate(object value) =>
            value == null || value == DBNull.Value
                ? "—"
                : Convert.ToDateTime(value).ToString("dd MMM yyyy");
    }
}
