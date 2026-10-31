using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminViewQuiz : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                string quizIDStr = Request.QueryString["quizID"];
                int quizID;

                if (int.TryParse(quizIDStr, out quizID))
                {
                    LoadQuizInfo(quizID);
                    LoadQuestions(quizID);
                }
                else
                {
                    ShowError("Invalid or missing Quiz ID.");
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            string source = Request.QueryString["source"];

            if (source == "quiz")
            {
                Response.Redirect("AdminQuizManagement.aspx");
            }
            else
            {
                Response.Redirect("AdminClassroomManagement.aspx");
            }
        }

        private void LoadQuizInfo(int quizID)
        {
            string sql = @"
                SELECT q.title, q.totalMarks, q.createdDate, c.className
                FROM Quiz q
                LEFT JOIN [Class] c ON c.classID = q.classID
                WHERE q.quizID = @QuizID";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@QuizID", quizID);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        lblQuizTitle.Text = reader["title"] != DBNull.Value ? reader["title"].ToString() : "Untitled Quiz";
                        lblClassName.Text = reader["className"] != DBNull.Value ? reader["className"].ToString() : "N/A";
                        lblTotalMarks.Text = reader["totalMarks"] != DBNull.Value ? reader["totalMarks"].ToString() : "0";
                        lblCreatedDate.Text = reader["createdDate"] != DBNull.Value
                            ? Convert.ToDateTime(reader["createdDate"]).ToString("dd MMM yyyy")
                            : "N/A";

                        pnlQuiz.Visible = true;
                        pnlError.Visible = false;
                    }
                    else
                    {
                        ShowError("Quiz not found in the database.");
                    }
                }
            }
        }

        private void LoadQuestions(int quizID)
        {
            string sql = @"
                SELECT questionID, questionText, marks
                FROM Question
                WHERE quizID = @QuizID
                ORDER BY questionID";

            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@QuizID", quizID);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }

            rptQuestions.DataSource = dt;
            rptQuestions.DataBind();
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                int questionID = Convert.ToInt32(row["questionID"]);

                Repeater rptAnswers = (Repeater)e.Item.FindControl("rptAnswers");

                if (rptAnswers != null)
                {
                    // Let SQL compute the CSS class and the badge HTML directly!
                    string sql = @"
                        SELECT 
                            answerText,
                            CASE WHEN ISNULL(isCorrect, 0) = 1 
                                 THEN 'answer-item correct' 
                                 ELSE 'answer-item' 
                            END AS LiClass,
                            CASE WHEN ISNULL(isCorrect, 0) = 1 
                                 THEN '<span class=''badge-correct''>Correct Answer</span>' 
                                 ELSE '' 
                            END AS BadgeHtml
                        FROM Answer
                        WHERE questionID = @QuestionID
                        ORDER BY answerID";

                    DataTable dtAnswers = new DataTable();
                    using (SqlConnection conn = new SqlConnection(connString))
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@QuestionID", questionID);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtAnswers);
                        }
                    }

                    rptAnswers.DataSource = dtAnswers;
                    rptAnswers.DataBind();
                }
            }
        }

        private void ShowError(string message)
        {
            pnlQuiz.Visible = false;
            pnlError.Visible = true;
            lblError.Text = message;
        }
    }
}