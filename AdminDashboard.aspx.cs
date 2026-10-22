using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class AdminDashboard : System.Web.UI.Page
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
            string student = "SELECT * FROM [User] WHERE [role] = 'Student'";
            string teacher = "SELECT * FROM [User] WHERE [role] = 'Teacher'";
            //string teacher_pending = "SELECT * FROM [User] WHERE [role] = 'Teacher' AND [isApproved] = 0";
            string classroom = "SELECT * FROM [Class]";
            string quiz = "SELECT * FROM [Quiz]";


            string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                try
                {
                    SqlCommand cmd = new SqlCommand(student, conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    da.Fill(dt);
                    student_num.InnerText = dt.Rows.Count.ToString();

                    cmd = new SqlCommand(teacher, conn);
                    da = new SqlDataAdapter(cmd);
                    dt = new DataTable();

                    da.Fill(dt);
                    teacher_num.InnerText = dt.Rows.Count.ToString();

                    cmd = new SqlCommand(classroom, conn);
                    da = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    da.Fill(dt);
                    classroom_num.InnerText = dt.Rows.Count.ToString();

                    cmd = new SqlCommand(quiz, conn);
                    da = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    da.Fill(dt);
                    quiz_num.InnerText = dt.Rows.Count.ToString();


                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
        }
    }
}