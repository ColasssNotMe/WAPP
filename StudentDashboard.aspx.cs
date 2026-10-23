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

            string query = @"INSERT INTO Enrolment (studentID, classID) SELECT s.studentID, c.classID FROM Student s INNER JOIN Class c ON c.inviteCode = @inviteCode WHERE s.userID = @userID";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@inviteCode", classCode);
                    cmd.Parameters.AddWithValue("@userID", userID);

                    conn.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected == 0)
                    {
                        errInfo.InnerText = "Invalid class code or you are already enrolled in this class.";
                        errInfo.Visible = true;
                        return;
                    }

                    Response.Redirect("StudentDashboard.aspx");
                }
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

                string totalQuizQuery = @"SELECT COUNT(DISTINCT q.quizID) FROM Quiz q INNER JOIN Enrolment e ON q.classID = e.classID INNER JOIN Student s ON e.studentID = s.studentID WHERE s.userID = @userID ";

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
            }


            int progressPercentage = 0;

            if (totalQuizzes > 0)
            {
                progressPercentage = (int)Math.Round(
                    (double)completedQuizzes / totalQuizzes * 100
                );
            }


            progressNumber.InnerText = progressPercentage + "%";
            progressFill.Style["width"] = progressPercentage + "%";
        }

    }
}