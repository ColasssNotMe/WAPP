using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class EditQuiz : System.Web.UI.Page
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

                if (Request.QueryString["quizID"] != null)
                {
                    int quizId = Convert.ToInt32(Request.QueryString["quizID"]);
                    LoadQuizData(quizId);
                }
                else
                {
                    Response.Redirect("ManageQuiz.aspx");
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

        private void LoadQuizData(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT title, classID, totalMarks FROM Quiz WHERE quizID = @quizID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@quizID", quizId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtQuizTitle.Text = reader["title"].ToString();
                        ddlClassroom.SelectedValue = reader["classID"].ToString();
                        txtTotalMarks.Text = reader["totalMarks"].ToString();
                    }
                }
            }
        }

        protected void btnUpdateQuiz_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["quizID"] != null)
            {
                int quizId = Convert.ToInt32(Request.QueryString["quizID"]);
                string title = txtQuizTitle.Text.Trim();
                int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
                int totalMarks = Convert.ToInt32(txtTotalMarks.Text.Trim());

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    string query = @"UPDATE Quiz 
                                    SET title = @title, classID = @classID, totalMarks = @totalMarks 
                                    WHERE quizID = @quizID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@classID", classId);
                        cmd.Parameters.AddWithValue("@totalMarks", totalMarks);
                        cmd.Parameters.AddWithValue("@quizID", quizId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                Response.Redirect("ManageQuiz.aspx");
            }
        }
    }
}