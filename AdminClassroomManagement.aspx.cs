using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class AdminClassroomManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Homepage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadClassroomData();
            }
        }

        private void LoadClassroomData()
        {
            string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string  query = @"
                SELECT  c.classID   AS ClassID,
                        c.className AS ClassName,
                        ISNULL(u.fullName, 'Unassigned') AS TeacherName,
                        COUNT(e.studentID) AS StudentCount,
                        c.status    AS Status
                FROM    [Class] c
                LEFT JOIN Users u      ON u.userID  = c.teacherID
                LEFT JOIN Enrolment e  ON e.classID = c.classID
                GROUP BY c.classID, c.className, u.fullName, c.status
                ORDER BY c.className";

            string searchTerm = Request.QueryString["search"];


            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
            {
                da.Fill(dt);   // opens and closes the connection itself
            }

            rptClassrooms.DataSource = dt;
            rptClassrooms.DataBind();

            int total = dt.Rows.Count;
            int active = dt.Select("Status = 'Active'").Length;

            totalClassrooms.InnerText = total + (total == 1 ? " classroom" : " classrooms");
            //classroomMeta.InnerText = $"{total} classrooms · {active} active · {total - active} inactive";
        }
    }
}