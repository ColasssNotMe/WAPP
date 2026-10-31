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
                string query = "SELECT className, description FROM Class WHERE classID = @classID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtClassroomName.Text = reader["className"].ToString();
                        txtDescription.Text = reader["description"].ToString();
                    }
                    else
                    {
                        Response.Redirect("MyClasses.aspx");
                    }
                }
            }
        }

        protected void btnSaveClassroom_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["classID"] == null)
            {
                Response.Redirect("MyClasses.aspx");
                return;
            }

            int classId = Convert.ToInt32(Request.QueryString["classID"]);
            string className = txtClassroomName.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrEmpty(className))
            {
                return;
            }

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"UPDATE Class 
                                SET className = @className, 
                                    description = @description 
                                WHERE classID = @classID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@className", className);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@classID", classId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("MyClasses.aspx");
        }
    }
}