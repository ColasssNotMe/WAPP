using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls.WebParts;

namespace Assignment
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        private static string ConnString =>
            ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            try
            {
                int userId = Convert.ToInt32(Session["userId"]);

                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();
                    const string userQuery =
                        "SELECT username, email, firstName, lastName, phone, joinedDate " +
                        "FROM [Users] WHERE [userID] = @userID";

                    using (SqlCommand cmd = new SqlCommand(userQuery, conn))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = userId;

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string firstName = reader["firstName"].ToString();
                                string lastName = reader["lastName"].ToString();
                                string name = $"{firstName} {lastName}";
                                
                                fullName.Value = name;username.InnerText = name;
                                usernameInput.Value = reader["username"].ToString();
                                email.Value = reader["email"].ToString();
                                fullName.Value = name;
                                phone.Value = reader["phone"].ToString();

                                if (reader["joinedDate"] != DBNull.Value)
                                {
                                    joinedDate.InnerText =
                                        Convert.ToDateTime(reader["joinedDate"]).ToString("MMMM yyyy");
                                }
                            }
                        }
                    }

                    const string schoolQuery = "SELECT school FROM [Teacher] WHERE [userID] = @userID";

                    using (SqlCommand schoolCmd = new SqlCommand(schoolQuery, conn))
                    {
                        schoolCmd.Parameters.Add("@userID", SqlDbType.Int).Value = userId;

                        object result = schoolCmd.ExecuteScalar();
                        if (result != null && result != DBNull.Value)
                        {
                            school.Value = result.ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }
    }
}