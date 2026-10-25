using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ManageQuiz : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindQuizList();
            }
        }

        private void BindQuizList()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"SELECT q.quizID, q.title, q.totalMarks, c.className 
                                FROM Quiz q 
                                INNER JOIN Class c ON q.classID = c.classID 
                                ORDER BY q.createdDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        rptQuizzes.DataSource = dt;
                        rptQuizzes.DataBind();
                    }
                }
            }
        }

        protected void rptQuizzes_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectQuiz")
            {
                int quizId = Convert.ToInt32(e.CommandArgument);
                ViewState["SelectedQuizID"] = quizId;
                LoadQuizDetails(quizId);
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = @"SELECT q.quizID, q.title, q.totalMarks, q.createdDate, c.className 
                                FROM Quiz q 
                                INNER JOIN Class c ON q.classID = c.classID 
                                WHERE q.quizID = @quizID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@quizID", quizId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblDetailTitle.Text = reader["title"].ToString();
                        lblDetailClassroom.Text = reader["className"].ToString();
                        lblDetailMarks.Text = reader["totalMarks"].ToString();
                        lblDetailDate.Text = Convert.ToDateTime(reader["createdDate"]).ToString("yyyy-MM-dd");

                        pnlActions.Visible = true;
                    }
                }
            }
        }

        protected void btnCreateQuiz_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateQuiz.aspx");
        }

        protected void btnEditQuiz_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedQuizID"] != null)
            {
                int quizId = (int)ViewState["SelectedQuizID"];
                Response.Redirect("EditQuiz.aspx?quizID=" + quizId);
            }
        }

        protected void btnDeleteQuiz_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedQuizID"] != null)
            {
                int quizId = (int)ViewState["SelectedQuizID"];

                using (SqlConnection conn = new SqlConnection(GetConnectionString()))
                {
                    conn.Open();
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // 1. Delete linked records from Result table
                            string deleteResults = "DELETE FROM Result WHERE quizID = @quizID";
                            using (SqlCommand cmd = new SqlCommand(deleteResults, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@quizID", quizId);
                                cmd.ExecuteNonQuery();
                            }

                            // 2. Delete linked records from Question table
                            string deleteQuestions = "DELETE FROM Question WHERE quizID = @quizID";
                            using (SqlCommand cmd = new SqlCommand(deleteQuestions, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@quizID", quizId);
                                cmd.ExecuteNonQuery();
                            }

                            // 3. Delete record from Quiz table
                            string deleteQuiz = "DELETE FROM Quiz WHERE quizID = @quizID";
                            using (SqlCommand cmd = new SqlCommand(deleteQuiz, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@quizID", quizId);
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

                // Reset view state & UI details panel
                ViewState["SelectedQuizID"] = null;
                pnlActions.Visible = false;
                lblDetailTitle.Text = "Select a quiz";
                lblDetailClassroom.Text = "-";
                lblDetailMarks.Text = "-";
                lblDetailDate.Text = "-";

                // Refresh the quiz list
                BindQuizList();
            }
        }
    }
}