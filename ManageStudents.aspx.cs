using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ManageStudents : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudentList();
            }
        }

        private void BindStudentList()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"
                    SELECT
                        s.studentID,
                        u.username,
                        (u.firstName + ' ' + u.lastName) AS FullName,
                        LEFT(u.firstName, 1) AS Initial,
                        ISNULL(c.className, 'Unassigned') AS className,
                        ISNULL(CAST(AVG(p.progressPercent) AS INT), 0) AS AvgProgress
                    FROM Student s
                    INNER JOIN [User] u ON s.userID = u.userID
                    LEFT JOIN Enrolment e ON s.studentID = e.studentID
                    LEFT JOIN Class c ON e.classID = c.classID
                    LEFT JOIN Progress p ON s.studentID = p.studentID
                    GROUP BY s.studentID, u.username, u.firstName, u.lastName, c.className
                    ORDER BY u.firstName ASC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptStudents.DataSource = dt;
                        rptStudents.DataBind();

                        lblTotalStudents.Text = dt.Rows.Count + " students";
                    }
                }
            }
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenAssign")
            {
                int studentId = Convert.ToInt32(e.CommandArgument);
                ViewState["AssignStudentID"] = studentId;

                LoadClassroomsDropdown();
                LoadStudentName(studentId);

                pnlModal.Visible = true;
            }
        }

        private void LoadStudentName(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"SELECT (u.firstName + ' ' + u.lastName) AS FullName
                                FROM Student s
                                INNER JOIN [User] u ON s.userID = u.userID
                                WHERE s.studentID = @studentID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lblModalStudentName.Text = result.ToString();
                    }
                }
            }
        }

        private void LoadClassroomsDropdown()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT classID, className FROM Class ORDER BY className ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    ddlClassrooms.DataSource = cmd.ExecuteReader();
                    ddlClassrooms.DataTextField = "className";
                    ddlClassrooms.DataValueField = "classID";
                    ddlClassrooms.DataBind();
                }
            }
            ddlClassrooms.Items.Insert(0, new ListItem("-- Select Classroom --", ""));
        }

        protected void btnSaveAssignment_Click(object sender, EventArgs e)
        {
            if (ViewState["AssignStudentID"] != null && !string.IsNullOrEmpty(ddlClassrooms.SelectedValue))
            {
                int studentId = (int)ViewState["AssignStudentID"];
                int classId = Convert.ToInt32(ddlClassrooms.SelectedValue);

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();

                    string checkQuery = "SELECT COUNT(*) FROM Enrolment WHERE studentID = @studentID";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@studentID", studentId);
                        int count = (int)checkCmd.ExecuteScalar();

                        if (count > 0)
                        {
                            string updateQuery = "UPDATE Enrolment SET classID = @classID, status = 'Active' WHERE studentID = @studentID";
                            using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                            {
                                updateCmd.Parameters.AddWithValue("@classID", classId);
                                updateCmd.Parameters.AddWithValue("@studentID", studentId);
                                updateCmd.ExecuteNonQuery();
                            }
                        }
                        else
                        {
                            string insertQuery = "INSERT INTO Enrolment (studentID, classID, enrollDate, status) VALUES (@studentID, @classID, GETDATE(), 'Active')";
                            using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                            {
                                insertCmd.Parameters.AddWithValue("@studentID", studentId);
                                insertCmd.Parameters.AddWithValue("@classID", classId);
                                insertCmd.ExecuteNonQuery();
                            }
                        }
                    }
                }

                pnlModal.Visible = false;
                ViewState["AssignStudentID"] = null;
                BindStudentList();
            }
        }

        protected void btnCancelModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
            ViewState["AssignStudentID"] = null;
        }
    }
}