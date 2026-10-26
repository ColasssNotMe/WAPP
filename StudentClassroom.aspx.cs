using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentClassroom : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClassrooms();
            }
        }


        private void LoadClassrooms()
        {
            string userID = Session["userID"]?.ToString();

            if (string.IsNullOrEmpty(userID))
            {
                Response.Redirect("Login.aspx");
                return;
            }


            string query = @"
                SELECT
                    c.classID,
                    c.className,
                    c.subject,
                    c.description,
                    u.lastName,
                    u.profilePic,
                    e.enrollDate
                FROM Enrolment e

                INNER JOIN Class c
                    ON e.classID = c.classID

                INNER JOIN Teacher t
                    ON c.teacherID = t.teacherID

                INNER JOIN [User] u
                    ON t.userID = u.userID

                INNER JOIN Student s
                    ON e.studentID = s.studentID

                WHERE s.userID = @userID

                ORDER BY e.enrollDate DESC";


            DataTable dt = new DataTable();


            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);


                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }


            foreach (DataRow row in dt.Rows)
            {
                int classID =
                    Convert.ToInt32(row["classID"]);

                row["studentCount"] =
                    GetStudentCount(classID);
            }


            ClassroomRepeater.DataSource = dt;
            ClassroomRepeater.DataBind();


            classroomCount.InnerText =
                dt.Rows.Count + " joined classrooms";

            if (dt.Rows.Count == 0)
            {
                emptyClassroomPanel.Visible = true;
            }
        }


        private int GetStudentCount(int classID)
        {
            string query = @"
                SELECT COUNT(*)
                FROM Enrolment
                WHERE studentID = @studentID";


            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@studentID",
                        Session["studentID"]);

                    conn.Open();

                    return Convert.ToInt32(
                        cmd.ExecuteScalar());
                }
            }
        }


        protected void ClassroomRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewClassroom")
            {
                int classID =
                    Convert.ToInt32(e.CommandArgument);

                Session["classID"] = classID;

                Response.Redirect("Classroom.aspx");
            }
        }
    }
}