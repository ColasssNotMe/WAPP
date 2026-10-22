using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["quizID"] == null)
            {
                Response.Redirect("StudentQuizList.aspx");
                return;
            }

            if (!IsPostBack)
            {
                Session["currentQuestionIndex"] = 0;
            }

            LoadQuestions();


        }

        private void LoadQuestions()
        {
            string quizID = Session["quizID"].ToString();

            string query = @"
                SELECT 
                    q.questionID,
                    q.quizID,
                    q.answerID,
                    q.questionText,
                    q.questionType,
                    q.marks,
                    qz.title,
                    qz.totalMarks
                FROM Question q
                INNER JOIN Quiz qz
                    ON q.quizID = qz.quizID
                WHERE q.quizID = @quizID
                ORDER BY q.questionID";


            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@quizID", quizID);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }


            if (dt.Rows.Count == 0)
            {
                quizTitle.InnerText = "Quiz not available";
                questionNumber.InnerText = "No questions";
                questionTitle.InnerText = "No questions were found.";
                questionMark.InnerText = "0 marks";

                PreviousButton.Enabled = false;
                NextButton.Enabled = false;

                return;
            }


            int currentIndex = Convert.ToInt32(
                Session["currentQuestionIndex"]);


            if (currentIndex < 0)
            {
                currentIndex = 0;
                Session["currentQuestionIndex"] = 0;
            }

            if (currentIndex >= dt.Rows.Count)
            {
                currentIndex = dt.Rows.Count - 1;
                Session["currentQuestionIndex"] = currentIndex;
            }


            DataRow question = dt.Rows[currentIndex];

            quizTitle.InnerText =
                question["title"].ToString();
            questionNumber.InnerText = "Question " + (currentIndex + 1) + " of " + dt.Rows.Count;
            questionTitle.InnerText = question["questionText"].ToString();
            questionMark.InnerText = question["marks"].ToString() + " mark";
            currentQuestionLegend.InnerText = (currentIndex + 1).ToString();

            QuestionNavigatorRepeater.DataSource = dt;
            QuestionNavigatorRepeater.DataBind();


            PreviousButton.Enabled =
                currentIndex > 0;
            NextButton.Enabled =
                currentIndex < dt.Rows.Count - 1;

            int percentage =
                (int)(((currentIndex + 1) /
                (double)dt.Rows.Count) * 100);

            answeredText.InnerText =
                (currentIndex + 1) +
                " of " +
                dt.Rows.Count +
                " questions";

            progressPercentage.InnerText =
                percentage + "%";

            progressValue.Style["width"] =
                percentage + "%";

            remainingText.InnerText =
                (dt.Rows.Count - 1 - currentIndex) +
                " questions are still unanswered.";
        }



        protected void PreviousButton_Click(object sender, EventArgs e)
        {
            int currentIndex =
                Convert.ToInt32(
                    Session["currentQuestionIndex"]);

            if (currentIndex > 0)
            {
                Session["currentQuestionIndex"] =
                    currentIndex - 1;
            }

            LoadQuestions();
        }



        protected void QuestionNavigatorRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoToQuestion")
            {
                int selectedIndex =
                    Convert.ToInt32(e.CommandArgument);

                Session["currentQuestionIndex"] =
                    selectedIndex;

                LoadQuestions();
            }
        }

        protected string GetQuestionButtonClass(int index)
        {
            int currentIndex =
                Convert.ToInt32(
                    Session["currentQuestionIndex"]);

            if (index == currentIndex)
            {
                return "nav-question current";
            }

            return "nav-question";
        }


        protected void NextButton_Click(object sender, EventArgs e)
        {
            int currentIndex =
                Convert.ToInt32(
                    Session["currentQuestionIndex"]);

            Session["currentQuestionIndex"] =
                    currentIndex + 1;

            LoadQuestions();
        }



    }
}