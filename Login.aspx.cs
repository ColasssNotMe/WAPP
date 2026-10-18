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

            System.Data.SqlClient.SqlConnection conn =
                new System.Data.SqlClient.SqlConnection(
                    ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString
                );
            conn.Open();

            string query = @"SELECT * FROM [User] WHERE Email=@email AND Password=@password";


            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@email", EmailTextBox.Text);
            cmd.Parameters.AddWithValue("@password", PasswordTextBox.Text);

            int count = Convert.ToInt32(cmd.ExecuteScalar().ToString());


            if (EmailTextBox.Text == "admin@company.com" && PasswordTextBox.Text == "password")
            {
                Session["email"] = EmailTextBox.Text;
                Session["username"] = "admin";
                Session["userId"] = 0;
                Session["role"] = "admin";
                Response.Redirect("Dashboard.aspx");
            }
            else
            {
                if (count > 0)
                {
                    string query1 = @"SELECT * FROM [User] WHERE Email=@email AND Password=@password";

                    SqlCommand cmd1 = new SqlCommand(query1, conn);

                    cmd1.Parameters.AddWithValue("@email", EmailTextBox.Text);
                    cmd1.Parameters.AddWithValue("@password", PasswordTextBox.Text);

                    SqlDataReader reader = cmd1.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["email"] = EmailTextBox.Text;
                        Session["username"] = reader["username"].ToString();
                        Session["userId"] = reader["userId"].ToString();
                        Session["role"] = reader["role"].ToString();
                        Session["profilePic"] = reader["profilePic"].ToString();
                        if (Session["profilePic"] == null)
                        {
                            Session["profilePic"] = "svg/user.svg";
                        }
                        Session["role"] = reader["role"].ToString();

                        if (Session["role"].ToString().ToLower().Trim() == "admin")
                        {
                            Response.Redirect("AdminDashboard.aspx");
                        }
                        else if (Session["role"].ToString().ToLower().Trim() == "teacher")
                        {
                            Response.Redirect("TeacherDashboard.aspx");

                        }
                        else if (Session["role"].ToString().ToLower().Trim() == "student")
                        {

                            Response.Redirect("StudentDashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("Homepage.aspx");
                        }

                    }
                }

            }


        }
    }
}