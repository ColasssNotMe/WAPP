using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminQuizManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserID"] == null)
            //{
            //    Response.Redirect("Login.aspx");
            //    return;
            //}

            if (!IsPostBack)
            {
                ViewState["Tab"] = "Quizzes";
                setDefaultQuiz();
                loadData();
            }
        }

        protected void btnTabQuizzes_Click(object sender, EventArgs e)
        {
            ViewState["Tab"] = "Quizzes";
            txtSearch.Text = "";
            loadData();
        }

        protected void btnTabQuestions_Click(object sender, EventArgs e)
        {
            ViewState["Tab"] = "Questions";
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

        // Click View on a row (used by both repeaters)
        protected void Row_Command(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectQuiz")
            {
                ViewState["QuizID"] = Convert.ToInt32(e.CommandArgument);
                loadData();
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            // create quiz page need to do the role validation
            Response.Redirect("CreateQuiz.aspx");
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            //Response.Redirect("AdminQuizEdit.aspx?id=" + ViewState["QuizID"]);
        }

        private void loadData()
        {
            string tab = ViewState["Tab"].ToString();

            if (tab == "Quizzes")
            {
                pnlQuizzes.Visible = true;
                pnlQuestions.Visible = false;
                txtSearch.Attributes["placeholder"] = "Search quiz title";
                loadQuizzes();
            }
            else
            {
                pnlQuizzes.Visible = false;
                pnlQuestions.Visible = true;
                txtSearch.Attributes["placeholder"] = "Search question text";
                loadQuestions();
            }

            // Update the selected tab
            btnTabQuizzes.CssClass = tab == "Quizzes" ? "tab active" : "tab";
            btnTabQuestions.CssClass = tab == "Questions" ? "tab active" : "tab";

            loadCounts();
            loadDetails();
        }

        private void loadQuizzes()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "SELECT qz.quizID, qz.title, qz.totalMarks, qz.createdDate, " +
                           "c.className, c.subject, " +
                           "(u.firstName + ' ' + u.lastName) AS teacherName, " +
                           "(SELECT COUNT(*) FROM Question WHERE Question.quizID = qz.quizID) AS questionCount " +
                           "FROM Quiz qz " +
                           "LEFT JOIN Class c ON c.classID = qz.classID " +
                           "LEFT JOIN Teacher t ON t.teacherID = c.teacherID " +
                           "LEFT JOIN [User] u ON u.userID = t.userID " +
                           "WHERE 1 = 1";

            string search = txtSearch.Text.Trim();

            if (search != "")
            {
                query += " AND qz.title LIKE @search";
            }

            query += " ORDER BY qz.quizID DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (search != "")
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                QuizRepeater.DataSource = dt;
                QuizRepeater.DataBind();

                lblShowing.Text = dt.Rows.Count.ToString();
                lblItemName.Text = "quizzes";

                emptyQuizzes.Visible = dt.Rows.Count == 0;
            }
        }

        private void loadQuestions()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "SELECT qs.questionID, qs.quizID, qs.questionText, qs.questionType, qs.marks, " +
                           "a.answerText, qz.title AS quizTitle " +
                           "FROM Question qs " +
                           "LEFT JOIN Answer a ON a.answerID = qs.answerID " +
                           "LEFT JOIN Quiz qz ON qz.quizID = qs.quizID " +
                           "WHERE 1 = 1";

            string search = txtSearch.Text.Trim();

            if (search != "")
            {
                query += " AND qs.questionText LIKE @search";
            }

            query += " ORDER BY qs.questionID DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                if (search != "")
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                QuestionRepeater.DataSource = dt;
                QuestionRepeater.DataBind();

                lblShowing.Text = dt.Rows.Count.ToString();
                lblItemName.Text = "questions";

                emptyQuestions.Visible = dt.Rows.Count == 0;
            }
        }

        private void loadCounts()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                SqlCommand quizCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Quiz", conn);

                lblTotalQuizzes.Text = quizCmd.ExecuteScalar().ToString();

                SqlCommand questionCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Question", conn);

                lblQuestionCount.Text = questionCmd.ExecuteScalar().ToString();

                // Total shown at the bottom of the table
                if (ViewState["Tab"].ToString() == "Quizzes")
                {
                    lblTotal.Text = lblTotalQuizzes.Text;
                }
                else
                {
                    lblTotal.Text = lblQuestionCount.Text;
                }
            }
        }

        // Select the newest quiz when the page first loads
        private void setDefaultQuiz()
        {
            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT TOP 1 quizID FROM Quiz ORDER BY quizID DESC", conn);

                conn.Open();

                object result = cmd.ExecuteScalar();

                if (result != null)
                {
                    ViewState["QuizID"] = Convert.ToInt32(result);
                }
            }
        }

        // Fill the Quiz Details panel
        private void loadDetails()
        {
            // No quiz in the database yet
            if (ViewState["QuizID"] == null)
            {
                pnlDetails.Visible = false;
                pnlNoSelection.Visible = true;
                return;
            }

            string connString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = "SELECT qz.title, qz.totalMarks, qz.createdDate, " +
                           "c.className, c.subject, " +
                           "(u.firstName + ' ' + u.lastName) AS teacherName, " +
                           "(SELECT COUNT(*) FROM Question WHERE Question.quizID = qz.quizID) AS questionCount " +
                           "FROM Quiz qz " +
                           "LEFT JOIN Class c ON c.classID = qz.classID " +
                           "LEFT JOIN Teacher t ON t.teacherID = c.teacherID " +
                           "LEFT JOIN [User] u ON u.userID = t.userID " +
                           "WHERE qz.quizID = @quizID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@quizID", ViewState["QuizID"]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    pnlDetails.Visible = false;
                    pnlNoSelection.Visible = true;
                    return;
                }

                pnlDetails.Visible = true;
                pnlNoSelection.Visible = false;

                DataRow row = dt.Rows[0];

                lblDetTitle.Text = GetText(row["title"]);
                lblDetTeacher.Text = GetText(row["teacherName"]);
                lblDetClass.Text = GetText(row["className"]);
                lblDetSubject.Text = GetText(row["subject"]);
                lblDetQuestions.Text = row["questionCount"].ToString();
                lblDetMarks.Text = GetText(row["totalMarks"]);
                lblDetDate.Text = Convert.ToDateTime(row["createdDate"]).ToString("dd MMM yyyy");
            }
        }

        // Show a dash when the value is empty
        protected string GetText(object value)
        {
            string text = Convert.ToString(value);

            if (text.Trim() == "")
            {
                return "—";
            }

            return text;
        }

        // Returns "true" for the row that is currently selected
        protected string GetSelected(object quizID)
        {
            if (Convert.ToString(quizID) == Convert.ToString(ViewState["QuizID"]))
            {
                return "true";
            }

            return "false";
        }
    }
}