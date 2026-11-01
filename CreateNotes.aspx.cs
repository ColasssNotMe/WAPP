using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
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
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadClassrooms();
            }
        }

        private void LoadClassrooms()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT classID, className FROM Class ORDER BY className ASC";
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
            string title = txtTitle.Text.Trim();

            // 1. Validate Note Title
            if (string.IsNullOrEmpty(title))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertTitle", "alert('Please enter a note title before saving.');", true);
                return;
            }

            // 2. Validate Classroom Selection
            if (string.IsNullOrEmpty(ddlClassroom.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertClassroom", "alert('Please select a classroom before saving the note.');", true);
                return;
            }

            int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
            int durationMins = string.IsNullOrEmpty(txtDurationMins.Text.Trim()) ? 15 : Convert.ToInt32(txtDurationMins.Text.Trim());
            string status = ddlStatus.SelectedValue;
            string fileUrl = "";

            // Handle PDF File Upload
            if (fileUploadPdf.HasFile)
            {
                string extension = Path.GetExtension(fileUploadPdf.FileName).ToLower();
                if (extension == ".pdf")
                {
                    string uploadsDir = Server.MapPath("~/Uploads/");
                    if (!Directory.Exists(uploadsDir))
                    {
                        Directory.CreateDirectory(uploadsDir);
                    }

                    string uniqueFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileUploadPdf.FileName);
                    string savePath = Path.Combine(uploadsDir, uniqueFileName);
                    fileUploadPdf.SaveAs(savePath);
                    fileUrl = "~/Uploads/" + uniqueFileName;
                }
            }

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

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManageNotes.aspx");
        }
    }
}