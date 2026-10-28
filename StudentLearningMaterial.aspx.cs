using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentLearningMaterial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadMaterials();

        }


        private void LoadMaterials()
        {
            string search = txtSearch.Text.Trim();

            string connectionString =
                ConfigurationManager
                    .ConnectionStrings["WAPP"]
                    .ConnectionString;

            string query = @"
                SELECT
                    m.materialID,
                    m.chapter,
                    m.title,
                    m.durationMins
                FROM Material m
                INNER JOIN Class c 
                    ON m.classID = c.classID
                WHERE
                    m.title LIKE @Search
                    OR CAST(m.chapter AS VARCHAR) LIKE @Search
                ORDER BY m.chapter ASC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Search", "%" + search + "%");

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();

                        da.Fill(dt);

                        rptMaterials.DataSource = dt;
                        rptMaterials.DataBind();
                    }
                }
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadMaterials();
        }

        protected void rptMaterials_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenMaterial")
            {
                int materialId;

                if (int.TryParse(e.CommandArgument.ToString(), out materialId))
                {
                    Session["materialId"] = materialId.ToString();
                    Response.Redirect("NotePage.aspx");
                }
            }
        }
    }
}