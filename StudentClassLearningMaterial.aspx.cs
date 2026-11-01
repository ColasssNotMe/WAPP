
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentClassLearningMaterial : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            int ClassID = int.Parse(Session["classID"].ToString());

            if (Session["userId"] == null)
            {
                Response.Redirect("Homepage");
                return;
            }

            if (ClassID == 0)
            {
                Response.Redirect("StudentDashboard.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (!LoadClassName())
                {
                    return;
                }
            }

            LoadMaterials();
        }

        private bool LoadClassName()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
        SELECT c.className
        FROM Class c
        WHERE c.classID = @ClassID
        AND EXISTS
        (
            SELECT 1
            FROM Enrolment e
            INNER JOIN Student s
                ON e.studentID = s.studentID
            WHERE
                e.classID = c.classID
                AND s.userID = @UserID
        )";

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@ClassID", int.Parse(Session["classID"].ToString()));

                cmd.Parameters.AddWithValue("@UserID", Session["userID"].ToString());

                con.Open();

                object result = cmd.ExecuteScalar();

                if (result == null || result == DBNull.Value)
                {
                    Response.Redirect("StudentDashboard.aspx");
                    return false;
                }

                litClassName.Text = Server.HtmlEncode(result.ToString());

                return true;
            }
        }
        private void LoadMaterials()
        {
            string search = txtSearch.Text.Trim();

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
        SELECT
            m.materialID,
            m.chapter,
            m.title,
            m.durationMins
        FROM Material m
        WHERE
            m.classID = @ClassID
            AND EXISTS
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
                cmd.Parameters.AddWithValue("@ClassID", int.Parse(Session["classID"].ToString()));

                cmd.Parameters.AddWithValue("@UserID", Session["userID"].ToString());

                cmd.Parameters.AddWithValue("@Search",
                    "%" + search + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();

                    da.Fill(dt);

                    rptMaterials.DataSource = dt;
                    rptMaterials.DataBind();

                    pnlNoMaterials.Visible = dt.Rows.Count == 0;
                }
            }
        }
        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            LoadMaterials();
        }

        protected void rptMaterials_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenMaterial")
            {
                int materialId;

                if (int.TryParse(
                    Convert.ToString(e.CommandArgument),
                    out materialId))
                {
                    Session["materialId"] = materialId.ToString();
                    Response.Redirect("NotePage.aspx");
                }
            }
        }
    }
}
