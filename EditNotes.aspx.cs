using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class EditNotes : System.Web.UI.Page
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

                if (Request.QueryString["materialID"] != null)
                {
                    int materialId = Convert.ToInt32(Request.QueryString["materialID"]);
                    LoadMaterialData(materialId);
                }
                else
                {
                    Response.Redirect("ManageNotes.aspx");
                }
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

        private void LoadMaterialData(int materialId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT title, chapter, classID, fileURL, status FROM Material WHERE materialID = @materialID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@materialID", materialId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtTitle.Text = reader["title"] != DBNull.Value ? reader["title"].ToString() : "";
                        txtChapter.Text = reader["chapter"] != DBNull.Value ? reader["chapter"].ToString() : "";

                        string classId = reader["classID"] != DBNull.Value ? reader["classID"].ToString() : "";
                        if (ddlClassroom.Items.FindByValue(classId) != null)
                        {
                            ddlClassroom.SelectedValue = classId;
                        }

                        string fileUrl = reader["fileURL"] != DBNull.Value ? reader["fileURL"].ToString() : "";
                        lblCurrentFile.Text = !string.IsNullOrEmpty(fileUrl) ? Path.GetFileName(fileUrl) : "None";

                        string status = reader["status"] != DBNull.Value ? reader["status"].ToString() : "Published";
                        if (ddlStatus.Items.FindByValue(status) != null)
                        {
                            ddlStatus.SelectedValue = status;
                        }
                    }
                }
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["materialID"] == null) return;

            int materialId = Convert.ToInt32(Request.QueryString["materialID"]);
            string title = txtTitle.Text.Trim();
            string chapter = txtChapter.Text.Trim();

            if (string.IsNullOrEmpty(title))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertTitle", "alert('Please enter a note title.');", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlClassroom.SelectedValue))
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alertClass", "alert('Please select a classroom.');", true);
                return;
            }

            int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
            string status = ddlStatus.SelectedValue;

            string fileUrl = null;
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
                string query = @"UPDATE Material 
                                SET title = @title, 
                                    chapter = @chapter, 
                                    classID = @classID, 
                                    status = @status" +
                                (fileUrl != null ? ", fileURL = @fileURL" : "") +
                                " WHERE materialID = @materialID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@chapter", chapter);
                    cmd.Parameters.AddWithValue("@classID", classId);
                    cmd.Parameters.AddWithValue("@status", status);
                    cmd.Parameters.AddWithValue("@materialID", materialId);

                    if (fileUrl != null)
                    {
                        cmd.Parameters.AddWithValue("@fileURL", fileUrl);
                    }

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