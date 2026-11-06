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
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadAllClassrooms();
            }
        }

        private void LoadAllClassrooms()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                // Global query returning all active classrooms with student, note, and quiz metrics
                string query = @"
                    SELECT 
                        c.classID,
                        c.className,
                        ISNULL(c.subject, '') AS subject,
                        (SELECT COUNT(*) FROM Enrolment e WHERE e.classID = c.classID) AS StudentCount,
                        (SELECT COUNT(*) FROM Material m WHERE m.classID = c.classID) AS NoteCount,
                        (SELECT COUNT(*) FROM Quiz q WHERE q.classID = c.classID) AS QuizCount
                    FROM Class c
                    ORDER BY c.className ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptClassrooms.DataSource = dt;
                            rptClassrooms.DataBind();
                            pnlNoClasses.Visible = false;
                        }
                        else
                        {
                            pnlNoClasses.Visible = true;
                        }
                    }
                }
            }
        }
    }
}