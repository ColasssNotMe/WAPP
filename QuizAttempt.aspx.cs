using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class QuizAttempt : System.Web.UI.Page
    {
        private Dictionary<int, int> Answers
        {
            get
            {
                Dictionary<int, int> answers = Session["QuizAnswers"] as Dictionary<int, int>;

                if (answers == null)
                {
                    answers = new Dictionary<int, int>();
                    Session["QuizAnswers"] = answers;
                }

                return answers;
            }
        }

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
                Session["QuizAnswers"] = new Dictionary<int, int>();
                Session["quizStartTime"] = DateTime.Now;
            }
            else
            {
                SaveCurrentAnswer();
            }

            int elapsedSeconds = GetTimeTakenSeconds();

            quizElapsedSeconds.Value = elapsedSeconds.ToString();
            timeSpentValue.InnerText = "⏱ " + FormatClock(elapsedSeconds);

            LoadQuizHeader();
            LoadQuestions();
        }

        private void LoadQuizHeader()
        {
            string quizID = Session["quizID"].ToString();

            string query = @"
                SELECT q.title, c.className
                FROM Quiz q
                INNER JOIN Class c
                    ON q.classID = c.classID
                WHERE q.quizID = @quizID";

            string quizTitleText = "Quiz not available";
            string className = "";

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@quizID", quizID);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            quizTitleText = Convert.ToString(reader["title"]).Trim();
                            className = Convert.ToString(reader["className"]).Trim();
                        }
                    }
                }
            }

            quizHeading.InnerText = quizTitleText;
            classroomNameLabel.InnerText = className;
            pageTitle.Text = quizTitleText;
        }

        private void LoadQuestions()
        {
            string quizID = Session["quizID"].ToString();

            string query = @"
                SELECT
                    q.questionID,
                    q.quizID,
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

            Session["QuizQuestions"] = dt;

            if (dt.Rows.Count == 0)
            {
                quizTitle.InnerText = "Quiz not available";
                questionNumber.InnerText = "No questions";
                questionTitle.InnerText = "No questions were found.";
                questionMark.InnerText = "0 marks";

                AnswerRepeater.DataSource = null;
                AnswerRepeater.DataBind();
                NoAnswersMessage.Visible = false;

                QuestionNavigatorRepeater.DataSource = null;
                QuestionNavigatorRepeater.DataBind();

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
            int questionID = Convert.ToInt32(question["questionID"]);

            Session["currentQuestionID"] = questionID;

            quizTitle.InnerText =
                question["title"].ToString();
            questionNumber.InnerText = "Question " + (currentIndex + 1) + " of " + dt.Rows.Count;
            questionTitle.InnerText = question["questionText"].ToString();

            int marks = Convert.ToInt32(question["marks"]);
            questionMark.InnerText = marks + (marks == 1 ? " mark" : " marks");
            currentQuestionLegend.InnerText = (currentIndex + 1).ToString();

            RenderAnswerOptions(questionID);

            QuestionNavigatorRepeater.DataSource = dt;
            QuestionNavigatorRepeater.DataBind();

            PreviousButton.Enabled =
                currentIndex > 0;
            NextButton.Enabled =
                currentIndex < dt.Rows.Count - 1;

            int answered = CountAnswered(dt);

            answeredText.InnerText =
                answered + " of " + dt.Rows.Count + " answered";

            int percentage = dt.Rows.Count == 0
                ? 0
                : (int)Math.Round(100.0 * answered / dt.Rows.Count);

            progressPercentage.InnerText =
                percentage + "%";

            progressValue.Style["width"] =
                percentage + "%";

            int remaining = dt.Rows.Count - answered;

            remainingText.InnerText =
                remaining + " question" + (remaining == 1 ? " is" : "s are") +
                " still unanswered. You can review them before submitting.";
        }

        private void RenderAnswerOptions(int questionID)
        {
            DataTable dt = LoadAnswerOptions(questionID);

            if (dt.Rows.Count == 0)
            {
                AnswerRepeater.DataSource = null;
                AnswerRepeater.DataBind();
                NoAnswersMessage.Visible = true;
                return;
            }

            NoAnswersMessage.Visible = false;
            AnswerRepeater.DataSource = dt;
            AnswerRepeater.DataBind();
        }

        private DataTable LoadAnswerOptions(int questionID)
        {
            string query = @"
                SELECT answerID, answerText, isCorrect, questionID
                FROM Answer
                WHERE questionID = @questionID
                ORDER BY answerID";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@questionID", questionID);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }

            return dt;
        }

        protected bool IsAnswerSelected(int questionID, int answerID)
        {
            int selectedAnswerID;

            return Answers.TryGetValue(questionID, out selectedAnswerID) &&
                   selectedAnswerID == answerID;
        }

        protected string GetCheckedAttribute(int questionID, int answerID)
        {
            return IsAnswerSelected(questionID, answerID)
                ? "checked=\"checked\""
                : string.Empty;
        }

        protected string GetAnswerLetter(int index)
        {
            return ((char)('A' + index)).ToString();
        }

        protected string GetAnswerText(object dataItem)
        {
            DataRowView row = dataItem as DataRowView;

            return row == null
                ? string.Empty
                : Convert.ToString(row["answerText"]).Trim();
        }

        private void SaveCurrentAnswer()
        {
            if (Session["currentQuestionID"] == null)
            {
                return;
            }

            int questionID = Convert.ToInt32(Session["currentQuestionID"]);
            string value = Request.Form["answer_" + questionID];

            int answerID;

            if (int.TryParse(value, out answerID))
            {
                Answers[questionID] = answerID;
            }
        }


        protected void CloseResult(object sender, EventArgs e)
        {
            Session["quizID"] = "";
            Response.Redirect("StudentClassQuizList");
        }

        private int CountAnswered(DataTable questions)
        {
            int count = 0;

            foreach (DataRow row in questions.Rows)
            {
                int questionID = Convert.ToInt32(row["questionID"]);

                if (Answers.ContainsKey(questionID))
                {
                    count++;
                }
            }

            return count;
        }

        protected void PreviousButton_Click(object sender, EventArgs e)
        {
            int currentIndex = Convert.ToInt32(Session["currentQuestionIndex"]);

            if (currentIndex > 0)
            {
                Session["currentQuestionIndex"] = currentIndex - 1;
            }

            LoadQuestions();
        }

        protected void QuestionNavigatorRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoToQuestion")
            {
                int selectedIndex = Convert.ToInt32(e.CommandArgument);
                Session["currentQuestionIndex"] = selectedIndex;
                LoadQuestions();
            }
        }

        protected string GetQuestionButtonClass(int index)
        {
            int currentIndex = Convert.ToInt32(Session["currentQuestionIndex"]);
            if (index == currentIndex)
            {
                return "nav-question current";
            }

            DataTable questions = Session["QuizQuestions"] as DataTable;

            if (questions != null && index >= 0 && index < questions.Rows.Count)
            {
                int questionID = Convert.ToInt32(questions.Rows[index]["questionID"]);

                if (Answers.ContainsKey(questionID))
                {
                    return "nav-question answered";
                }
            }

            return "nav-question";
        }

        protected void NextButton_Click(object sender, EventArgs e)
        {
            int currentIndex = Convert.ToInt32(Session["currentQuestionIndex"]);

            Session["currentQuestionIndex"] = currentIndex + 1;

            LoadQuestions();
        }

        protected void SubmitQuizButton_Click(object sender, EventArgs e)
        {
            DataTable questions = Session["QuizQuestions"] as DataTable;

            if (questions == null || questions.Rows.Count == 0)
            {
                return;
            }

            List<QuizResultQuestion> results = new List<QuizResultQuestion>();

            int correctCount = 0;
            int answeredCount = 0;
            decimal earnedMarks = 0;
            decimal totalMarks = 0;

            foreach (DataRow question in questions.Rows)
            {
                int questionID = Convert.ToInt32(question["questionID"]);
                decimal marks = Convert.ToDecimal(question["marks"]);

                totalMarks += marks;

                int selectedAnswerID;
                bool isAnswered = Answers.TryGetValue(questionID, out selectedAnswerID);

                DataTable options = LoadAnswerOptions(questionID);

                bool isCorrect = false;
                List<QuizResultOption> optionResults = new List<QuizResultOption>();
                foreach (DataRow option in options.Rows)
                {
                    int answerID = Convert.ToInt32(option["answerID"]);
                    bool optionIsCorrect = Convert.ToInt32(option["isCorrect"]) == 1;
                    bool optionIsSelected = isAnswered && answerID == selectedAnswerID;

                    if (optionIsSelected && optionIsCorrect)
                    {
                        isCorrect = true;
                    }

                    optionResults.Add(new QuizResultOption
                    {
                        AnswerText = Convert.ToString(option["answerText"]).Trim(),
                        CssClass = optionIsCorrect
                            ? "result-option correct"
                            : optionIsSelected
                                ? "result-option wrong"
                                : "result-option",
                        Tag = BuildOptionTag(optionIsCorrect, optionIsSelected)
                    });
                }

                if (isAnswered)
                {
                    answeredCount++;
                }

                if (isCorrect)
                {
                    correctCount++;
                    earnedMarks += marks;
                }

                results.Add(new QuizResultQuestion
                {
                    QuestionText = Convert.ToString(question["questionText"]),
                    IsAnswered = isAnswered,
                    StatusText = !isAnswered
                        ? "Not answered"
                        : isCorrect ? "Correct" : "Incorrect",
                    StatusClass = !isAnswered
                        ? "unanswered"
                        : isCorrect ? "correct" : "wrong",
                    Options = optionResults
                });
            }

            int timeTaken = GetTimeTakenSeconds();

            SaveResult(Convert.ToInt32(Math.Round(earnedMarks)), timeTaken);

            ShowResults(results, correctCount, answeredCount,
                earnedMarks, totalMarks, questions.Rows.Count, timeTaken);
        }

        private void SaveResult(int score, int timeTaken)
        {
            if (Session["userID"] == null || Session["quizID"] == null)
            {
                return;
            }

            int studentID = 0;

            using (SqlConnection conn = new SqlConnection(
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString))
            {
                conn.Open();

                string studentQuery = @"
                    SELECT studentID
                    FROM Student
                    WHERE userID = @userID";

                using (SqlCommand cmd = new SqlCommand(studentQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@userID", Session["userID"]);
                    object result = cmd.ExecuteScalar();

                    if (result == null || result == DBNull.Value)
                    {
                        return;
                    }

                    studentID = Convert.ToInt32(result);
                }

                string checkQuery = @"
                    SELECT score
                    FROM Result
                    WHERE studentID = @studentID
                      AND quizID = @quizID";

                int existingScore = -1;
                bool hasExisting = false;

                using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    cmd.Parameters.AddWithValue("@quizID", Session["quizID"]);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hasExisting = true;
                            existingScore = Convert.ToInt32(reader["score"]);
                        }
                    }
                }

                if (!hasExisting)
                {
                    string insertQuery = @"
                        INSERT INTO Result (studentID, quizID, score, timeTaken)
                        VALUES (@studentID, @quizID, @score, @timeTaken)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@studentID", studentID);
                        cmd.Parameters.AddWithValue("@quizID", Session["quizID"]);
                        cmd.Parameters.AddWithValue("@score", score);
                        cmd.Parameters.AddWithValue("@timeTaken", timeTaken);
                        cmd.ExecuteNonQuery();
                    }
                }
                else if (score > existingScore)
                {
                    string updateQuery = @"
                        UPDATE Result
                        SET score = @score,
                            timeTaken = @timeTaken
                        WHERE studentID = @studentID
                          AND quizID = @quizID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@studentID", studentID);
                        cmd.Parameters.AddWithValue("@quizID", Session["quizID"]);
                        cmd.Parameters.AddWithValue("@score", score);
                        cmd.Parameters.AddWithValue("@timeTaken", timeTaken);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            ProgressCalculator.Recalculate(studentID);
        }

        private int GetTimeTakenSeconds()
        {
            DateTime startTime;

            if (Session["quizStartTime"] is DateTime)
            {
                startTime = (DateTime)Session["quizStartTime"];
            }
            else
            {
                startTime = DateTime.Now;
            }

            int seconds = (int)(DateTime.Now - startTime).TotalSeconds;

            return seconds < 0 ? 0 : seconds;
        }

        private static string FormatDuration(int seconds)
        {
            TimeSpan time = TimeSpan.FromSeconds(seconds);

            if (time.TotalHours >= 1)
            {
                return string.Format("{0}h {1}m", (int)time.TotalHours, time.Minutes);
            }

            if (time.TotalMinutes >= 1)
            {
                return string.Format("{0}m {1}s", time.Minutes, time.Seconds);
            }

            return time.Seconds + "s";
        }

        private static string FormatClock(int seconds)
        {
            TimeSpan time = TimeSpan.FromSeconds(seconds);

            return time.TotalHours >= 1
                ? string.Format("{0}:{1:00}:{2:00}", (int)time.TotalHours, time.Minutes, time.Seconds)
                : string.Format("{0:00}:{1:00}", time.Minutes, time.Seconds);
        }

        private void ShowResults(List<QuizResultQuestion> results,
            int correctCount, int answeredCount,
            decimal earnedMarks, decimal totalMarks, int questionCount,
            int timeTaken)
        {
            ResultsSummary.Text = string.Format(
                "You scored <strong>{0}</strong> out of <strong>{1}</strong> marks. " +
                "{2} of {3} questions correct, {4} unanswered. " +
                "Time taken: <strong>{5}</strong>.",
                earnedMarks, totalMarks, correctCount, questionCount,
                questionCount - answeredCount, FormatDuration(timeTaken));

            ResultsRepeater.DataSource = results;
            ResultsRepeater.DataBind();

            ResultsModal.CssClass = "results-overlay";
            ResultsModal.Visible = true;
        }

        private static string BuildOptionTag(bool isCorrect, bool isSelected)
        {
            if (isCorrect && isSelected)
            {
                return "Correct · Your answer";
            }

            if (isCorrect)
            {
                return "Correct answer";
            }

            return isSelected ? "Your answer" : string.Empty;
        }

        private static bool IsTrue(object value)
        {
            if (value == null || value == DBNull.Value)
            {
                return false;
            }

            bool result;

            return bool.TryParse(Convert.ToString(value).Trim(), out result) && result;
        }
    }

    public class QuizResultOption
    {
        public string AnswerText { get; set; }

        public string CssClass { get; set; }

        public string Tag { get; set; }
    }

    public class QuizResultQuestion
    {
        public string QuestionText { get; set; }

        public string StatusText { get; set; }

        public string StatusClass { get; set; }

        public bool IsAnswered { get; set; }

        public List<QuizResultOption> Options { get; set; }
    }
}
