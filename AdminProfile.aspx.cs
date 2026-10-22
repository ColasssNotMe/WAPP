using System;
using System.Configuration;
using System.Data.SqlClient;


namespace Assignment
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        private void loadUserData()
        {

            string query = "SELECT * FROM [User] WHERE userID = @userID";


            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", Session["UserID"].ToString());
                }
                //ShowErrorMessage("An error occurred while loading user data: " + ex.Message);
            }
        }
    }
}