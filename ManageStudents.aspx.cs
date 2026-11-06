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
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

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
            string[] args = e.CommandArgument.ToString().Split('|');
            int studentId = Convert.ToInt32(args[0]);
            string studentName = args[1];

            if (e.CommandName == "OpenAssign")
            {
                hfSelectedStudentID.Value = studentId.ToString();
                lblModalStudentName.Text = studentName;
                ddlClassrooms.SelectedIndex = 0;

                assignModal.Style["display"] = "flex";
            }
            else if (e.CommandName == "ViewResults")
            {
                lblResultStudentName.Text = studentName;
                LoadStudentQuizResults(studentId);
                resultsModal.Style["display"] = "flex";
            }
        }

        private void LoadStudentQuizResults(int studentId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT 
                        r.resultID,
                        r.score,
                        r.timeTaken,
                        q.title AS QuizTitle,
                        q.totalMarks,
                        c.className
                    FROM Result r
                    INNER JOIN Quiz q ON r.quizID = q.quizID
                    INNER JOIN Class c ON q.classID = c.classID
                    WHERE r.studentID = @studentID
                    ORDER BY r.resultID DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            rptStudentResults.DataSource = dt;
                            rptStudentResults.DataBind();
                            rptStudentResults.Visible = true;
                            pnlNoResults.Visible = false;
                        }
                        else
                        {
                            rptStudentResults.Visible = false;
                            pnlNoResults.Visible = true;
                        }
                    }
                }
            }
        }

        protected void btnCloseResults_Click(object sender, EventArgs e)
        {
            resultsModal.Style["display"] = "none";
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

                string insertQuery = @"INSERT INTO Enrolment (studentID, classID, enrollDate) 
                                       VALUES (@studentID, @classID, @enrollDate)";
                using (SqlCommand insCmd = new SqlCommand(insertQuery, conn))
                {
                    insCmd.Parameters.AddWithValue("@studentID", studentId);
                    insCmd.Parameters.AddWithValue("@classID", classId);
                    insCmd.Parameters.AddWithValue("@enrollDate", DateTime.Now);
                    insCmd.ExecuteNonQuery();
                }
            }

            assignModal.Style["display"] = "none";
            LoadStudentList();
        }
    }
}