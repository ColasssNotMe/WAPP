using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentQuizList : System.Web.UI.Page
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
                //if (Session["role"]?.ToString() != "student")
                //{
                //    Response.Redirect("Homepage");
                //}
                LoadAvailableQuizzes();
                LoadCompletedQuizzes();
            }
        }

        private void LoadAvailableQuizzes()
        {
            if (Session["classID"] == null)
            {
                availableEmptyPanel.Visible = true;
                return;
            }

            if (Session["userID"] == null)
            {
                availableEmptyPanel.Visible = true;
                return;
            }


            string classID = Session["classID"].ToString();
            string userID = Session["userID"].ToString();


            string query = @"
                SELECT
                    q.quizID AS QuizID,
                    q.title AS Title,
                    q.totalMarks AS TotalMarks,
                    COUNT(DISTINCT qu.questionID) AS QuestionCount
                FROM Quiz q
                LEFT JOIN Question qu
                    ON q.quizID = qu.quizID
                INNER JOIN Student s
                    ON s.userID = @userID
                WHERE q.classID = @classID
                    AND NOT EXISTS
                    (
                        SELECT 1
                        FROM Result r
                        WHERE r.quizID = q.quizID
                          AND r.studentID = s.studentID
                    )
                GROUP BY
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    q.createdDate
                ORDER BY
                    q.createdDate DESC;
            ";


            DataTable dt = new DataTable();


            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@classID", classID);
                    cmd.Parameters.AddWithValue("@userID", userID);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                }


                dt.Columns.Add("Description", typeof(string));

                foreach (DataRow row in dt.Rows)
                {
                    row["Description"] = "Complete this quiz to test your knowledge.";
                }


                availableQuizRepeater.DataSource = dt;
                availableQuizRepeater.DataBind();


                availableEmptyPanel.Visible = dt.Rows.Count == 0;
            }
        }


        private void LoadCompletedQuizzes()
        {
            if (Session["userID"] == null)
            {
                completedEmptyPanel.Visible = true;
                return;
            }


            string userID = Session["userID"].ToString();


            string query = @"
                SELECT
                    q.quizID AS QuizID,
                    q.title AS Title,
                    q.totalMarks AS TotalMarks,

                    COUNT(DISTINCT qu.questionID) AS QuestionCount,

                    r.score AS Score,
                    r.timeTaken AS TimeTaken

                FROM Result r

                INNER JOIN Student s
                    ON r.studentID = s.studentID

                INNER JOIN Quiz q
                    ON r.quizID = q.quizID

                LEFT JOIN Question qu
                    ON q.quizID = qu.quizID

                WHERE s.userID = @userID

                GROUP BY
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    r.score,
                    r.timeTaken,
                    r.resultID

                ORDER BY
                    r.resultID DESC;
            ";


            DataTable dt = new DataTable();



            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@userID", userID);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    dt.Load(reader);
                }
            }


            dt.Columns.Add("ScoreText", typeof(string));
            dt.Columns.Add("ScorePercentage", typeof(double));
            dt.Columns.Add("TimeTakenText", typeof(string));


            foreach (DataRow row in dt.Rows)
            {
                decimal score = Convert.ToDecimal(row["Score"]);
                decimal totalMarks = Convert.ToDecimal(row["TotalMarks"]);

                double percentage = 0;

                if (totalMarks > 0)
                {
                    percentage =
                        (double)(score / totalMarks) * 100;
                }


                row["ScoreText"] =
                    score + " / " + totalMarks;


                row["ScorePercentage"] =
                    Math.Min(100, Math.Max(0, percentage));


                if (row["TimeTaken"] == DBNull.Value)
                {
                    row["TimeTakenText"] = "Not recorded";
                }
                else
                {
                    int seconds =
                        Convert.ToInt32(row["TimeTaken"]);

                    TimeSpan time =
                        TimeSpan.FromSeconds(seconds);

                    if (time.Hours > 0)
                    {
                        row["TimeTakenText"] =
                            string.Format(
                                "{0}h {1}m",
                                (int)time.TotalHours,
                                time.Minutes);
                    }
                    else if (time.Minutes > 0)
                    {
                        row["TimeTakenText"] =
                            string.Format(
                                "{0}m {1}s",
                                time.Minutes,
                                time.Seconds);
                    }
                    else
                    {
                        row["TimeTakenText"] =
                            time.Seconds + "s";
                    }
                }
            }


            completedQuizRepeater.DataSource = dt;
            completedQuizRepeater.DataBind();


            completedEmptyPanel.Visible =
                dt.Rows.Count == 0;
        }



        protected void AvailableQuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "StartQuiz")
            {
                Session["quizID"] =
                    e.CommandArgument.ToString();

                Response.Redirect("StudentQuiz.aspx");
            }
        }



        protected void CompletedQuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewResult")
            {
                Session["quizID"] =
                    e.CommandArgument.ToString();

                Response.Redirect("QuizResult.aspx");
            }
        }
    }
}