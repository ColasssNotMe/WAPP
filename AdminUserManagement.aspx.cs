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
            get { return ViewState["SelectedUserID"] as int?; }
            set { ViewState["SelectedUserID"] = value; }
        }

        private bool IsEditMode
        {
            get { return Convert.ToBoolean(ViewState["EditMode"]); }
        }

        private bool IsAddMode
        {
            get { return Convert.ToBoolean(ViewState["AddMode"]); }
        }

        private string CurrentTab
        {
            get
            {
                string t = Convert.ToString(ViewState["UserType"]);
                return t == "" ? "All" : t;
            }
        }

        // Used by the .aspx (the "Account Status" column)
        protected bool ShowStatus
        {
            get { return CurrentTab == "Pending"; }
        }

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

        protected void btnAllUsers_Click(object sender, EventArgs e) { ChangeTab("All"); }
        protected void btnStudents_Click(object sender, EventArgs e) { ChangeTab("Student"); }
        protected void btnTeachers_Click(object sender, EventArgs e) { ChangeTab("Teacher"); }
        protected void btnPendingTeachers_Click(object sender, EventArgs e) { ChangeTab("Pending"); }

        private void ChangeTab(string type)
        {
            ViewState["UserType"] = type;
            ViewState["EditMode"] = false;
            ViewState["AddMode"] = false;
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

        protected void UserRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "SelectUser")
                return;

            SelectedUserId = Convert.ToInt32(e.CommandArgument);
            ViewState["EditMode"] = false;
            ViewState["AddMode"] = false;
            loadUsers();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            ViewState["AddMode"] = true;
            ViewState["EditMode"] = false;
            loadUsers();
        }

        protected void btnCancelAdd_Click(object sender, EventArgs e)
        {
            ClearAddForm();
            ViewState["AddMode"] = false;
            loadUsers();
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            string firstName = txtNewFirstName.Text.Trim();
            string lastName = txtNewLastName.Text.Trim();
            string username = txtNewUsername.Text.Trim();
            string email = txtNewEmail.Text.Trim();
            string password = txtNewPassword.Text;
            string role = ddlNewRole.SelectedValue;

            if (firstName == "" || lastName == "" || username == "" ||
                email == "" || password == "")
            {
                ShowMessage("Please fill in all fields.", false);
                return;
            }

            if (!IsValidEmail(email))
            {
                ShowMessage("Please enter a valid email address.", false);
                return;
            }

            int newUserId;

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM [User] WHERE username = @username OR email = @email", conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);

                        if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                        {
                            ShowMessage("That username or email is already in use.", false);
                            return;
                        }
                    }

                    using (SqlTransaction tx = conn.BeginTransaction())
                    {
                        try
                        {
                            using (SqlCommand cmd = new SqlCommand(
                                "INSERT INTO [User] (firstName, lastName, username, email, password, [role], dateRegistered) " +
                                "VALUES (@firstName, @lastName, @username, @email, @passwordHash, @role, GETDATE()); " +
                                "SELECT CAST(SCOPE_IDENTITY() AS int);", conn, tx))
                            {
                                cmd.Parameters.AddWithValue("@firstName", firstName);
                                cmd.Parameters.AddWithValue("@lastName", lastName);
                                cmd.Parameters.AddWithValue("@username", username);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@passwordHash", new PasswordManager().HashPassword(password));
                                cmd.Parameters.AddWithValue("@role", role);

                                newUserId = Convert.ToInt32(cmd.ExecuteScalar());
                            }

                            if (role == "Student")
                            {
                                using (SqlCommand cmd = new SqlCommand(
                                    "INSERT INTO Student (userID) VALUES (@userID)", conn, tx))
                                {
                                    cmd.Parameters.AddWithValue("@userID", newUserId);
                                    cmd.ExecuteNonQuery();
                                }
                            }
                            else if (role == "Teacher")
                            {
                                // Created by an admin, so approved straight away
                                using (SqlCommand cmd = new SqlCommand(
                                    "INSERT INTO Teacher (userID, approved) VALUES (@userID, 'true')", conn, tx))
                                {
                                    cmd.Parameters.AddWithValue("@userID", newUserId);
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
            }
            catch (SqlException ex)
            {
                // TEMPORARY: shows the real database error. Remove ex.Message when it works.
                ShowMessage("Could not create the account: " + ex.Message, false);
                return;
            }

            // Show the new user: go to the All Users tab and select them
            ClearAddForm();
            ViewState["AddMode"] = false;
            ViewState["EditMode"] = false;
            ViewState["UserType"] = "All";
            txtSearch.Text = "";
            SelectedUserId = newUserId;

            loadUsers();
            ShowMessage("User '" + username + "' has been created.", true);
        }

        private void ClearAddForm()
        {
            txtNewFirstName.Text = "";
            txtNewLastName.Text = "";
            txtNewUsername.Text = "";
            txtNewEmail.Text = "";
            txtNewPassword.Text = "";
            ddlNewRole.SelectedIndex = 0;
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ViewState["EditMode"] = true;
            ViewState["FillEdit"] = true;   // fill the textboxes once
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

            if (firstName == "" || lastName == "" || username == "" || email == "")
            {
                ShowMessage("First name, last name, username and email are required.", false);
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

                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT COUNT(*) FROM [User] " +
                        "WHERE (username = @username OR email = @email) AND userID <> @userID", conn))
                    {
                        cmd.Parameters.AddWithValue("@username", username);
                        cmd.Parameters.AddWithValue("@email", email);
                        cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);

                        if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                        {
                            ShowMessage("That username or email is already in use.", false);
                            return;
                        }
                    }

                    string role;
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT [role] FROM [User] WHERE userID = @userID", conn))
                    {
                        cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);
                        role = Convert.ToString(cmd.ExecuteScalar());
                    }

                    using (SqlTransaction tx = conn.BeginTransaction())
                    {
                        try
                        {
                            using (SqlCommand cmd = new SqlCommand(
                                "UPDATE [User] SET firstName = @firstName, lastName = @lastName, " +
                                "username = @username, email = @email WHERE userID = @userID",
                                conn, tx))
                            {
                                cmd.Parameters.AddWithValue("@firstName", firstName);
                                cmd.Parameters.AddWithValue("@lastName", lastName);
                                cmd.Parameters.AddWithValue("@username", username);
                                cmd.Parameters.AddWithValue("@email", email);
                                cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);
                                cmd.ExecuteNonQuery();
                            }

                            if (role == "Student")
                            {
                                using (SqlCommand cmd = new SqlCommand(
                                    "UPDATE Student SET school = @school, gradeLevel = @grade " +
                                    "WHERE userID = @userID", conn, tx))
                                {
                                    cmd.Parameters.AddWithValue("@school", ToDb(school));
                                    cmd.Parameters.AddWithValue("@grade", ToDb(grade));
                                    cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);
                                    cmd.ExecuteNonQuery();
                                }
                            }
                            else if (role == "Teacher")
                            {
                                using (SqlCommand cmd = new SqlCommand(
                                    "UPDATE Teacher SET school = @school WHERE userID = @userID",
                                    conn, tx))
                                {
                                    cmd.Parameters.AddWithValue("@school", ToDb(school));
                                    cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);
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
                ShowMessage("Could not update the account. Please check the values and try again.", false);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (SelectedUserId == null)
                return;

            if (Convert.ToString(Session["UserID"]) == SelectedUserId.Value.ToString())
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
                            using (SqlCommand cmd = new SqlCommand(query, conn, tx))
                            {
                                cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);
                                cmd.ExecuteNonQuery();
                            }
                        }

                        tx.Commit();
                    }
                    catch (SqlException)
                    {
                        tx.Rollback();
                        ShowMessage("This account cannot be deleted because other records depend on it.", false);
                        return;
                    }
                }
            }

            SelectedUserId = null;
            ViewState["EditMode"] = false;
            loadUsers();
            ShowMessage(name + "'s account has been deleted.", true);
        }

        // approved is stored as the TEXT "true" or "false" (VARCHAR column)

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            UpdateTeacherApproval("true", "has been approved.");
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            UpdateTeacherApproval("false", "has been rejected.");
        }

        private void UpdateTeacherApproval(string approvedValue, string message)
        {
            if (SelectedUserId == null)
                return;

            string name = lblDetName.Text;

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE Teacher SET approved = @approved WHERE userID = @userID", conn))
            {
                cmd.Parameters.AddWithValue("@approved", approvedValue);
                cmd.Parameters.AddWithValue("@userID", SelectedUserId.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            ViewState["EditMode"] = false;
            loadUsers();
            ShowMessage(name + " " + message, true);
        }

        private void loadUsers()
        {
            string type = CurrentTab;
            string search = txtSearch.Text.Trim();

            string sql =
                "SELECT U.userID, U.firstName, U.lastName, U.username, U.email, " +
                "U.[role], T.approved " +
                "FROM [User] U LEFT JOIN Teacher T ON U.userID = T.userID";

            string where = "";

            if (type == "Student")
                where = " WHERE U.[role] = 'Student'";
            else if (type == "Teacher")
                where = " WHERE U.[role] = 'Teacher' AND T.approved = 'true'";
            else if (type == "Pending")
                where = " WHERE U.[role] = 'Teacher' AND T.approved = 'false'";

            if (search != "")
            {
                where += (where == "" ? " WHERE " : " AND ");
                where += "(U.firstName + ' ' + U.lastName LIKE @search " +
                         "OR U.username LIKE @search OR U.email LIKE @search)";
            }

            sql += where + " ORDER BY U.firstName, U.lastName";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                if (search != "")
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            EnsureRowSelected(dt);

            thStatus.Visible = (type == "Pending");
            UserRepeater.DataSource = dt;
            UserRepeater.DataBind();

            lblSectionCount.Text = dt.Rows.Count.ToString();
            lblShowing.Text = dt.Rows.Count.ToString();
            lblTotal.Text = dt.Rows.Count.ToString();
            emptyMessage.Visible = (dt.Rows.Count == 0);

            btnAllUsers.CssClass = type == "All" ? "tab active" : "tab";
            btnStudents.CssClass = type == "Student" ? "tab active" : "tab";
            btnTeachers.CssClass = type == "Teacher" ? "tab active" : "tab";
            btnPendingTeachers.CssClass = type == "Pending" ? "tab active" : "tab";

            lblSectionTitle.Text =
                type == "Student" ? "Students" :
                type == "Teacher" ? "Teachers" :
                type == "Pending" ? "Pending Teachers" : "All Users";

            loadCounts();
            loadDetails();
        }

        // Make sure one row is always selected (or none if list is empty)
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

        private void loadCounts()
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM [User]", conn))
                {
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Teacher WHERE approved = 'false'", conn))
                {
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    lblPendingCount.Text = count.ToString();
                    pendingNotice.Visible = count > 0;
                }
            }
        }

        private void loadDetails()
        {
            pnlMessage.Visible = false;

            pnlAdd.Visible = IsAddMode;
            if (IsAddMode)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = false;
                return;
            }

            if (SelectedUserId == null)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            string sql =
                "SELECT U.firstName, U.lastName, U.username, U.email, U.[role], " +
                "U.dateRegistered, S.school AS studentSchool, S.gradeLevel, " +
                "T.school AS teacherSchool, T.approved " +
                "FROM [User] U " +
                "LEFT JOIN Student S ON U.userID = S.userID " +
                "LEFT JOIN Teacher T ON U.userID = T.userID " +
                "WHERE U.userID = @userID";

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
            bool pendingTab = (CurrentTab == "Pending");

            lblDetName.Text = row["firstName"] + " " + row["lastName"];
            lblDetUsername.Text = GetText(row["username"]);
            lblDetEmail.Text = GetText(row["email"]);
            lblDetRole.Text = role;
            lblDetJoined.Text = GetDate(row["dateRegistered"]);
            lblDetApproval.Text = GetStatusText(row["approved"]);

            string school = "";
            if (role == "Student")
                school = Convert.ToString(row["studentSchool"]);
            else if (role == "Teacher")
                school = Convert.ToString(row["teacherSchool"]);

            lblDetSchool.Text = GetText(school);
            lblDetGrade.Text = GetText(row["gradeLevel"]);

            dtGrade.Visible = ddGrade.Visible = (role == "Student");
            fieldGrade.Visible = (role == "Student");
            fieldSchool.Visible = (role == "Student" || role == "Teacher");
            dtApproval.Visible = ddApproval.Visible = pendingTab;

            pnlView.Visible = !editMode;
            pnlEdit.Visible = editMode;
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

        private void ShowMessage(string message, bool success)
        {
            lblMessage.Text = Server.HtmlEncode(message);
            pnlMessage.CssClass = success ? "message message--success" : "message message--error";
            pnlMessage.Visible = true;
        }

        private static object ToDb(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return DBNull.Value;
            return value;
        }

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

        // Reads the text "true"/"false" safely (never crashes)
        protected string GetStatusText(object approved)
        {
            if (approved == null || approved == DBNull.Value)
                return "Active";   // students / admins have no approval

            bool isApproved;
            bool.TryParse(Convert.ToString(approved), out isApproved);

            return isApproved ? "Approved" : "Pending";
        }

        protected string GetRowClass(object userID)
        {
            return Convert.ToString(userID) == Convert.ToString(SelectedUserId)
                ? "selected-row" : "";
        }

        protected string GetText(object value)
        {
            string s = Convert.ToString(value);
            return string.IsNullOrWhiteSpace(s) ? "—" : s;
        }

        protected string GetDate(object value)
        {
            if (value == null || value == DBNull.Value)
                return "—";
            return Convert.ToDateTime(value).ToString("dd MMM yyyy");
        }
    }
}