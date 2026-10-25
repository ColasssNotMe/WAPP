using System;
using System.Configuration;
using System.Data.SqlClient;
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
                string query = "SELECT title, chapter, classID, fileURL FROM Material WHERE materialID = @materialID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@materialID", materialId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtTitle.Text = reader["title"].ToString();
                        txtChapter.Text = reader["chapter"].ToString();
                        ddlClassroom.SelectedValue = reader["classID"].ToString();
                        txtFileURL.Text = reader["fileURL"].ToString();
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
                string chapter = txtChapter.Text.Trim();
                int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
                string fileUrl = txtFileURL.Text.Trim();

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    string query = @"UPDATE Material 
                                    SET title = @title, chapter = @chapter, classID = @classID, fileURL = @fileURL 
                                    WHERE materialID = @materialID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@chapter", chapter);
                        cmd.Parameters.AddWithValue("@classID", classId);
                        cmd.Parameters.AddWithValue("@fileURL", fileUrl);
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