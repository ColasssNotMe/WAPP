using System;
using System.Configuration;
using System.Data.SqlClient;
namespace Assignment
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("Homepage");
            }
        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
        SELECT 
            u.userID,
            u.username,
            u.role,
            u.email,
            u.password,
            u.profilePic,
            t.approved,
            s.studentID
        FROM [User] u
        LEFT JOIN Student s
            ON u.userID = s.userID
        LEFT JOIN Teacher t
            ON u.userID = t.userID
        WHERE u.email = @email";

            PasswordManager passwordManager = new PasswordManager();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            bool passwordCorrect = passwordManager.VerifyPassword(PasswordTextBox.Text, reader["password"].ToString());

                            if (!passwordCorrect)
                            {
                                LoginMessage.Text = "Invalid email or password.";
                                LoginMessage.Visible = true;
                                return;
                            }

                            string role = reader["role"].ToString().Trim().ToLower();
                            if (role == "teacher")
                            {
                                bool approved = reader["approved"] != DBNull.Value && Convert.ToBoolean(reader["approved"]);

                                if (!approved)
                                {
                                    LoginMessage.Text = "Your account is not yet approved.";
                                    LoginMessage.Visible = true;
                                    return;
                                }

                            }


                            Session["email"] = reader["email"].ToString().Trim();
                            Session["username"] = reader["username"].ToString().Trim();
                            Session["userId"] = reader["userID"];
                            Session["role"] = reader["role"].ToString().Trim();
                            Session["studentId"] = reader["studentID"].ToString().Trim();

                            if (reader["profilePic"] == DBNull.Value ||
                                string.IsNullOrWhiteSpace(reader["profilePic"].ToString()))
                            {
                                Session["profilePic"] = "~/svg/user.svg";
                            }
                            else
                            {
                                Session["profilePic"] =
                                    reader["profilePic"].ToString().Trim();
                            }

                            if (role.ToLower() == "admin")
                            {
                                Response.Redirect("AdminDashboard.aspx");
                            }
                            else if (role.ToLower() == "teacher")
                            {
                                Response.Redirect("TeacherDashboard.aspx");
                            }
                            else if (role.ToLower() == "student")
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