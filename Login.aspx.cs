using System;
using System.Configuration;
using System.Data.SqlClient;
namespace Assignment
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
        SELECT *
        FROM [User]
        WHERE Email = @email
        AND Password = @password";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());
                cmd.Parameters.AddWithValue("@password", PasswordTextBox.Text);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Store user information in Session
                        Session["email"] = EmailTextBox.Text.Trim();
                        Session["username"] = reader["username"].ToString().Trim();
                        Session["userId"] = reader["userId"];
                        Session["role"] = reader["role"].ToString().Trim();

                        // Handle profile picture
                        if (reader["profilePic"] == DBNull.Value ||
                            string.IsNullOrWhiteSpace(reader["profilePic"].ToString()))
                        {
                            Session["profilePic"] = "svg/user.svg";
                        }
                        else
                        {
                            Session["profilePic"] = reader["profilePic"].ToString().Trim();
                        }

                        // Redirect based on role
                        string role = reader["role"].ToString().Trim().ToLower();

                        if (role == "admin")
                        {
                            Response.Redirect("AdminDashboard.aspx");
                        }
                        else if (role == "teacher")
                        {
                            Response.Redirect("TeacherDashboard.aspx");
                        }
                        else if (role == "student")
                        {
                            Response.Redirect("StudentDashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("Homepage.aspx");
                        }
                    }
                    else
                    {
                        // No matching email and password
                        LoginMessage.Text = "Invalid email or password.";
                        LoginMessage.Visible = true;
                    }
                }
            }
        }
    }
}