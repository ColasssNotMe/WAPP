
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class AdminClassroomManagement : Page
    {
        string connString =
            ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserID"] == null)
            //{
            //    Response.Redirect("Login.aspx");
            //}

            if (!IsPostBack)
            {
                ViewState["SelectedTab"] = "Classrooms";

                LoadClassroomData();
                //LoadLiveSessionData();
            }

            ShowSelectedTab();
        }

        // Switch to Classrooms
        protected void btnClassrooms_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "Classrooms";

            LoadClassroomData();
            ShowSelectedTab();
        }

        // Switch to Live Sessions
        protected void btnLiveSessions_Click(object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "LiveSessions";

            //LoadLiveSessionData();
            ShowSelectedTab();
        }

        // Display the selected section
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

        // Load classrooms from database
        private void LoadClassroomData()
        {
            string query = @"
                SELECT
                    c.classID AS ClassID,
                    c.className AS ClassName,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unassigned') AS TeacherName,
                    COUNT(e.studentID) AS StudentCount,
                    c.status AS Status
                FROM [Class] c
                LEFT JOIN [User] u
                    ON u.userID = c.teacherID
                LEFT JOIN Enrolment e
                    ON e.classID = c.classID
                WHERE
                    (c.className LIKE @Search
                    OR u.firstName LIKE @Search
                    OR u.lastName LIKE @Search
                    OR CONCAT(u.firstName, ' ', u.lastName) LIKE @Search)
                    AND (@Status = '' OR c.status = @Status)
                GROUP BY
                    c.classID,
                    c.className,
                    u.firstName,
                    u.lastName,
                    c.status
                ORDER BY c.className";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@Search", "%" + txtClassroomSearch.Text.Trim() + "%");

                cmd.Parameters.AddWithValue(
                    "@Status", ddlClassroomStatus.SelectedValue);

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            rptClassrooms.DataSource = dt;
            rptClassrooms.DataBind();

            int total = dt.Rows.Count;
            int active = 0;
            int inactive = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (string.Equals(
                    row["Status"].ToString(),
                    "Active",
                    StringComparison.OrdinalIgnoreCase))
                {
                    active++;
                }
                else if (string.Equals(
                    row["Status"].ToString(),
                    "Inactive",
                    StringComparison.OrdinalIgnoreCase))
                {
                    inactive++;
                }
            }

            totalClassrooms.InnerText = total + " classrooms";

            classroomMeta.InnerText =
                total + " classrooms · " +
                active + " active · " +
                inactive + " inactive";

            lblClassroomCount.Text =
                "Showing " + total + " classrooms";
        }

        // Load live sessions from database
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
                    (ls.SessionTitle LIKE @Search
                    OR c.className LIKE @Search
                    OR u.firstName LIKE @Search
                    OR u.lastName LIKE @Search
                    OR CONCAT(u.firstName, ' ', u.lastName) LIKE @Search)
                    AND (@Status = '' OR ls.Status = @Status)
                ORDER BY ls.StartTime DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@Search", "%" + txtSessionSearch.Text.Trim() + "%");

                cmd.Parameters.AddWithValue(
                    "@Status", ddlSessionStatus.SelectedValue);

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            rptSessions.DataSource = dt;
            rptSessions.DataBind();

            lblSessionCount.Text =
                "Showing " + dt.Rows.Count + " sessions";
        }

        // Classroom search
        protected void txtClassroomSearch_TextChanged(
            object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "Classrooms";
            LoadClassroomData();
            ShowSelectedTab();
        }

        // Classroom status filter
        protected void ddlClassroomStatus_SelectedIndexChanged(
            object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "Classrooms";
            LoadClassroomData();
            ShowSelectedTab();
        }

        // Live-session search
        protected void txtSessionSearch_TextChanged(
            object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "LiveSessions";
            //LoadLiveSessionData();
            ShowSelectedTab();
        }

        // Live-session status filter
        protected void ddlSessionStatus_SelectedIndexChanged(
            object sender, EventArgs e)
        {
            ViewState["SelectedTab"] = "LiveSessions";
            //LoadLiveSessionData();
            ShowSelectedTab();
        }

        // Refresh current data
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadClassroomData();
            //LoadLiveSessionData();
            ShowSelectedTab();
        }
    }
}
