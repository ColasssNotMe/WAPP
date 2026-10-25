using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CreateNotes : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClassrooms();
            }
        }

        private void LoadClassrooms()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT classID, className FROM Class";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    ddlClassroom.DataSource = cmd.ExecuteReader();
                    ddlClassroom.DataTextField = "className";
                    ddlClassroom.DataValueField = "classID";
                    ddlClassroom.DataBind();
                }
            }

            ddlClassroom.Items.Insert(0, new ListItem("-- Select Classroom --", ""));
        }

        protected void btnSubmitNote_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlClassroom.SelectedValue))
            {
                return;
            }

            string title = txtTitle.Text.Trim();
            int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
            string fileUrl = txtFileURL.Text.Trim();
            int durationMins = string.IsNullOrEmpty(txtDurationMins.Text.Trim()) ? 15 : Convert.ToInt32(txtDurationMins.Text.Trim());
            string status = ddlStatus.SelectedValue;

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"INSERT INTO Material (classID, title, fileURL, durationMins, uploadDate, status, contentType) 
                        VALUES (@classID, @title, @fileURL, @durationMins, GETDATE(), @status, 'Note')";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classId);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@fileURL", fileUrl);
                    cmd.Parameters.AddWithValue("@durationMins", durationMins);
                    cmd.Parameters.AddWithValue("@status", status);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Response.Redirect("ManageNotes.aspx");
        }
    }
}