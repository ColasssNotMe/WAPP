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
        FROM [User] u
        INNER JOIN Teacher t
            ON u.userID = t.userID
        WHERE Email = @email
        AND Password = @password";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());
                    cmd.Parameters.AddWithValue("@password", PasswordTextBox.Text);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Session["email"] = EmailTextBox.Text.Trim();
                            Session["username"] = reader["username"].ToString().Trim();
                            Session["userId"] = reader["userId"];
                            Session["role"] = reader["role"].ToString().Trim();

                            if (reader["profilePic"] == DBNull.Value ||
                                string.IsNullOrWhiteSpace(reader["profilePic"].ToString()))
                            {
                                Session["profilePic"] = "svg/user.svg";
                            }
                            else
                            {
                                Session["profilePic"] = reader["profilePic"].ToString().Trim();
                            }

                            //Redirect based on role
                            string role = reader["role"].ToString().Trim().ToLower();

                            if (role == "admin")
                            {
                                Response.Redirect("AdminDashboard.aspx");
                            }
                            else if (role == "teacher")
                            {
                                if (reader["approved"] == DBNull.Value || reader["approved"].ToString().ToLower() != "true")
                                {
                                    LoginMessage.Text = "Your account is not yet approved.";
                                    LoginMessage.Visible = true;
                                }
                                else
                                {
                                    Response.Redirect("TeacherDashboard.aspx");
                                }
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
                            LoginMessage.Text = "Invalid email or password.";
                            LoginMessage.Visible = true;
                        }
                    }
                }

            }
        }
    }
}