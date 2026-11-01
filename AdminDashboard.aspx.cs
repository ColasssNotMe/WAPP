
using System;
using System.Web.UI;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                Logger.LogActivity("Username: " +Session["username"].ToString() + " Role: " + Session["role"].ToString() + " | logged in successfully.");
                loadData();
                LoadRecentLogs();
                welcomeMessage.InnerText = "Welcome, " + Session["Username"].ToString() + "!";
            }
        }

        private void loadData()
        {
            string student = "SELECT COUNT(*) FROM [User] WHERE [role] = 'Student'";
            string teacher = "SELECT COUNT(*) FROM [User] WHERE [role] = 'Teacher'";
            string classroom = "SELECT COUNT(*) FROM [Class]";
            string quiz = "SELECT COUNT(*) FROM [Quiz]";
            string pendingTeacher = "SELECT COUNT(*) FROM [Teacher] WHERE approved = 'false' OR approved IS NULL";

            string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(student, conn);
                    student_num.InnerText = cmd.ExecuteScalar().ToString();

                    cmd = new SqlCommand(teacher, conn);
                    teacher_num.InnerText = cmd.ExecuteScalar().ToString();

                    cmd = new SqlCommand(classroom, conn);
                    classroom_num.InnerText = cmd.ExecuteScalar().ToString();

                    cmd = new SqlCommand(quiz, conn);
                    quiz_num.InnerText = cmd.ExecuteScalar().ToString();

                    cmd = new SqlCommand(pendingTeacher, conn);
                    teacherRequest.InnerText = cmd.ExecuteScalar().ToString() + " Requests";
                    pendingTeacherNum.InnerText = cmd.ExecuteScalar().ToString() + " registrations need a decision.";
                    teacher_approval.InnerText = cmd.ExecuteScalar().ToString() + " awaiting approval";
                }
            }
            catch (Exception ex)
            {
                student_num.InnerText = "Error: " + ex.Message;
            }
        }

        private void LoadRecentLogs()
        {
            string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            string sql = @"
                SELECT TOP 5 description, createdAt 
                FROM [Syslog] 
                ORDER BY createdAt DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

            rptRecentLogs.DataSource = dt;
            rptRecentLogs.DataBind();
        }

    }
}
