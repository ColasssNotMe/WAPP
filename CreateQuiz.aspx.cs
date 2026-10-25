using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CreateQuiz : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadClassrooms();
            }
        }

        private void LoadClassrooms()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
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

        protected void btnSubmitQuiz_Click(object sender, EventArgs e)
        {
            string title = txtQuizTitle.Text.Trim();
            int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
            int totalMarks = Convert.ToInt32(txtTotalMarks.Text.Trim());

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Quiz (classID, title, totalMarks, createdDate) 
                                VALUES (@classID, @title, @totalMarks, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classId);
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@totalMarks", totalMarks);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Redirect back to ManageQuiz so the newly inserted quiz appears
            Response.Redirect("ManageQuiz.aspx");
        }
    }
}