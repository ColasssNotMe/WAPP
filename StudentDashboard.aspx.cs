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
    }
}