
using System;
using System.Web.UI;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            student_num.InnerText = "TEST";
            if (!IsPostBack)
            {
                loadData();
            }
        }

        private void loadData()
        {
            string query = "SELECT COUNT(*) FROM [User] WHERE [role] = @Role";

            string connString = ConfigurationManager
                .ConnectionStrings["WAPP"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.Add("@Role", SqlDbType.NVarChar, 50)
                                  .Value = "student";

                    conn.Open();

                    int studentCount = Convert.ToInt32(
                        cmd.ExecuteScalar()
                    );

                    student_num.InnerText = studentCount.ToString();
                }
            }
            catch (Exception ex)
            {
                student_num.InnerText = "Error: " + ex.Message;
            }
        }
    }
}
