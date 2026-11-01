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
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Homepage");
                    return;
                }
                if (Session["role"]?.ToString().ToLower() != "student")
                {
                    Response.Redirect("Homepage");
                }
            }
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
        WHERE
            EXISTS
            (
                SELECT 1
                FROM Enrolment e
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE
                    e.classID = m.classID
                    AND s.userID = @UserID
            )
            AND
            (
                m.title LIKE @Search
                OR CAST(m.chapter AS VARCHAR(20)) LIKE @Search
            )
        ORDER BY m.chapter ASC, m.materialID ASC";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.VarChar, 255).Value =
                    Session["userID"].ToString();

                cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 255).Value =
                    "%" + search + "%";

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptMaterials.DataSource = dt;
                    rptMaterials.DataBind();
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