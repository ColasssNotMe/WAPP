
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class StudentClassQuizList : System.Web.UI.Page
    {
        private int ClassID
        {
            get
            {
                int classId;

                if (int.TryParse(Request.QueryString["classID"], out classId)
                    && classId > 0)
                {
                    return classId;
                }

                return 0;
            }
        }

        private string UserID
        {
            get
            {
                object userId = Session["userID"] ?? Session["userId"];

                return userId == null ? null : userId.ToString();
            }
        }

        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["WAPP"]
                    .ConnectionString;
            }
        }

        protected string GetReturnUrl()
        {
            object classId = Session["classID"] ?? Session["classId"];

            int parsedClassId;

            if (classId != null
                && int.TryParse(classId.ToString(), out parsedClassId)
                && parsedClassId > 0)
            {
                return "Class.aspx?classID=" + parsedClassId;
            }

            return "StudentDashboard.aspx";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (UserID == null)
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

            LoadAvailableQuizzes();
            LoadCompletedQuizzes();
        }

        private bool LoadClassName()
        {
            string query = @"
                SELECT className
                FROM Class
                WHERE classID = @ClassID";

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@ClassID", SqlDbType.Int).Value = ClassID;

                conn.Open();

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

        private void LoadAvailableQuizzes()
        {
            if (UserID == null)
            {
                availableQuizRepeater.DataSource = null;
                availableQuizRepeater.DataBind();
                availableEmptyPanel.Visible = true;
                return;
            }

            string search = searchBox.Text.Trim();

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
                    ON s.userID = @UserID
                WHERE q.classID = @ClassID
                    AND q.title LIKE @Search
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
                ORDER BY q.createdDate DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@ClassID", SqlDbType.Int).Value = ClassID;
                cmd.Parameters.Add("@UserID", SqlDbType.VarChar, 255).Value = UserID;
                cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 255).Value =
                    "%" + search + "%";

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

        private void LoadCompletedQuizzes()
        {
            if (UserID == null)
            {
                completedQuizRepeater.DataSource = null;
                completedQuizRepeater.DataBind();
                completedEmptyPanel.Visible = true;
                return;
            }

            string search = searchBox.Text.Trim();

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
                WHERE s.userID = @UserID
                    AND q.classID = @ClassID
                    AND q.title LIKE @Search
                GROUP BY
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    r.score,
                    r.timeTaken,
                    r.resultID
                ORDER BY r.resultID DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@ClassID", SqlDbType.Int).Value = ClassID;
                cmd.Parameters.Add("@UserID", SqlDbType.VarChar, 255).Value = UserID;
                cmd.Parameters.Add("@Search", SqlDbType.NVarChar, 255).Value =
                    "%" + search + "%";

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
                    percentage = (double)(score / totalMarks) * 100;
                }

                row["ScoreText"] = score + " / " + totalMarks;

                row["ScorePercentage"] =
                    Math.Min(100, Math.Max(0, percentage));

                if (row["TimeTaken"] == DBNull.Value)
                {
                    row["TimeTakenText"] = "Not recorded";
                }
                else
                {
                    int seconds = Convert.ToInt32(row["TimeTaken"]);
                    TimeSpan time = TimeSpan.FromSeconds(seconds);

                    if (time.TotalHours >= 1)
                    {
                        row["TimeTakenText"] = string.Format(
                            "{0}h {1}m",
                            (int)time.TotalHours,
                            time.Minutes);
                    }
                    else if (time.Minutes > 0)
                    {
                        row["TimeTakenText"] = string.Format(
                            "{0}m {1}s",
                            time.Minutes,
                            time.Seconds);
                    }
                    else
                    {
                        row["TimeTakenText"] = time.Seconds + "s";
                    }
                }
            }

            completedQuizRepeater.DataSource = dt;
            completedQuizRepeater.DataBind();

            completedEmptyPanel.Visible = dt.Rows.Count == 0;
        }

        protected void searchBox_TextChanged(object sender, EventArgs e)
        {
            LoadAvailableQuizzes();
            LoadCompletedQuizzes();
        }

        protected void AvailableQuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "StartQuiz")
            {
                int quizId;

                if (int.TryParse(
                    Convert.ToString(e.CommandArgument),
                    out quizId))
                {
                    Session["quizID"] = quizId.ToString();
                    Response.Redirect("StudentQuiz.aspx");
                }
            }
        }

        protected void CompletedQuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ViewResult")
            {
                int quizId;

                if (int.TryParse(
                    Convert.ToString(e.CommandArgument),
                    out quizId))
                {
                    Session["quizID"] = quizId.ToString();
                    Response.Redirect("QuizResult.aspx");
                }
            }
        }
    }
}
