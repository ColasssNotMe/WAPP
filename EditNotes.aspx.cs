using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

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
        }

        private void LoadMaterialData(int materialId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT title, classID, fileURL, ISNULL(status, 'Published') AS status FROM Material WHERE materialID = @materialID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@materialID", materialId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtTitle.Text = reader["title"].ToString();
                        ddlClassroom.SelectedValue = reader["classID"].ToString();

                        string currentPath = reader["fileURL"].ToString();
                        ViewState["ExistingFileURL"] = currentPath;
                        lblCurrentFile.Text = string.IsNullOrEmpty(currentPath) ? "None" : Path.GetFileName(currentPath);

                        string currentStatus = reader["status"].ToString();
                        if (ddlStatus.Items.FindByValue(currentStatus) != null)
                        {
                            ddlStatus.SelectedValue = currentStatus;
                        }
                    }
                }
            }
        }

        protected void btnUpdateNote_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["materialID"] != null)
            {
                int materialId = Convert.ToInt32(Request.QueryString["materialID"]);
                string title = txtTitle.Text.Trim();
                int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
                string status = ddlStatus.SelectedValue;

                // Retain existing file URL unless a new file is uploaded
                string fileUrl = ViewState["ExistingFileURL"] != null ? ViewState["ExistingFileURL"].ToString() : "";

                if (fileUploadPdf.HasFile)
                {
                    string extension = Path.GetExtension(fileUploadPdf.FileName).ToLower();
                    if (extension == ".pdf")
                    {
                        string uniqueFileName = Guid.NewGuid().ToString() + "_" + Path.GetFileName(fileUploadPdf.FileName);
                        string savePath = Server.MapPath("~/Uploads/" + uniqueFileName);
                        fileUploadPdf.SaveAs(savePath);
                        fileUrl = "~/Uploads/" + uniqueFileName;
                    }
                }

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    string query = @"UPDATE Material 
                                    SET title = @title, classID = @classID, fileURL = @fileUrl, status = @status 
                                    WHERE materialID = @materialID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@classID", classId);
                        cmd.Parameters.AddWithValue("@fileUrl", fileUrl);
                        cmd.Parameters.AddWithValue("@status", status);
                        cmd.Parameters.AddWithValue("@materialID", materialId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("ManageNotes.aspx");
            }
        }
    }
}