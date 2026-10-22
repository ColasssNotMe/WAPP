
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class AdminUserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadData();
            }
        }

        private void loadData()
        {
            string totalUser = "SELECT COUNT(*) FROM [Users]";

            string connString = ConfigurationManager
                .ConnectionStrings["WAPP"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand(totalUser, conn))
                    {
                        int count = Convert.ToInt32(cmd.ExecuteScalar());

                        totalUsers.InnerText = count.ToString()
                            + " Total Users";
                    }
                }
            }
            catch (Exception ex)
            {
                totalUsers.InnerText = "Unable to load users";

                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }
    }
}
