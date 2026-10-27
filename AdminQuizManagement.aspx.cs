using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminQuizManagement : Page
    {
        private string ConnString =>
            ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

        private int? SelectedQuizID
        {
            get => ViewState["QuizID"] as int?;
            set => ViewState["QuizID"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Tab"] = "Quizzes";
                setDefaultQuiz();
                loadData();
            }
        }

        protected void btnTabQuizzes_Click(object sender, EventArgs e)
        {
            ChangeTab("Quizzes");
        }

        protected void btnTabQuestions_Click(object sender, EventArgs e)
        {
            ChangeTab("Questions");
        }

        private void ChangeTab(string tab)
        {
            ViewState["Tab"] = tab;
            txtSearch.Text = "";
            loadData();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            loadData();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            loadData();
        }

        protected void Row_Command(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectQuiz")
            {
                int quizId;

                if (int.TryParse(e.CommandArgument.ToString(), out quizId))
                {
                    SelectedQuizID = quizId;
                    loadData();
                }
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Response.Redirect("CreateQuiz.aspx");
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            if (SelectedQuizID != null)
            {
                Response.Redirect("ViewQuiz.aspx?quizID=" + SelectedQuizID.Value);
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (SelectedQuizID != null)
            {
                Response.Redirect("AdminQuizEdit.aspx?quizID=" + SelectedQuizID.Value);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (SelectedQuizID == null)
                return;

            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                conn.Open();
                using (SqlTransaction tran = conn.BeginTransaction())
                {
                    try
                    {
                        using (SqlCommand cmd = new SqlCommand("DELETE FROM Question WHERE quizID = @quizID", conn, tran))
                        {
                            cmd.Parameters.AddWithValue("@quizID", SelectedQuizID.Value);
                            cmd.ExecuteNonQuery();
                        }

                        using (SqlCommand cmd = new SqlCommand("DELETE FROM Quiz WHERE quizID = @quizID", conn, tran))
                        {
                            cmd.Parameters.AddWithValue("@quizID", SelectedQuizID.Value);
                            cmd.ExecuteNonQuery();
                        }

                        tran.Commit();
                    }
                    catch
                    {
                        tran.Rollback();
                        throw;
                    }
                }
            }

            SelectedQuizID = null;
            setDefaultQuiz();
            loadData();
        }

        private void loadData()
        {
            string tab = Convert.ToString(ViewState["Tab"]);

            pnlQuizzes.Visible = tab == "Quizzes";
            pnlQuestions.Visible = tab == "Questions";

            btnTabQuizzes.CssClass =
                tab == "Quizzes" ? "tab active" : "tab";

            btnTabQuestions.CssClass =
                tab == "Questions" ? "tab active" : "tab";

            txtSearch.Attributes["placeholder"] =
                tab == "Quizzes" ? "Search quiz title" : "Search question text";

            if (tab == "Questions")
                loadQuestions();
            else
                loadQuizzes();

            loadCounts();
            loadDetails();
        }

        private void loadQuizzes()
        {
            string sql = @"
                SELECT Q.quizID, Q.title, Q.totalMarks, Q.createdDate,
                       C.className, C.subject,
                       U.firstName + ' ' + U.lastName AS teacherName,
                       (SELECT COUNT(*)
                        FROM Question
                        WHERE quizID = Q.quizID) AS questionCount
                FROM Quiz Q
                LEFT JOIN Class C ON C.classID = Q.classID
                LEFT JOIN Teacher T ON T.teacherID = C.teacherID
                LEFT JOIN [User] U ON U.userID = T.userID
                WHERE Q.title LIKE @search
                ORDER BY Q.quizID DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@search", "%" + txtSearch.Text.Trim() + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            QuizRepeater.DataSource = dt;
            QuizRepeater.DataBind();

            lblShowing.Text = dt.Rows.Count.ToString();
            lblItemName.Text = "quizzes";
            emptyQuizzes.Visible = dt.Rows.Count == 0;
        }

        private void loadQuestions()
        {
            string sql = @"
                SELECT Q.questionID, Q.quizID, Q.questionText,
                       Q.questionType, Q.marks,
                       A.answerText, Z.title AS quizTitle
                FROM Question Q
                LEFT JOIN Answer A ON A.answerID = Q.answerID
                LEFT JOIN Quiz Z ON Z.quizID = Q.quizID
                WHERE Q.questionText LIKE @search
                ORDER BY Q.questionID DESC";

            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@search", "%" + txtSearch.Text.Trim() + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    da.Fill(dt);
            }

            QuestionRepeater.DataSource = dt;
            QuestionRepeater.DataBind();

            lblShowing.Text = dt.Rows.Count.ToString();
            lblItemName.Text = "questions";
            emptyQuestions.Visible = dt.Rows.Count == 0;
        }

        private void loadCounts()
        {
            using (SqlConnection conn = new SqlConnection(ConnString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Quiz", conn))
                {
                    lblTotalQuizzes.Text = cmd.ExecuteScalar().ToString();
                }

                using (SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Question", conn))
                {
                    lblQuestionCount.Text = cmd.ExecuteScalar().ToString();
                }
            }

            lblTotal.Text = ViewState["Tab"].ToString() == "Quizzes"
                ? lblTotalQuizzes.Text
                : lblQuestionCount.Text;
        }

        private void setDefaultQuiz()
        {
            SelectedQuizID = null;

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT TOP 1 quizID FROM Quiz ORDER BY quizID DESC", conn))
            {
                conn.Open();

                object result = cmd.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    SelectedQuizID = Convert.ToInt32(result);
                }
            }
        }

        private void loadDetails()
        {
            if (SelectedQuizID == null)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            string sql = @"
                SELECT Q.title,
                       Q.totalMarks,
                       Q.createdDate,
                       C.className,
                       C.subject,
                       U.firstName + ' ' + U.lastName AS teacherName,
                       (SELECT COUNT(*)
                        FROM Question
                        WHERE quizID = Q.quizID) AS questionCount
                FROM Quiz Q
                LEFT JOIN Class C ON C.classID = Q.classID
                LEFT JOIN Teacher T ON T.teacherID = C.teacherID
                LEFT JOIN [User] U ON U.userID = T.userID
                WHERE Q.quizID = @quizID";

            using (SqlConnection conn = new SqlConnection(ConnString))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@quizID", SelectedQuizID.Value);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        pnlDetails.Visible = true;
                        pnlNoSelection.Visible = false;

                        lblDetTitle.Text = GetText(reader["title"]);
                        lblDetTeacher.Text = GetText(reader["teacherName"]);
                        lblDetClass.Text = GetText(reader["className"]);
                        lblDetSubject.Text = GetText(reader["subject"]);
                        lblDetQuestions.Text = reader["questionCount"].ToString();
                        lblDetMarks.Text = GetText(reader["totalMarks"]);
                        lblDetDate.Text = GetDate(reader["createdDate"]);
                    }
                    else
                    {
                        SelectedQuizID = null;
                        pnlDetails.Visible = false;
                        pnlNoSelection.Visible = true;
                    }
                }
            }
        }

        protected string GetText(object value)
        {
            string text = Convert.ToString(value);
            return string.IsNullOrWhiteSpace(text) ? "—" : text;
        }

        protected string GetDate(object value)
        {
            if (value == null || value == DBNull.Value)
                return "—";

            return Convert.ToDateTime(value).ToString("dd MMM yyyy");
        }

        protected string GetRowClass(object quizID)
        {
            bool isSelected = SelectedQuizID != null
                              && quizID != null
                              && quizID != DBNull.Value
                              && Convert.ToInt32(quizID) == SelectedQuizID.Value;

            return isSelected ? "selectable-row selected-row" : "selectable-row";
        }
    }
}