using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            welcomeTitle.InnerText = "Welcome, " + Session["username"] + "!";
            LoadLearningMaterials();
            LoadRecentQuizzes();
            LoadQuizProgress();

        }

        private void LoadLearningMaterials()
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }

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
          AND m.status = 'Active'
        ORDER BY m.uploadDate DESC";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {

                using (
               SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        LearningMaterialsRepeater.DataSource = dt;
                        LearningMaterialsRepeater.DataBind();

                        materialPlaceholder.Visible = dt.Rows.Count == 0;
                    }

                }

            }
        }

        private void LoadRecentQuizzes()
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string query = @"
        SELECT TOP 3
            q.quizID,
            q.title,
            q.totalMarks,
            c.className
        FROM Quiz q
        INNER JOIN Class c
            ON q.classID = c.classID
        INNER JOIN Enrolment e
            ON q.classID = e.classID
        INNER JOIN Student s
            ON e.studentID = s.studentID
        WHERE s.userID = @userID
        ORDER BY q.createdDate DESC";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();

                        dt.Columns.Add("Title");
                        dt.Columns.Add("Info");

                        while (reader.Read())
                        {
                            string title = reader["title"].ToString();
                            string className = reader["className"].ToString();

                            dt.Rows.Add(
                                title,
                                className
                            );
                        }

                        RecentQuizRepeater.DataSource = dt;
                        RecentQuizRepeater.DataBind();

                        quizPlaceholder.Visible = dt.Rows.Count == 0;
                    }
                }
            }
        }


        protected void JoinClassroom_Click(object sender, EventArgs e)
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            errInfo.Visible = false;
            errInfo.InnerText = "";

            string classCode = classroomCodeInput.Value.Trim();

            if (string.IsNullOrEmpty(classCode))
            {
                errInfo.InnerText = "Please enter a class code.";
                errInfo.Visible = true;
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string classQuery = @"
            SELECT classID
            FROM Class
            WHERE inviteCode = @inviteCode";

                int classID;

                using (SqlCommand cmd = new SqlCommand(classQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@inviteCode", classCode);

                    object result = cmd.ExecuteScalar();

                    if (result == null)
                    {
                        errInfo.InnerText = "Invalid class code.";
                        errInfo.Visible = true;
                        return;
                    }

                    classID = Convert.ToInt32(result);
                }

                string checkQuery = @"
            SELECT COUNT(*)
            FROM Enrolment e
            INNER JOIN Student s
                ON e.studentID = s.studentID
            WHERE s.userID = @userID
              AND e.classID = @classID";

                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    cmd.Parameters.AddWithValue("@classID", classID);

                    int existingEnrollment = Convert.ToInt32(cmd.ExecuteScalar());

                    if (existingEnrollment > 0)
                    {
                        errInfo.InnerText = "You have already joined this class.";
                        errInfo.Visible = true;
                        return;
                    }
                }

                string insertQuery = @"
            INSERT INTO Enrolment (studentID, classID, enrollDate)
            SELECT s.studentID, @classID, GETDATE()
            FROM Student s
            WHERE s.userID = @userID";

                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);
                    cmd.Parameters.AddWithValue("@classID", classID);

                    cmd.ExecuteNonQuery();
                }

                Response.Redirect("StudentDashboard.aspx");
            }
        }

        private void LoadQuizProgress()
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int totalQuizzes = 0;
            int completedQuizzes = 0;

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string totalQuizQuery = @"SELECT COUNT(DISTINCT q.quizID) FROM Quiz q
INNER JOIN Enrolment e ON q.classID = e.classID 
INNER JOIN Student s ON e.studentID = s.studentID 
WHERE s.userID = @userID ";

                using (SqlCommand cmd = new SqlCommand(totalQuizQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    totalQuizzes = Convert.ToInt32(cmd.ExecuteScalar());
                }


                string completedQuizQuery = @" SELECT COUNT(DISTINCT r.quizID) FROM Result r INNER JOIN Student s ON r.studentID = s.studentID WHERE s.userID = @userID";

                using (SqlCommand cmd = new SqlCommand(completedQuizQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    completedQuizzes = Convert.ToInt32(cmd.ExecuteScalar());
                }

                // Recalculate progress percentage and update the Student table
                ProgressCalculator.Recalculate(Convert.ToInt32(userID));

                string progressQuery = @"SELECT progressPercentage FROM Student WHERE userID = @userID";

                using (SqlCommand cmd = new SqlCommand(progressQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    int progressPercentage = Convert.ToInt32(cmd.ExecuteScalar());

                    progressNumber.InnerText = progressPercentage + "%";
                    progressFill.Style["width"] = progressPercentage + "%";
                }
            }



        }

        protected void JoinLiveSession_Click(object sender, EventArgs e)
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string sessionCode = liveSessionCode.Value.Trim();

            liveSessionError.Visible = false;
            liveSessionError.InnerText = "";

            if (string.IsNullOrEmpty(sessionCode))
            {
                liveSessionError.InnerText = "Please enter a live session code.";
                liveSessionError.Visible = true;
                return;
            }

            string query = @"
        SELECT TOP 1
            ls.sessionID,
            ls.classID,
            ls.title,
            ls.starttime,
            ls.endtime
        FROM LiveSession ls
        INNER JOIN Enrolment e
            ON ls.classID = e.classID
        INNER JOIN Student s
            ON e.studentID = s.studentID
        WHERE s.userID = @userID
          AND ls.sessionID = @sessionID
          AND GETDATE() >= ls.starttime
          AND GETDATE() <= ls.endtime";

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);
                cmd.Parameters.AddWithValue("@sessionID", sessionCode);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (!reader.Read())
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

}


