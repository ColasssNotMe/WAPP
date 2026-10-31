using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class MyClasses : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClasses();
            }
        }

        private void LoadClasses()
        {
            int teacherId = Session["teacherID"] != null ? Convert.ToInt32(Session["teacherID"]) : 1;

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"
                    SELECT 
                        c.classID,
                        c.className,
                        c.subject,
                        c.description,
                        (SELECT COUNT(*) FROM Enrolment e WHERE e.classID = c.classID) AS StudentCount,
                        (SELECT COUNT(*) FROM Quiz q WHERE q.classID = c.classID) AS QuizCount,
                        (SELECT COUNT(*) FROM Material m WHERE m.classID = c.classID) AS MaterialCount
                    FROM Class c
                    WHERE c.teacherID = @teacherID OR @teacherID = 1
                    ORDER BY c.classID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@teacherID", teacherId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        rptClasses.DataSource = dt;
                        rptClasses.DataBind();
                    }
                }
            }
        }
    }
}