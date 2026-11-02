using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class TeacherDashboard : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblTeacherName.Text = Session["username"] != null ? Session["username"].ToString() : "Teacher";

                LoadDashboardCounts();
                LoadRecentMaterials();
                LoadRecentQuizzes();
                LoadClassroomSummary();
            }
        }

        private void LoadDashboardCounts()
        {
            string query = @"
                SELECT
                    (SELECT COUNT(DISTINCT studentID) FROM Enrolment) AS studentCount,
                    (SELECT COUNT(*) FROM Class) AS classroomCount,
                    (SELECT COUNT(*) FROM Quiz) AS quizCount,
                    (SELECT COUNT(*) FROM Material) AS noteCount
            ";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblStudentCount.Text = reader["studentCount"].ToString();
                            lblActiveClassrooms.Text = reader["classroomCount"].ToString();
                            lblQuizCount.Text = reader["quizCount"].ToString();
                            lblNoteCount.Text = reader["noteCount"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadRecentMaterials()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"SELECT TOP 5 m.materialID, m.title, m.chapter, m.uploadDate, c.className 
                                FROM Material m 
                                INNER JOIN Class c ON m.classID = c.classID 
                                ORDER BY m.uploadDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptRecentMaterials.DataSource = dt;
                            rptRecentMaterials.DataBind();
                            pnlNoMaterials.Visible = false;
                        }
                        else
                        {
                            pnlNoMaterials.Visible = true;
                        }
                    }
                }
            }
        }

        private void LoadRecentQuizzes()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"SELECT TOP 5 q.quizID, q.title, q.totalMarks, q.createdDate, c.className 
                                FROM Quiz q 
                                INNER JOIN Class c ON q.classID = c.classID 
                                ORDER BY q.createdDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptRecentQuizzes.DataSource = dt;
                            rptRecentQuizzes.DataBind();
                            pnlNoQuizzes.Visible = false;
                        }
                        else
                        {
                            pnlNoQuizzes.Visible = true;
                        }
                    }
                }
            }
        }

        private void LoadClassroomSummary()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"SELECT c.className, COUNT(e.studentID) AS StudentCount 
                                FROM Class c 
                                LEFT JOIN Enrolment e ON c.classID = e.classID 
                                GROUP BY c.classID, c.className 
                                ORDER BY c.className ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptClassroomSummary.DataSource = dt;
                            rptClassroomSummary.DataBind();
                            pnlNoClassrooms.Visible = false;
                        }
                        else
                        {
                            pnlNoClassrooms.Visible = true;
                        }
                    }
                }
            }
        }
    }
}