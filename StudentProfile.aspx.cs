using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class StudentProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                txtUsername.Text = Session["username"]?.ToString() ?? "";
                usernameDisplay.InnerText = Session["username"]?.ToString() ?? "";
                txtEmail.Text = Session["email"]?.ToString() ?? "";
                txtRole.Text = Session["role"]?.ToString() ?? "Student";

                string profilePicUrl = Session["profilePic"]?.ToString() ?? "~/svg/user.svg";

                profilePic.Src = profilePicUrl;
            }
            LoadStudentProfile();
        }

        private void LoadStudentProfile()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                SELECT 
                    u.firstName,
                    u.lastName,
                    s.age,
                    s.gradeLevel,
                    s.school,
                    u.dateRegistered
                FROM [User] u
                INNER JOIN Student s
                    ON u.userId = s.userId
                WHERE u.userId = @userId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                {
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                    conn.Open();

                    SqlDataReader reader = cmd.ExecuteReader();
                    {
                        if (reader.Read())
                        {
                            string firstName = reader["firstName"].ToString();
                            string lastName = reader["lastName"].ToString();

                            txtFirstName.Text = reader["firstName"].ToString();
                            txtLastName.Text = reader["lastName"].ToString();
                            txtAge.Text = reader["age"].ToString();
                            txtGrade.Text = reader["gradeLevel"].ToString();
                            txtSchool.Text = reader["school"].ToString();
                        }
                        reader.Close();
                        conn.Close();
                    }
                }
            }
        }

        private void SaveProfile()
        {
        }

    }
}