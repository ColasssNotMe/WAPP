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

            if (Session["userid"] ==null)
            {
                Response.Redirect("Login.aspx");
            }

            lblMessage.Visible = false;

            if (!IsPostBack)
            {
                LoadTeachers();
                LoadClassroomList();

                if (!string.IsNullOrEmpty(hfSelectedClassID.Value))
                {
                    LoadClassroomDetails(Convert.ToInt32(hfSelectedClassID.Value));
                }
                else
                {
                    pnlDetails.Visible = false;
                    pnlNoSelection.Visible = true;
                }
            }
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(connString);
        }

        private void ShowMessage(string text, bool isError)
        {
            lblMessage.Visible = true;
            lblMessage.Text = text;
            lblMessage.Style["color"] = isError ? "#c9302c" : "#2e7d32";
        }

        private void ExecNonQuery(string sql, SqlConnection conn, SqlTransaction tx, int id)
        {
            using (SqlCommand cmd = new SqlCommand(sql, conn, tx))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                cmd.ExecuteNonQuery();
            }
        }

        private void LoadClassroomList()
        {
            string sql = @"
                SELECT
                    c.classID AS ClassID,
                    c.className AS ClassName,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unassigned') AS TeacherName,
                    (SELECT COUNT(*) FROM Enrolment WHERE classID = c.classID) AS StudentCount,
                    (SELECT COUNT(*) FROM Quiz      WHERE classID = c.classID) AS QuizCount
                FROM [Class] c
                LEFT JOIN Teacher t ON t.teacherID = c.teacherID
                LEFT JOIN [User] u ON u.userID = t.userID
                WHERE (@Search = ''
                       OR c.className LIKE @Search
                       OR u.firstName LIKE @Search
                       OR u.lastName  LIKE @Search
                       OR CONCAT(u.firstName, ' ', u.lastName) LIKE @Search)
                ORDER BY c.className";

            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                string term = txtClassroomSearch.Text.Trim();
                cmd.Parameters.AddWithValue("@Search", term == "" ? "" : "%" + term + "%");
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            rptClassrooms.DataSource = dt;
            rptClassrooms.DataBind();

            int total = dt.Rows.Count;
            totalClassrooms.InnerText = total + " classrooms";
            classroomMeta.InnerText = total + " classrooms total in directory";
            lblClassroomCount.Text = "Showing " + total + " classrooms";

            if (total == 0)
            {
                hfSelectedClassID.Value = "";
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
            }
        }

        private void LoadTeachers()
        {
            string sql = @"
                SELECT t.teacherID AS TeacherID,
                       u.firstName + ' ' + u.lastName AS FullName
                FROM Teacher t
                INNER JOIN [User] u ON u.userID = t.userID
                ORDER BY u.firstName";

            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                da.Fill(dt);

            ddlTeacher.DataSource = dt;
            ddlTeacher.DataTextField = "FullName";
            ddlTeacher.DataValueField = "TeacherID";
            ddlTeacher.DataBind();
            ddlTeacher.Items.Insert(0, new ListItem("-- Unassigned --", ""));
        }

        private void LoadClassroomDetails(int classID)
        {
            string sql = @"
                SELECT
                    c.classID,
                    c.className,
                    c.teacherID,
                    ISNULL(c.subject,   '') AS Subject,
                    ISNULL(c.description,'') AS Description,
                    ISNULL(c.inviteCode,'') AS InviteCode
                FROM [Class] c
                WHERE c.classID = @ClassID";

            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@ClassID", classID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            if (dt.Rows.Count == 0)
            {
                hfSelectedClassID.Value = "";
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            DataRow row = dt.Rows[0];

            txtClassName.Text = row["className"].ToString();
            txtSchool.Text = row["Description"].ToString();
            txtSubject.Text = row["Subject"].ToString();
            txtInviteCode.Text = row["InviteCode"].ToString();

            string teacherID = row["teacherID"] == DBNull.Value ? "" : row["teacherID"].ToString();
            if (ddlTeacher.Items.FindByValue(teacherID) != null)
                ddlTeacher.SelectedValue = teacherID;
            else
                ddlTeacher.SelectedIndex = 0;

            LoadStudents(classID);
            LoadQuizzes(classID);

            pnlDetails.Visible = true;
            pnlNoSelection.Visible = false;
        }

        private void LoadStudents(int classID)
        {
            string sql = @"
                SELECT
                    e.studentID AS StudentID,
                    ISNULL(u.firstName + ' ' + u.lastName, 'Unknown') AS StudentName
                FROM Enrolment e
                INNER JOIN Student s ON s.studentID = e.studentID
                INNER JOIN [User] u ON u.userID = s.userID
                WHERE e.classID = @ClassID
                ORDER BY u.firstName";

            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@ClassID", classID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            rptStudents.DataSource = dt;
            rptStudents.DataBind();
            lblTotalStudents.Text = dt.Rows.Count.ToString();
        }

        private void LoadQuizzes(int classID)
        {
            string sql = @"
                SELECT
                    q.quizID    AS QuizID,
                    ISNULL(q.title, 'Untitled') AS QuizTitle
                FROM Quiz q
                WHERE q.classID = @ClassID
                ORDER BY q.title";

            DataTable dt = new DataTable();
            using (SqlConnection conn = GetConnection())
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@ClassID", classID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            rptQuizzes.DataSource = dt;
            rptQuizzes.DataBind();
            lblTotalQuizzes.Text = dt.Rows.Count.ToString();
        }

        protected void btnClassroomSearch_Click(object sender, EventArgs e)
        {
            LoadClassroomList();
        }

        protected void btnClassroomReset_Click(object sender, EventArgs e)
        {
            txtClassroomSearch.Text = "";
            LoadClassroomList();
        }

        // THIS IS THE btnOpen LOGIC
        protected void rptClassrooms_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectClass")
            {
                int classID = Convert.ToInt32(e.CommandArgument);
                hfSelectedClassID.Value = classID.ToString();
                LoadClassroomList();
                LoadClassroomDetails(classID);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSelectedClassID.Value)) return;
            int classID = Convert.ToInt32(hfSelectedClassID.Value);

            string sql = @"
                UPDATE [Class]
                SET className  = @Name,
                    teacherID  = @Teacher,
                    description= @Description,
                    subject    = @Subject,
                    inviteCode = @Invite
                WHERE classID = @ClassID";

            try
            {
                using (SqlConnection conn = GetConnection())
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", txtClassName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Teacher",
                        ddlTeacher.SelectedValue == "" ? (object)DBNull.Value : ddlTeacher.SelectedValue);
                    cmd.Parameters.AddWithValue("@Description", txtSchool.Text.Trim());
                    cmd.Parameters.AddWithValue("@Subject", txtSubject.Text.Trim());
                    cmd.Parameters.AddWithValue("@Invite", txtInviteCode.Text.Trim());
                    cmd.Parameters.AddWithValue("@ClassID", classID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadClassroomList();
                LoadClassroomDetails(classID);
                ShowMessage("Classroom saved successfully.", false);
            }
            catch (Exception ex)
            {
                ShowMessage("Save failed: " + ex.Message, true);
            }
        }

        protected void btnDeleteClassroom_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSelectedClassID.Value)) return;
            int classID = Convert.ToInt32(hfSelectedClassID.Value);
            bool deleted = false;

            using (SqlConnection conn = GetConnection())
            {
                conn.Open();
                using (SqlTransaction tx = conn.BeginTransaction())
                {
                    try
                    {
                        ExecNonQuery("DELETE FROM LiveSession WHERE classID = @ID", conn, tx, classID);
                        ExecNonQuery("DELETE FROM Quiz        WHERE classID = @ID", conn, tx, classID);
                        ExecNonQuery("DELETE FROM Enrolment   WHERE classID = @ID", conn, tx, classID);
                        ExecNonQuery("DELETE FROM [Class]     WHERE classID = @ID", conn, tx, classID);
                        tx.Commit();
                        deleted = true;
                    }
                    catch (Exception ex)
                    {
                        tx.Rollback();
                        ShowMessage("Delete failed: " + ex.Message, true);
                    }
                }
            }

            if (deleted)
            {
                hfSelectedClassID.Value = "";
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                LoadClassroomList();
            }
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "RemoveStudent") return;

            int studentID = Convert.ToInt32(e.CommandArgument);
            int classID = Convert.ToInt32(hfSelectedClassID.Value);

            try
            {
                using (SqlConnection conn = GetConnection())
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Enrolment WHERE studentID = @StudentID AND classID = @ClassID", conn))
                {
                    cmd.Parameters.AddWithValue("@StudentID", studentID);
                    cmd.Parameters.AddWithValue("@ClassID", classID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                LoadClassroomList();
                LoadClassroomDetails(classID);
                ShowMessage("Student removed.", false);
            }
            catch (Exception ex)
            {
                ShowMessage("Could not remove student: " + ex.Message, true);
            }
        }
    }
}