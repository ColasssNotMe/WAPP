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
                if (Session["userId"].ToString() == null)
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
            u.userId,
            u.username,
            u.role,
            u.firstName,
            u.lastName,
            u.email,
            u.dateRegistered,
            s.gradeLevel,
            s.school
        FROM [User] u
        INNER JOIN Student s
            ON u.userId = s.userId
        WHERE u.userId = @userId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFirstName.Text = reader["firstName"].ToString();
                            txtLastName.Text = reader["lastName"].ToString();
                            txtUsername.Text = reader["username"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            txtRole.Text = reader["role"].ToString();

                            txtGrade.Text = reader["gradeLevel"].ToString();
                            txtSchool.Text = reader["school"].ToString();

                            accountUserId.InnerText = reader["userId"].ToString();
                            accountUsername.InnerText = reader["username"].ToString();
                            accountRole.InnerText = reader["role"].ToString();
                            accountSchool.InnerText = reader["school"].ToString();

                            if (reader["dateRegistered"] != DBNull.Value)
                            {
                                DateTime dateRegistered =
                                    Convert.ToDateTime(reader["dateRegistered"]);

                                accountDateRegistered.InnerText =
                                    dateRegistered.ToString("MMMM yyyy");
                            }
                            else
                            {
                                accountDateRegistered.InnerText = "—";
                            }
                        }
                    }
                }
            }
        }
        private void SaveProfile()
        {
        }

    }
}