using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ManageNotes : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotesList();
            }
        }

        private void BindNotesList()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"SELECT m.materialID, m.title, m.chapter, ISNULL(m.status, 'Published') AS status, c.className 
                                FROM Material m 
                                INNER JOIN Class c ON m.classID = c.classID 
                                ORDER BY m.uploadDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptNotes.DataSource = dt;
                        rptNotes.DataBind();
                    }
                }
            }
        }

        protected void rptNotes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectNote")
            {
                int materialId = Convert.ToInt32(e.CommandArgument);
                ViewState["SelectedMaterialID"] = materialId;
                LoadNoteDetails(materialId);
            }
        }

        private void LoadNoteDetails(int materialId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"SELECT m.materialID, m.title, m.chapter, m.uploadDate, ISNULL(m.status, 'Published') AS status, c.className 
                                FROM Material m 
                                INNER JOIN Class c ON m.classID = c.classID 
                                WHERE m.materialID = @materialID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@materialID", materialId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblDetailTitle.Text = reader["title"].ToString();
                        lblDetailChapter.Text = "Chapter " + reader["chapter"].ToString();
                        lblDetailClassroom.Text = reader["className"].ToString();
                        lblDetailDate.Text = Convert.ToDateTime(reader["uploadDate"]).ToString("yyyy-MM-dd");
                        lblDetailStatus.Text = reader["status"].ToString();

                        pnlActions.Visible = true;
                    }
                }
            }
        }

        protected void btnAddNote_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateNotes.aspx");
        }

        protected void btnEditNote_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedMaterialID"] != null)
            {
                int materialId = (int)ViewState["SelectedMaterialID"];
                Response.Redirect("EditNotes.aspx?materialID=" + materialId);
            }
        }

        protected void btnDeleteNote_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedMaterialID"] != null)
            {
                int materialId = (int)ViewState["SelectedMaterialID"];

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // 1. Delete associated comments referencing materialID
                            string deleteComments = "DELETE FROM Comment WHERE materialID = @materialID";
                            using (SqlCommand cmd = new SqlCommand(deleteComments, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@materialID", materialId);
                                cmd.ExecuteNonQuery();
                            }

                            // 2. Delete associated progress tracking entries (contentID)
                            string deleteProgress = "DELETE FROM Progress WHERE contentID = @materialID";
                            using (SqlCommand cmd = new SqlCommand(deleteProgress, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@materialID", materialId);
                                cmd.ExecuteNonQuery();
                            }

                            // 3. Delete material record
                            string deleteMaterial = "DELETE FROM Material WHERE materialID = @materialID";
                            using (SqlCommand cmd = new SqlCommand(deleteMaterial, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@materialID", materialId);
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

                // Reset selection UI
                ViewState["SelectedMaterialID"] = null;
                pnlActions.Visible = false;
                lblDetailTitle.Text = "Select a note";
                lblDetailChapter.Text = "-";
                lblDetailClassroom.Text = "-";
                lblDetailDate.Text = "-";
                lblDetailStatus.Text = "-";

                // Refresh library list
                BindNotesList();
            }
        }
    }
}