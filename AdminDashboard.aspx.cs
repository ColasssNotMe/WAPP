
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
            //if (Session["UserID"] == null)
            //{
            //    Response.Redirect("Login.aspx");
            //    return;
            //}

            if (!IsPostBack)
            {
                loadData();
                //welcomeMessage.InnerText = "Welcome, " + Session["Username"].ToString() + "!";
            }
        }

        protected void AddAdminButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            const string duplicateQuery = "SELECT COUNT(*) FROM [User] WHERE email = @email";
            const string insertQuery = @"
                INSERT INTO [User]
                    (username, email, password, firstName, lastName, role, profilePic, dateRegistered)
                VALUES
                    (@username, @email, @password, @firstName, @lastName, 'Admin', NULL, @dateRegistered)";

            string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                using (SqlCommand duplicateCommand = new SqlCommand(duplicateQuery, conn))
                {
                    duplicateCommand.Parameters.AddWithValue("@email", adminEmail.Text.Trim());
                    if (Convert.ToInt32(duplicateCommand.ExecuteScalar()) > 0)
                    {
                        adminMessage.Text = "That email is already registered.";
                        adminMessage.CssClass = "admin-message error";
                        return;
                    }
                }

                using (SqlCommand insertCommand = new SqlCommand(insertQuery, conn))
                {
                    string username = adminUsername.Text.Trim();
                    insertCommand.Parameters.AddWithValue("@username", username);
                    insertCommand.Parameters.AddWithValue("@email", adminEmail.Text.Trim());
                    insertCommand.Parameters.AddWithValue("@password", adminPassword.Text);
                    insertCommand.Parameters.AddWithValue("@firstName", username);
                    insertCommand.Parameters.AddWithValue("@lastName", string.Empty);
                    insertCommand.Parameters.AddWithValue("@dateRegistered", DateTime.Now);
                    insertCommand.ExecuteNonQuery();
                }
            }

            Response.Redirect(Request.RawUrl);
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

    }
}
