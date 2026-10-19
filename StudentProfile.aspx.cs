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
                // Check whether user is logged in
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                txtUsername.Text = Session["username"]?.ToString() ?? "";
                txtEmail.Text = Session["email"]?.ToString() ?? "";
                txtRole.Text = Session["role"]?.ToString() ?? "Student";

                LoadStudentProfile();
            }
        }

        private void LoadStudentProfile()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                SELECT 
                    firstName,
                    lastName,
                    age,
                    grade,
                    school,
                    dateRegistered,
                    subject
                FROM Student
                WHERE userId = @userId";

            SqlConnection conn = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(query, conn);
            {
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();
                {
                    if (reader.Read())
                    {
                        txtFirstName.Text = reader["firstName"].ToString();
                        txtLastName.Text = reader["lastName"].ToString();
                        txtAge.Text = reader["age"].ToString();
                        txtGrade.Text = reader["grade"].ToString();
                        txtSchool.Text = reader["school"].ToString();
                    }
                    reader.Close();
                    conn.Close();
                }
            }
        }
    }
}