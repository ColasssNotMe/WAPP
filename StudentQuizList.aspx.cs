using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentQuizList : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userID"] == null && Session["userId"] == null)
                {
                    Response.Redirect("Homepage");
                    return;
                }
                if (Session["role"]?.ToString().ToLower() != "student")
                {
                    Response.Redirect("Homepage");
                }
                LoadAvailableQuizzes();
                LoadCompletedQuizzes();
            }
        }

        private void LoadAvailableQuizzes()
        {
            object currentUserId = Session["userID"] ?? Session["userId"];
            if (currentUserId == null)
            {
                availableEmptyPanel.Visible = true;
                return;
            }

            string userID = currentUserId.ToString();

            string query = @"
        SELECT
            q.quizID AS QuizID,
            q.title AS Title,
            q.totalMarks AS TotalMarks,
            COUNT(DISTINCT qu.questionID) AS QuestionCount

        FROM Student s

        INNER JOIN Enrolment e
            ON s.studentID = e.studentID

        INNER JOIN Quiz q
            ON e.classID = q.classID

        LEFT JOIN Question qu
            ON q.quizID = qu.quizID

        WHERE s.userID = @userID
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

        ORDER BY q.createdDate DESC;
    ";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", userID);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
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
        private void LoadCompletedQuizzes()
        {
            object currentUserId = Session["userID"] ?? Session["userId"];
            if (currentUserId == null)
            {
                completedEmptyPanel.Visible = true;
                return;
            }

            string userID = currentUserId.ToString();


            string query = @"
                SELECT
                    q.quizID AS QuizID,
                    q.title AS Title,
                    q.totalMarks AS TotalMarks,

                    COUNT(DISTINCT qu.questionID) AS QuestionCount,

                    r.score AS Score,
                    r.timeTaken AS TimeTaken,
                    r.resultID AS ResultID

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
                int quizID;

                if (int.TryParse(
                          Convert.ToString(e.CommandArgument),
                          out quizID))
                {
                    Session["quizID"] = quizID.ToString();
                    Response.Redirect("QuizAttempt.aspx");
                }
            }
        }




        protected void CompletedQuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewResult")
            {
                int resultId;

                if (int.TryParse(Convert.ToString(e.CommandArgument), out resultId))
                {
                    LoadQuizResult(resultId);
                }
            }
        }

        protected void ResultsRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Repeater optionsRepeater =
                    e.Item.FindControl("ResultOptionsRepeater") as Repeater;

                if (optionsRepeater != null)
                {
                    object options = DataBinder.Eval(e.Item.DataItem, "Options");
                    optionsRepeater.DataSource = options;
                    optionsRepeater.DataBind();
                }
            }
        }

        private void LoadQuizResult(int resultId)
        {
            object sessionUserId = Session["userID"] ?? Session["userId"];
            if (sessionUserId == null)
            {
                ResultsModal.Visible = false;
                return;
            }

            string userId = sessionUserId.ToString();
            string resultQuery = @"
                SELECT q.quizID, q.title, q.totalMarks, r.score, r.timeTaken
                FROM Result r
                INNER JOIN Student s ON r.studentID = s.studentID
                INNER JOIN Quiz q ON r.quizID = q.quizID
                WHERE r.resultID = @ResultID
                    AND s.userID = @UserID";

            DataTable resultTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(resultQuery, conn))
            {
                cmd.Parameters.AddWithValue("@ResultID", resultId);
                cmd.Parameters.AddWithValue("@UserID", userId);

                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(resultTable);
                }
            }

            // Only show a result that belongs to the signed-in student.
            if (resultTable.Rows.Count == 0)
            {
                ResultsModal.Visible = false;
                return;
            }

            DataRow result = resultTable.Rows[0];
            int quizId = Convert.ToInt32(result["quizID"]);
            decimal score = Convert.ToDecimal(result["score"]);
            decimal totalMarks = Convert.ToDecimal(result["totalMarks"]);
            string timeText = result["timeTaken"] == DBNull.Value
                ? "Not recorded"
                : FormatDuration(Convert.ToInt32(result["timeTaken"]));

            ResultsSummary.Text = string.Format(
                "You scored <strong>{0}</strong> out of <strong>{1}</strong> marks. Time taken: <strong>{2}</strong>.",
                Server.HtmlEncode(score.ToString()),
                Server.HtmlEncode(totalMarks.ToString()),
                Server.HtmlEncode(timeText));

            DataTable questions = new DataTable();
            string questionQuery = @"
                SELECT questionID, questionText
                FROM Question
                WHERE quizID = @QuizID
                ORDER BY questionID";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(questionQuery, conn))
            {
                cmd.Parameters.AddWithValue("@QuizID", quizId);
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(questions);
                }
            }

            var reviewQuestions =
                new System.Collections.Generic.List<StudentQuizReviewQuestion>();

            foreach (DataRow question in questions.Rows)
            {
                int questionId = Convert.ToInt32(question["questionID"]);
                DataTable options = new DataTable();

                string optionQuery = @"
                    SELECT answerID, answerText, isCorrect, questionID
                    FROM Answer
                    WHERE questionID = @QuestionID
                    ORDER BY answerID";

                using (SqlConnection conn = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(optionQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@QuestionID", questionId);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(options);
                    }
                }

                var reviewOptions =
                    new System.Collections.Generic.List<StudentQuizReviewOption>();

                foreach (DataRow option in options.Rows)
                {
                    bool isCorrect =
                        Convert.ToInt32(option["isCorrect"]) == 1;

                    reviewOptions.Add(new StudentQuizReviewOption
                    {
                        AnswerText = Convert.ToString(option["answerText"]).Trim(),
                        CssClass = isCorrect
                            ? "result-option correct"
                            : "result-option",
                        Tag = isCorrect ? "Correct answer" : string.Empty
                    });
                }

                reviewQuestions.Add(new StudentQuizReviewQuestion
                {
                    QuestionText = Convert.ToString(question["questionText"]),
                    StatusText = "Answer key",
                    StatusClass = "unanswered",
                    Options = reviewOptions
                });
            }

            ResultsRepeater.DataSource = reviewQuestions;
            ResultsRepeater.DataBind();
            ResultsModal.Visible = true;
        }

        private static string FormatDuration(int seconds)
        {
            TimeSpan time = TimeSpan.FromSeconds(seconds);

            if (time.TotalHours >= 1)
                return string.Format("{0}h {1}m",
                    (int)time.TotalHours, time.Minutes);

            if (time.TotalMinutes >= 1)
                return string.Format("{0}m {1}s",
                    time.Minutes, time.Seconds);

            return time.Seconds + "s";
        }

        protected void CloseResultsButton_Click(object sender, EventArgs e)
        {
            ResultsModal.Visible = false;
        }
    }

    public class StudentQuizReviewOption
    {
        public string AnswerText { get; set; }
        public string CssClass { get; set; }
        public string Tag { get; set; }
    }

    public class StudentQuizReviewQuestion
    {
        public string QuestionText { get; set; }
        public string StatusText { get; set; }
        public string StatusClass { get; set; }
        public System.Collections.Generic.List<StudentQuizReviewOption> Options { get; set; }
    }
}
