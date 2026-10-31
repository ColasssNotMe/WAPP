using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminMaterialManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                loadClasses();
                setDefaultMaterial();
                loadMaterials();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loadMaterials();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlClass.SelectedValue = "";
            loadMaterials();
        }

        protected void MaterialRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectMaterial")
            {
                ViewState["MaterialID"] = Convert.ToInt32(e.CommandArgument);
                loadMaterials();
            }
        }

        protected void btnToggle_Click(object sender, EventArgs e)
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "UPDATE Material SET status = CASE WHEN status = 'Published' THEN 'Draft' ELSE 'Published' END WHERE materialID = @materialID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@materialID", ViewState["MaterialID"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            loadMaterials();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (ViewState["MaterialID"] == null) return;

            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    // Delete dependent comments first to preserve foreign key constraints
                    string deleteCommentsQuery = "DELETE FROM Comment WHERE materialID = @materialID";
                    using (SqlCommand cmd1 = new SqlCommand(deleteCommentsQuery, conn, transaction))
                    {
                        cmd1.Parameters.AddWithValue("@materialID", ViewState["MaterialID"]);
                        cmd1.ExecuteNonQuery();
                    }

                    string deleteMaterialQuery = "DELETE FROM Material WHERE materialID = @materialID";
                    using (SqlCommand cmd2 = new SqlCommand(deleteMaterialQuery, conn, transaction))
                    {
                        cmd2.Parameters.AddWithValue("@materialID", ViewState["MaterialID"]);
                        cmd2.ExecuteNonQuery();
                    }

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    throw;
                }
            }

            ViewState["MaterialID"] = null;
            setDefaultMaterial();
            loadMaterials();
        }

        private void loadClasses()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT classID, className FROM Class ORDER BY className", conn);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "className";
                ddlClass.DataValueField = "classID";
                ddlClass.DataBind();

                ddlClass.Items.Insert(0, new ListItem("Class: All", ""));
            }
        }

        private void loadMaterials()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "SELECT m.materialID, m.title, m.uploadDate, m.status, " +
                           "c.className, (u.firstName + ' ' + u.lastName) AS teacherName " +
                           "FROM Material m " +
                           "LEFT JOIN Class c ON c.classID = m.classID " +
                           "LEFT JOIN Teacher t ON t.teacherID = c.teacherID " +
                           "LEFT JOIN [User] u ON u.userID = t.userID " +
                           "WHERE 1 = 1";

            string search = txtSearch.Text.Trim();
            string classID = ddlClass.SelectedValue;

            if (classID != "")
            {
                query += " AND m.classID = @classID";
            }

            if (search != "")
            {
                query += " AND m.title LIKE @search";
            }

            query += " ORDER BY m.uploadDate DESC, m.materialID DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (classID != "")
                {
                    cmd.Parameters.AddWithValue("@classID", classID);
                }

                if (search != "")
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                MaterialRepeater.DataSource = dt;
                MaterialRepeater.DataBind();

                lblShowing.Text = dt.Rows.Count.ToString();

                emptyMessage.Visible = dt.Rows.Count == 0;
            }

            loadCounts();
            loadDetails();
        }

        private void loadCounts()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand totalCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Material", conn);

                lblTotalMaterials.Text = totalCmd.ExecuteScalar().ToString();
                lblPill.Text = lblTotalMaterials.Text;
                lblTotal.Text = lblTotalMaterials.Text;

                SqlCommand publishedCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Material WHERE status = 'Published'", conn);

                lblPublishedCount.Text = publishedCmd.ExecuteScalar().ToString();

                SqlCommand draftCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Material WHERE status = 'Draft'", conn);

                lblDraftCount.Text = draftCmd.ExecuteScalar().ToString();
            }
        }

        private void setDefaultMaterial()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT TOP 1 materialID FROM Material ORDER BY uploadDate DESC, materialID DESC", conn);

                conn.Open();

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    ViewState["MaterialID"] = Convert.ToInt32(result);
                }
            }
        }

        private void loadDetails()
        {
            if (ViewState["MaterialID"] == null)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "SELECT m.title, m.fileURL, m.durationMins, m.uploadDate, m.status, " +
                           "c.className, (u.firstName + ' ' + u.lastName) AS teacherName, " +
                           "(SELECT COUNT(*) FROM Comment WHERE Comment.materialID = m.materialID) AS commentCount " +
                           "FROM Material m " +
                           "LEFT JOIN Class c ON c.classID = m.classID " +
                           "LEFT JOIN Teacher t ON t.teacherID = c.teacherID " +
                           "LEFT JOIN [User] u ON u.userID = t.userID " +
                           "WHERE m.materialID = @materialID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@materialID", ViewState["MaterialID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlDetails.Visible = false;
                    pnlNoSelection.Visible = true;
                    return;
                }

                pnlDetails.Visible = true;
                pnlNoSelection.Visible = false;

                DataRow row = dt.Rows[0];

                lblDetTitle.Text = GetText(row["title"]);
                lblDetTeacher.Text = GetText(row["teacherName"]);
                lblDetClass.Text = GetText(row["className"]);
                lblDetDate.Text = GetDate(row["uploadDate"]);
                lblDetComments.Text = row["commentCount"].ToString();

                if (Convert.ToString(row["durationMins"]) == "")
                {
                    lblDetDuration.Text = "—";
                }
                else
                {
                    lblDetDuration.Text = row["durationMins"] + " mins";
                }

                string status = Convert.ToString(row["status"]);

                lblDetStatus.Text = GetText(status);

                if (status == "Published")
                {
                    lblDetStatus.CssClass = "status--published";
                    btnToggle.Text = "Unpublish";
                }
                else
                {
                    lblDetStatus.CssClass = "status--draft";
                    btnToggle.Text = "Publish";
                }

                string fileURL = Convert.ToString(row["fileURL"]);

                hlView.NavigateUrl = fileURL;
                hlView.Visible = fileURL != "";
            }
        }

        protected string GetStatusClass(object status)
        {
            string value = Convert.ToString(status);

            if (value == "Published")
            {
                return "status status--published";
            }
            else
            {
                return "status status--draft";
            }
        }

        protected string GetText(object value)
        {
            string text = Convert.ToString(value);

            if (text.Trim() == "")
            {
                return "—";
            }

            return text;
        }

        protected string GetDate(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return "—";
            }

            return Convert.ToDateTime(value).ToString("dd MMM yyyy");
        }

        protected string GetSelected(object materialID)
        {
            if (Convert.ToString(materialID) == Convert.ToString(ViewState["MaterialID"]))
            {
                return "true";
            }

            return "false";
        }
    }
}