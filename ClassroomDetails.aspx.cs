using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class ClassroomDetails : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["classID"] != null)
                {
                    int classId = Convert.ToInt32(Request.QueryString["classID"]);
                    LoadClassroomDetails(classId);
                }
                else
                {
                    Response.Redirect("MyClasses.aspx");
                }
            }
        }

        private void LoadClassroomDetails(int classId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"
                    SELECT 
                        c.classID,
                        c.className,
                        c.subject,
                        c.description,
                        c.inviteCode,
                        c.startDate,
                        ISNULL(u.firstName + ' ' + u.lastName, 'Assigned Teacher') AS TeacherName,
                        (SELECT COUNT(*) FROM Enrolment e WHERE e.classID = c.classID) AS StudentCount
                    FROM Class c
                    LEFT JOIN Teacher t ON c.teacherID = t.teacherID
                    LEFT JOIN [User] u ON t.userID = u.userID
                    WHERE c.classID = @classID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string className = reader["className"].ToString();
                        string subject = reader["subject"].ToString();

                        lblClassName.Text = $"{className} • {subject}";
                        lblClassSubtitle.Text = className;
                        lblTeacherName.Text = reader["TeacherName"].ToString();
                        lblInviteCode.Text = reader["inviteCode"].ToString();

                        if (reader["startDate"] != DBNull.Value)
                        {
                            DateTime dt = Convert.ToDateTime(reader["startDate"]);
                            lblCreatedDate.Text = dt.ToString("MMMM yyyy");
                        }
                        else
                        {
                            lblCreatedDate.Text = "N/A";
                        }

                        string desc = reader["description"].ToString();
                        lblDescription.Text = string.IsNullOrEmpty(desc)
                            ? "This classroom is used for daily lessons, quiz assignments, and subject materials."
                            : desc;

                        lblStudentCount.Text = $"{reader["StudentCount"]} students";

                        lnkEditClass.NavigateUrl = $"EditClassroom.aspx?classID={classId}";
                    }
                    else
                    {
                        Response.Redirect("MyClasses.aspx");
                    }
                }
            }
        }
    }
}