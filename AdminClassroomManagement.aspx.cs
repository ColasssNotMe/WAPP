using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminClassroomManagement : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // if (Session["UserID"] == null)
            // {
            //     Response.Redirect("Login.aspx");
            // }

            if (!IsPostBack)
            {
                ViewState["SelectedTab"] = "Classrooms";

                LoadClassroomData();
                LoadLiveSessionData();
                ShowSelectedTab();
            }
        }

        #region Tab Navigation

        protected void btnClassrooms_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "Classrooms";
            ShowSelectedTab();
        }

        protected void btnLiveSessions_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "LiveSessions";
            ShowSelectedTab();
        }

        private void ShowSelectedTab()
        {
            string selectedTab = Convert.ToString(ViewState["SelectedTab"]);

            if (selectedTab == "LiveSessions")
            {
                pnlClassrooms.Visible = false;
                pnlLiveSessions.Visible = true;

                btnClassrooms.CssClass = "tab";
                btnLiveSessions.CssClass = "tab active";
            }
            else
            {
                pnlClassrooms.Visible = true;
                pnlLiveSessions.Visible = false;

                btnClassrooms.CssClass = "tab active";
                btnLiveSessions.CssClass = "tab";
            }
        }

        #endregion

        #region Data Loading & Search Methods

        private void LoadClassroomData()
        {
            string query = @"
                SELECT
                    c.classID AS ClassID,
                    c.className AS ClassName,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unassigned') AS TeacherName,
                    COUNT(DISTINCT e.studentID) AS StudentCount,
                    COUNT(DISTINCT q.quizID) AS QuizCount,
                    c.status AS Status,
                    ISNULL(c.schoolName, 'N/A') AS SchoolName,
                    ISNULL(c.subject, 'N/A') AS Subject,
                    ISNULL(c.inviteCode, 'N/A') AS InviteCode
                FROM [Class] c
                LEFT JOIN [User] u
                    ON u.userID = c.teacherID
                LEFT JOIN Enrolment e
                    ON e.classID = c.classID
                LEFT JOIN Quiz q
                    ON q.classID = c.classID
                WHERE
                    (@Search = ''
                     OR c.className LIKE @Search
                     OR u.firstName LIKE @Search
                     OR u.lastName LIKE @Search
                     OR CONCAT(u.firstName, ' ', u.lastName) LIKE @Search)
                GROUP BY
                    c.classID,
                    c.className,
                    u.firstName,
                    u.lastName,
                    c.status,
                    c.schoolName,
                    c.subject,
                    c.inviteCode
                ORDER BY c.className";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                string searchTerm = txtClassroomSearch.Text.Trim();
                cmd.Parameters.AddWithValue("@Search", string.IsNullOrEmpty(searchTerm) ? "" : "%" + searchTerm + "%");

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            rptClassrooms.DataSource = dt;
            rptClassrooms.DataBind();

            int total = dt.Rows.Count;
            totalClassrooms.InnerText = total + " classrooms";
            classroomMeta.InnerText = total + " classrooms total in directory";
            lblClassroomCount.Text = "Showing " + total + " classrooms";

            // If selected classroom is still in list, keep it loaded; otherwise load first item if available
            if (dt.Rows.Count > 0 && string.IsNullOrEmpty(hfSelectedClassID.Value))
            {
                SelectClassroom(Convert.ToInt32(dt.Rows[0]["ClassID"]));
            }
            else if (dt.Rows.Count == 0)
            {
                ClearDetailsPanel();
            }
        }

        private void LoadLiveSessionData()
        {
            string query = @"
                SELECT
                    ls.SessionID AS SessionID,
                    ls.SessionTitle AS SessionTitle,
                    c.className AS ClassName,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unassigned') AS TeacherName,
                    ls.StartTime AS StartTime,
                    ls.Status AS Status
                FROM LiveSession ls
                INNER JOIN [Class] c
                    ON c.classID = ls.ClassID
                LEFT JOIN [User] u
                    ON u.userID = c.teacherID
                WHERE
                    (@Search = ''
                     OR ls.SessionTitle LIKE @Search
                     OR c.className LIKE @Search
                     OR u.firstName LIKE @Search
                     OR u.lastName LIKE @Search
                     OR CONCAT(u.firstName, ' ', u.lastName) LIKE @Search)
                ORDER BY ls.StartTime DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                string searchTerm = txtSessionSearch.Text.Trim();
                cmd.Parameters.AddWithValue("@Search", string.IsNullOrEmpty(searchTerm) ? "" : "%" + searchTerm + "%");

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            rptSessions.DataSource = dt;
            rptSessions.DataBind();

            lblSessionCount.Text = "Showing " + dt.Rows.Count + " sessions";
        }

        #endregion

        #region Search & Reset Buttons

        protected void btnClassroomSearch_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "Classrooms";
            LoadClassroomData();
            ShowSelectedTab();
        }

        protected void btnClassroomReset_Click(object sender, EventArgs e)
        {
            txtClassroomSearch.Text = string.Empty;
            ViewState["SelectedTab"] = "Classrooms";
            LoadClassroomData();
            ShowSelectedTab();
        }

        protected void btnSessionSearch_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "LiveSessions";
            LoadLiveSessionData();
            ShowSelectedTab();
        }

        protected void btnSessionReset_Click(object sender, EventArgs e)
        {
            txtSessionSearch.Text = string.Empty;
            ViewState["SelectedTab"] = "LiveSessions";
            LoadLiveSessionData();
            ShowSelectedTab();
        }

        #endregion

        #region Row Selection & Detail Operations

        protected void rptClassrooms_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectClass")
            {
                int classID = Convert.ToInt32(e.CommandArgument);
                SelectClassroom(classID);
            }
        }

        private void SelectClassroom(int classID)
        {
            hfSelectedClassID.Value = classID.ToString();

            string query = @"
                SELECT
                    c.classID,
                    c.className,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unassigned') AS TeacherName,
                    ISNULL(c.schoolName, 'N/A') AS SchoolName,
                    ISNULL(c.subject, 'N/A') AS Subject,
                    ISNULL(c.inviteCode, 'N/A') AS InviteCode,
                    ISNULL(c.status, 'Active') AS Status,
                    (SELECT COUNT(*) FROM Enrolment WHERE classID = c.classID) AS StudentCount
                FROM [Class] c
                LEFT JOIN [User] u ON u.userID = c.teacherID
                WHERE c.classID = @ClassID";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@ClassID", classID);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblDetailClassName.Text = reader["className"].ToString();
                        lblDetailTeacher.Text = reader["TeacherName"].ToString();
                        lblDetailSchool.Text = reader["SchoolName"].ToString();
                        lblDetailSubject.Text = reader["Subject"].ToString();
                        lblDetailStudents.Text = reader["StudentCount"].ToString();
                        lblDetailInviteCode.Text = reader["InviteCode"].ToString();
                        lblDetailStatus.Text = reader["Status"].ToString();

                        btnViewDetails.Enabled = true;
                        btnDeleteClassroom.Enabled = true;
                        lblNote.Text = "Viewing dynamic data for classroom ID: " + classID;
                    }
                }
            }
        }

        private void ClearDetailsPanel()
        {
            hfSelectedClassID.Value = string.Empty;
            lblDetailClassName.Text = "-";
            lblDetailTeacher.Text = "-";
            lblDetailSchool.Text = "-";
            lblDetailSubject.Text = "-";
            lblDetailStudents.Text = "0";
            lblDetailInviteCode.Text = "-";
            lblDetailStatus.Text = "-";

            btnViewDetails.Enabled = false;
            btnDeleteClassroom.Enabled = false;
            lblNote.Text = "Select a classroom from the table to view its details.";
        }

        protected void btnViewDetails_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(hfSelectedClassID.Value))
            {
                Response.Redirect("AdminClassroomDetails.aspx?classID=" + hfSelectedClassID.Value);
            }
        }

        protected void btnDeleteClassroom_Click(object sender, EventArgs e)
        {
            if (int.TryParse(hfSelectedClassID.Value, out int classID))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        // Delete child enrolments first to maintain foreign key integrity
                        string deleteEnrolments = "DELETE FROM Enrolment WHERE classID = @ClassID";
                        using (SqlCommand cmd1 = new SqlCommand(deleteEnrolments, conn, transaction))
                        {
                            cmd1.Parameters.AddWithValue("@ClassID", classID);
                            cmd1.ExecuteNonQuery();
                        }

                        string deleteClass = "DELETE FROM [Class] WHERE classID = @ClassID";
                        using (SqlCommand cmd2 = new SqlCommand(deleteClass, conn, transaction))
                        {
                            cmd2.Parameters.AddWithValue("@ClassID", classID);
                            cmd2.ExecuteNonQuery();
                        }

                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        transaction.Rollback();
                        throw;
                    }
                }

                hfSelectedClassID.Value = string.Empty;
                LoadClassroomData();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadClassroomData();
            LoadLiveSessionData();
            ShowSelectedTab();
        }

        #endregion
    }
}