using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ManageStudents : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudentList();
                LoadClassroomsDropdown();
            }
        }

        private void LoadStudentList()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT 
                        s.studentID,
                        u.userID,
                        ISNULL(u.firstName + ' ' + u.lastName, u.username) AS StudentName,
                        u.username,
                        ISNULL(c.className, 'Unassigned') AS AssignedClass
                    FROM Student s
                    INNER JOIN [User] u ON s.userID = u.userID
                    LEFT JOIN Enrolment e ON s.studentID = e.studentID
                    LEFT JOIN Class c ON e.classID = c.classID
                    ORDER BY StudentName ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        rptStudents.DataSource = dt;
                        rptStudents.DataBind();

                        lblStudentCount.Text = dt.Rows.Count.ToString();
                    }
                }
            }
        }

        private void LoadClassroomsDropdown()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = "SELECT classID, className FROM Class ORDER BY className ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlClassrooms.DataSource = reader;
                    ddlClassrooms.DataTextField = "className";
                    ddlClassrooms.DataValueField = "classID";
                    ddlClassrooms.DataBind();
                }
            }

            ddlClassrooms.Items.Insert(0, new ListItem("-- Select Classroom --", "0"));
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenAssign")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                string studentId = args[0];
                string studentName = args[1];

                hfSelectedStudentID.Value = studentId;
                lblModalStudentName.Text = studentName;
                ddlClassrooms.SelectedIndex = 0;

                assignModal.Style["display"] = "flex";
            }
        }

        protected void btnCancelAssign_Click(object sender, EventArgs e)
        {
            assignModal.Style["display"] = "none";
            ddlClassrooms.SelectedIndex = 0;
            hfSelectedStudentID.Value = string.Empty;
        }

        protected void btnSaveAssign_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfSelectedStudentID.Value) || ddlClassrooms.SelectedValue == "0")
            {
                return;
            }

            int studentId = Convert.ToInt32(hfSelectedStudentID.Value);
            int classId = Convert.ToInt32(ddlClassrooms.SelectedValue);

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                string deleteQuery = "DELETE FROM Enrolment WHERE studentID = @studentID";
                using (SqlCommand delCmd = new SqlCommand(deleteQuery, conn))
                {
                    delCmd.Parameters.AddWithValue("@studentID", studentId);
                    delCmd.ExecuteNonQuery();
                }

                string insertQuery = @"INSERT INTO Enrolment (studentID, classID, enrolDate) 
                                       VALUES (@studentID, @classID, @enrolDate)";
                using (SqlCommand insCmd = new SqlCommand(insertQuery, conn))
                {
                    insCmd.Parameters.AddWithValue("@studentID", studentId);
                    insCmd.Parameters.AddWithValue("@classID", classId);
                    insCmd.Parameters.AddWithValue("@enrolDate", DateTime.Now);
                    insCmd.ExecuteNonQuery();
                }
            }

            assignModal.Style["display"] = "none";
            LoadStudentList();
        }
    }
}