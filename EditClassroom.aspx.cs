using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Assignment
{
    public partial class EditClassroom : System.Web.UI.Page
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
                if (Request.QueryString["classID"] != null)
                {
                    int classId = Convert.ToInt32(Request.QueryString["classID"]);
                    LoadClassroomData(classId);
                    btnDelete.Visible = true;
                }
                else
                {
                    lblPageTitle.Text = "Create Classroom";
                    btnSaveChanges.Text = "Create classroom";
                    btnDelete.Visible = false;
                }
            }
        }

        private void LoadClassroomData(int classId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT className, subject, description FROM Class WHERE classID = @classID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtClassName.Text = reader["className"] != DBNull.Value ? reader["className"].ToString() : "";
                            txtSubject.Text = reader["subject"] != DBNull.Value ? reader["subject"].ToString() : "";
                            txtDescription.Text = reader["description"] != DBNull.Value ? reader["description"].ToString() : "";
                        }
                    }
                }
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string className = txtClassName.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrEmpty(className))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertName", "alert('Please enter a classroom name.');", true);
                return;
            }

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                conn.Open();

                if (Request.QueryString["classID"] != null)
                {
                    // Update existing classroom
                    int classId = Convert.ToInt32(Request.QueryString["classID"]);
                    string updateQuery = @"UPDATE Class 
                                            SET className = @className, 
                                                subject = @subject, 
                                                description = @description 
                                            WHERE classID = @classID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@className", className);
                        cmd.Parameters.AddWithValue("@subject", subject);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@classID", classId);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    // Create new classroom
                    string inviteCode = Guid.NewGuid().ToString().Substring(0, 6).ToUpper();
                    int teacherId = Session["teacherID"] != null ? Convert.ToInt32(Session["teacherID"]) : 1;
                    DateTime currentDate = DateTime.Now;

                    string insertQuery = @"INSERT INTO Class (className, subject, description, teacherID, inviteCode, startDate, endDate) 
                                           VALUES (@className, @subject, @description, @teacherID, @inviteCode, @startDate, @endDate)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@className", className);
                        cmd.Parameters.AddWithValue("@subject", subject);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@teacherID", teacherId);
                        cmd.Parameters.AddWithValue("@inviteCode", inviteCode);
                        cmd.Parameters.AddWithValue("@startDate", currentDate);
                        cmd.Parameters.AddWithValue("@endDate", currentDate);

                        cmd.ExecuteNonQuery();
                    }
                }
            }

            Response.Redirect("MyClasses.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["classID"] == null) return;

            int classId = Convert.ToInt32(Request.QueryString["classID"]);

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                conn.Open();
                using (SqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        string delEnrolment = "DELETE FROM Enrolment WHERE classID = @classID";
                        using (SqlCommand cmd = new SqlCommand(delEnrolment, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@classID", classId);
                            cmd.ExecuteNonQuery();
                        }

                        string delMaterial = "DELETE FROM Material WHERE classID = @classID";
                        using (SqlCommand cmd = new SqlCommand(delMaterial, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@classID", classId);
                            cmd.ExecuteNonQuery();
                        }

                        string delQuiz = "DELETE FROM Quiz WHERE classID = @classID";
                        using (SqlCommand cmd = new SqlCommand(delQuiz, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@classID", classId);
                            cmd.ExecuteNonQuery();
                        }

                        string delClass = "DELETE FROM Class WHERE classID = @classID";
                        using (SqlCommand cmd = new SqlCommand(delClass, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@classID", classId);
                            cmd.ExecuteNonQuery();
                        }

                        transaction.Commit();
                    }
                    catch (Exception)
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }

            Response.Redirect("MyClasses.aspx");
        }
    }
}