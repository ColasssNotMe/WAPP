using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminClassroomManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserID"] == null)
            //{
            //    Response.Redirect("Homepage.aspx");
            //    return;
            //}

            if (!IsPostBack)
            {
                loadData();
            }
        }

        private void loadData()
        {
            string classroom = "SELECT * FROM [Class]";

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connString))
            {
                conn.Open();
                try
                {
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(classroom, conn);
                    System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(cmd);
                    System.Data.DataTable dt = new System.Data.DataTable();
                    da.Fill(dt);
                    classroom_num.InnerText = dt.Rows.Count.ToString();
                }
                catch (Exception ex)
                {
                    // Handle exception (e.g., log the error)
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
}