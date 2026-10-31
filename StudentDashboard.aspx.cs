using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userID = GetLoggedInUserID();

            if (userID == null)
            {
                Response.Redirect("Login.aspx");
            }

            string username = "";

            if (Session["username"] != null)
            {
                username = Session["username"].ToString();
            }

            welcomeTitle.InnerText = "Welcome, " + username + "!";

            LoadLearningMaterials(userID);
            LoadRecentQuizzes(userID);
            LoadQuizProgress(userID);
        }

        private string GetLoggedInUserID()
        {
            if (Session["userID"] == null)
            {
                return null;
            }

            return Session["userID"].ToString();
        }

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["WAPP"]
                .ConnectionString;
        }

        private int GetStudentID(SqlConnection conn, string userID)
        {
            string query = @"
                SELECT studentID
                FROM Student
                WHERE userID = @userID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    return 0;
                }

                return Convert.ToInt32(result);
            }
        }

        private void LoadLearningMaterials(string userID)
        {
            string query = @"
                SELECT TOP 3
                    m.materialID,
                    m.title,
                    m.contentType,
                    m.fileURL,
                    m.durationMins,
                    m.uploadDate,
                    c.className,
                    m.status
                FROM Material m
                INNER JOIN Enrolment e
                    ON m.classID = e.classID
                INNER JOIN Class c
                    ON m.classID = c.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE s.userID = @userID
                  AND m.status = 'Published'
                ORDER BY m.uploadDate DESC";

            DataTable materials = new DataTable();

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(materials);
                    }
                }
            }

            LearningMaterialsRepeater.DataSource = materials;
            LearningMaterialsRepeater.DataBind();

            if (materials.Rows.Count == 0)
            {
                materialPlaceholder.Visible = true;
            }
            else
            {
                materialPlaceholder.Visible = false;
            }
        }

        private void LoadRecentQuizzes(string userID)
        {
            string query = @"
                SELECT TOP 3
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    c.className,
                    r.score
                FROM Quiz q
                INNER JOIN Class c
                    ON q.classID = c.classID
                INNER JOIN Enrolment e
                    ON q.classID = e.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                LEFT JOIN Result r
                    ON r.quizID = q.quizID
                    AND r.studentID = s.studentID
                WHERE s.userID = @userID
                ORDER BY q.createdDate DESC";

            DataTable quizzes = new DataTable();

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(quizzes);
                    }
                }
            }

            RecentQuizRepeater.DataSource = quizzes;
            RecentQuizRepeater.DataBind();

            if (quizzes.Rows.Count == 0)
            {
                quizPlaceholder.Visible = true;
            }
            else
            {
                quizPlaceholder.Visible = false;
            }
        }

        protected bool HasAttempt(object dataItem)
        {
            DataRowView row = dataItem as DataRowView;

            if (row == null)
            {
                return false;
            }

            if (row["score"] == DBNull.Value)
            {
                return false;
            }

            return true;
        }

        protected string GetScoreDisplay(object dataItem)
        {
            DataRowView row = dataItem as DataRowView;

            if (row == null)
            {
                return "";
            }

            if (row["score"] == DBNull.Value)
            {
                return "";
            }

            decimal score = Convert.ToDecimal(row["score"]);
            decimal totalMarks = Convert.ToDecimal(row["totalMarks"]);

            return "Score: " + score + " / " + totalMarks;
        }

        protected void JoinClassroom_Click(object sender, EventArgs e)
        {
            string userID = GetLoggedInUserID();

            if (userID == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            errInfo.Visible = false;
            errInfo.InnerText = "";

            string classCode = classroomCodeInput.Value.Trim();

            if (classCode == "")
            {
                errInfo.InnerText = "Please enter a class code.";
                errInfo.Visible = true;
                return;
            }

            string connectionString = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                int classID = FindClassID(conn, classCode);

                if (classID == 0)
                {
                    errInfo.InnerText = "Invalid class code.";
                    errInfo.Visible = true;
                    return;
                }

                bool alreadyJoined = IsAlreadyEnrolled(conn, userID, classID);

                if (alreadyJoined)
                {
                    errInfo.InnerText = "You have already joined this class.";
                    errInfo.Visible = true;
                    return;
                }

                EnrolStudent(conn, userID, classID);
            }

            Response.Redirect("StudentDashboard.aspx");
        }

        private int FindClassID(SqlConnection conn, string classCode)
        {
            string query = @"
                SELECT classID
                FROM Class
                WHERE inviteCode = @inviteCode";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@inviteCode", classCode);

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    return 0;
                }

                return Convert.ToInt32(result);
            }
        }

        private bool IsAlreadyEnrolled(SqlConnection conn, string userID, int classID)
        {
            string query = @"
                SELECT COUNT(*)
                FROM Enrolment e
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE s.userID = @userID
                  AND e.classID = @classID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);
                cmd.Parameters.AddWithValue("@classID", classID);

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count > 0)
                {
                    return true;
                }

                return false;
            }
        }

        private void EnrolStudent(SqlConnection conn, string userID, int classID)
        {
            string query = @"
                INSERT INTO Enrolment (studentID, classID, enrollDate)
                SELECT s.studentID, @classID, GETDATE()
                FROM Student s
                WHERE s.userID = @userID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);
                cmd.Parameters.AddWithValue("@classID", classID);

                cmd.ExecuteNonQuery();
            }
        }

        private void LoadQuizProgress(string userID)
        {
            string connectionString = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                int studentID = GetStudentID(conn, userID);

                if (studentID == 0)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                ProgressCalculator.Recalculate(studentID);

                int progressPercentage = GetProgressPercentage(conn, userID);

                progressNumber.InnerText = progressPercentage + "%";
                progressFill.Style["width"] = progressPercentage + "%";
            }
        }

        private int GetProgressPercentage(SqlConnection conn, string userID)
        {
            string query = @"
                SELECT ISNULL(progressPercentage, 0)
                FROM Student
                WHERE userID = @userID";

            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    return 0;
                }

                return Convert.ToInt32(result);
            }
        }

        protected void JoinLiveSession_Click(object sender, EventArgs e)
        {
            string userID = GetLoggedInUserID();

            if (userID == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            liveSessionError.Visible = false;
            liveSessionError.InnerText = "";

            string sessionCode = liveSessionCode.Value.Trim();

            if (sessionCode == "")
            {
                liveSessionError.InnerText = "Please enter a live session code.";
                liveSessionError.Visible = true;
                return;
            }

            string query = @"
                SELECT TOP 1
                    ls.sessionID,
                    ls.classID
                FROM LiveSession ls
                INNER JOIN Enrolment e
                    ON ls.classID = e.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE s.userID = @userID
                  AND ls.sessionID = @sessionID
                  AND GETDATE() >= ls.starttime
                  AND GETDATE() <= ls.endtime";

            string connectionString = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    cmd.Parameters.AddWithValue("@sessionID", sessionCode);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        bool hasSession = reader.Read();

                        if (hasSession == false)
                        {
                            liveSessionError.InnerText =
                                "Invalid or inactive live session code.";
                            liveSessionError.Visible = true;
                            return;
                        }

                        int sessionID = Convert.ToInt32(reader["sessionID"]);
                        int classID = Convert.ToInt32(reader["classID"]);

                        Session["sessionID"] = sessionID;
                        Session["classID"] = classID;

                        Response.Redirect("LiveSession.aspx");
                    }
                }
            }
        }

        protected void rptMaterials_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenMaterial")
            {
                int materialId;

                if (int.TryParse(e.CommandArgument.ToString(), out materialId))
                {
                    Session["materialId"] = materialId.ToString();
                    Response.Redirect("NotePage.aspx");
                }
            }
        }

        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenQuiz")
            {
                int quizId;

                if (int.TryParse(e.CommandArgument.ToString(), out quizId))
                {
                    Session["quizID"] = quizId.ToString();
                    Response.Redirect("QuizAttempt.aspx");
                }
            }
        }
    }
}
