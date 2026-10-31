using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace Assignment
{
    public partial class CreateClassroom : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCreateClassroom_Click(object sender, EventArgs e)
        {
            string className = txtClassroomName.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrEmpty(className))
            {
                return;
            }

            int teacherId = GetValidTeacherId();

            if (teacherId == 0)
            {
                // Safety check: No teacher records exist in Teacher table
                return;
            }

            // Generate a random 6-character alphanumeric invite code
            string inviteCode = GenerateInviteCode(6);

            // Set dates based on creation time
            DateTime startDate = DateTime.Now;
            DateTime endDate = startDate.AddYears(1);

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"INSERT INTO Class (teacherID, className, subject, description, inviteCode, startDate, endDate) 
                                VALUES (@teacherID, @className, @subject, @description, @inviteCode, @startDate, @endDate)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@teacherID", teacherId);
                    cmd.Parameters.AddWithValue("@className", className);
                    cmd.Parameters.AddWithValue("@subject", "Sejarah"); // Default subject
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@inviteCode", inviteCode);
                    cmd.Parameters.AddWithValue("@startDate", startDate);
                    cmd.Parameters.AddWithValue("@endDate", endDate);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("MyClasses.aspx");
        }

        private int GetValidTeacherId()
        {
            // 1. Try to get teacherID from active Session
            if (Session["teacherID"] != null)
            {
                return Convert.ToInt32(Session["teacherID"]);
            }

            // 2. Fallback: Fetch the first existing teacherID from the database to avoid Foreign Key violations
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT TOP 1 teacherID FROM Teacher ORDER BY teacherID ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToInt32(result);
                    }
                }
            }

            return 0;
        }

        private string GenerateInviteCode(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Random random = new Random();
            return new string(Enumerable.Repeat(chars, length)
                .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}