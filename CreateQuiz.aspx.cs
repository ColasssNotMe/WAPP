using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CreateQuiz : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
           
            if (Session["role"].ToString() == "Admin")
            {
                pageTitleText.InnerText = "Admin - Create Quiz";
                backBtn.Visible = false;

            }

            if (!IsPostBack)
            {
                LoadClassrooms();
                InitializeQuestionsTable();
            }
        }

        private void LoadClassrooms()
        {
            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                string query = "SELECT classID, className FROM Class ORDER BY className ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    ddlClassroom.DataSource = cmd.ExecuteReader();
                    ddlClassroom.DataTextField = "className";
                    ddlClassroom.DataValueField = "classID";
                    ddlClassroom.DataBind();
                }
            }
            ddlClassroom.Items.Insert(0, new ListItem("-- Select Classroom --", ""));
        }

        private void InitializeQuestionsTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("QuestionText", typeof(string));
            dt.Columns.Add("QuestionType", typeof(string));
            dt.Columns.Add("Marks", typeof(int));
            dt.Columns.Add("Option1", typeof(string));
            dt.Columns.Add("Option2", typeof(string));
            dt.Columns.Add("Option3", typeof(string));
            dt.Columns.Add("Option4", typeof(string));
            dt.Columns.Add("IsCorrect1", typeof(bool));
            dt.Columns.Add("IsCorrect2", typeof(bool));
            dt.Columns.Add("IsCorrect3", typeof(bool));
            dt.Columns.Add("IsCorrect4", typeof(bool));

            // Add default first question
            DataRow dr = dt.NewRow();
            dr["QuestionText"] = "";
            dr["QuestionType"] = "MCQ";
            dr["Marks"] = 2;
            dr["Option1"] = "";
            dr["Option2"] = "";
            dr["Option3"] = "";
            dr["Option4"] = "";
            dr["IsCorrect1"] = true;
            dr["IsCorrect2"] = false;
            dr["IsCorrect3"] = false;
            dr["IsCorrect4"] = false;
            dt.Rows.Add(dr);

            ViewState["QuestionsTable"] = dt;
            BindQuestions();
        }

        private void SaveCurrentQuestionsState()
        {
            DataTable dt = (DataTable)ViewState["QuestionsTable"];
            dt.Rows.Clear();

            int totalCalculatedMarks = 0;

            foreach (RepeaterItem item in rptQuestions.Items)
            {
                TextBox txtQuestionText = (TextBox)item.FindControl("txtQuestionText");
                DropDownList ddlQuestionType = (DropDownList)item.FindControl("ddlQuestionType");
                TextBox txtMarks = (TextBox)item.FindControl("txtMarks");

                TextBox txtOption1 = (TextBox)item.FindControl("txtOption1");
                TextBox txtOption2 = (TextBox)item.FindControl("txtOption2");
                TextBox txtOption3 = (TextBox)item.FindControl("txtOption3");
                TextBox txtOption4 = (TextBox)item.FindControl("txtOption4");

                RadioButton rb1 = (RadioButton)item.FindControl("rb1");
                RadioButton rb2 = (RadioButton)item.FindControl("rb2");
                RadioButton rb3 = (RadioButton)item.FindControl("rb3");
                RadioButton rb4 = (RadioButton)item.FindControl("rb4");

                TextBox txtCorrectShortAnswer = (TextBox)item.FindControl("txtCorrectShortAnswer");

                DataRow dr = dt.NewRow();
                dr["QuestionText"] = txtQuestionText != null ? txtQuestionText.Text : "";
                dr["QuestionType"] = ddlQuestionType != null ? ddlQuestionType.SelectedValue : "MCQ";

                int marks = (txtMarks != null && int.TryParse(txtMarks.Text, out marks)) ? marks : 1;
                dr["Marks"] = marks;
                totalCalculatedMarks += marks;

                if (dr["QuestionType"].ToString() == "ShortAnswer")
                {
                    dr["Option1"] = txtCorrectShortAnswer != null ? txtCorrectShortAnswer.Text : "";
                    dr["Option2"] = "";
                    dr["Option3"] = "";
                    dr["Option4"] = "";
                    dr["IsCorrect1"] = true;
                    dr["IsCorrect2"] = false;
                    dr["IsCorrect3"] = false;
                    dr["IsCorrect4"] = false;
                }
                else
                {
                    dr["Option1"] = txtOption1 != null ? txtOption1.Text : "";
                    dr["Option2"] = txtOption2 != null ? txtOption2.Text : "";
                    dr["Option3"] = txtOption3 != null ? txtOption3.Text : "";
                    dr["Option4"] = txtOption4 != null ? txtOption4.Text : "";

                    dr["IsCorrect1"] = rb1 != null ? rb1.Checked : false;
                    dr["IsCorrect2"] = rb2 != null ? rb2.Checked : false;
                    dr["IsCorrect3"] = rb3 != null ? rb3.Checked : false;
                    dr["IsCorrect4"] = rb4 != null ? rb4.Checked : false;
                }

                dt.Rows.Add(dr);
            }

            ViewState["QuestionsTable"] = dt;
            txtTotalMarks.Text = totalCalculatedMarks.ToString();
        }

        private void BindQuestions()
        {
            DataTable dt = (DataTable)ViewState["QuestionsTable"];
            rptQuestions.DataSource = dt;
            rptQuestions.DataBind();
        }

        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            SaveCurrentQuestionsState();
            DataTable dt = (DataTable)ViewState["QuestionsTable"];

            DataRow dr = dt.NewRow();
            dr["QuestionText"] = "";
            dr["QuestionType"] = "MCQ";
            dr["Marks"] = 2;
            dr["Option1"] = "";
            dr["Option2"] = "";
            dr["Option3"] = "";
            dr["Option4"] = "";
            dr["IsCorrect1"] = true;
            dr["IsCorrect2"] = false;
            dr["IsCorrect3"] = false;
            dr["IsCorrect4"] = false;
            dt.Rows.Add(dr);

            ViewState["QuestionsTable"] = dt;
            BindQuestions();
        }

        protected void rptQuestions_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveQuestion")
            {
                SaveCurrentQuestionsState();
                DataTable dt = (DataTable)ViewState["QuestionsTable"];
                int index = Convert.ToInt32(e.CommandArgument);
                if (dt.Rows.Count > 1)
                {
                    dt.Rows.RemoveAt(index);
                }
                ViewState["QuestionsTable"] = dt;
                BindQuestions();
            }
        }

        protected void ddlQuestionType_SelectedIndexChanged(object sender, EventArgs e)
        {
            SaveCurrentQuestionsState();
            BindQuestions();
        }

        protected void btnSaveQuiz_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlClassroom.SelectedValue))
            {
                return;
            }

            SaveCurrentQuestionsState();
            DataTable dt = (DataTable)ViewState["QuestionsTable"];

            string title = txtQuizTitle.Text.Trim();
            if (string.IsNullOrEmpty(title)) title = "Untitled Quiz";

            int classId = Convert.ToInt32(ddlClassroom.SelectedValue);
            int totalMarks = Convert.ToInt32(txtTotalMarks.Text);

            using (SqlConnection conn = new SqlConnection(GetConnectionString()))
            {
                conn.Open();
                using (SqlTransaction trans = conn.BeginTransaction())
                {
                    try
                    {
                        // 1. Insert into Quiz table
                        string insertQuiz = @"INSERT INTO Quiz (classID, title, totalMarks, createdDate) 
                                              VALUES (@classID, @title, @totalMarks, GETDATE());
                                              SELECT SCOPE_IDENTITY();";

                        int newQuizId = 0;
                        using (SqlCommand cmd = new SqlCommand(insertQuiz, conn, trans))
                        {
                            cmd.Parameters.AddWithValue("@classID", classId);
                            cmd.Parameters.AddWithValue("@title", title);
                            cmd.Parameters.AddWithValue("@totalMarks", totalMarks);
                            newQuizId = Convert.ToInt32(cmd.ExecuteScalar());
                        }

                        // 2. Insert Questions & Answers
                        foreach (DataRow row in dt.Rows)
                        {
                            string qText = row["QuestionText"].ToString();
                            string qType = row["QuestionType"].ToString();
                            int qMarks = Convert.ToInt32(row["Marks"]);

                            string insertQ = @"INSERT INTO Question (quizID, questionText, questionType, marks) 
                                               VALUES (@quizID, @qText, @qType, @qMarks);
                                               SELECT SCOPE_IDENTITY();";

                            int newQuestionId = 0;
                            using (SqlCommand cmdQ = new SqlCommand(insertQ, conn, trans))
                            {
                                cmdQ.Parameters.AddWithValue("@quizID", newQuizId);
                                cmdQ.Parameters.AddWithValue("@qText", qText);
                                cmdQ.Parameters.AddWithValue("@qType", qType);
                                cmdQ.Parameters.AddWithValue("@qMarks", qMarks);
                                newQuestionId = Convert.ToInt32(cmdQ.ExecuteScalar());
                            }

                            // Insert Options into Answer Table
                            if (qType == "MCQ")
                            {
                                string[] opts = { row["Option1"].ToString(), row["Option2"].ToString(), row["Option3"].ToString(), row["Option4"].ToString() };
                                bool[] isCorrect = { Convert.ToBoolean(row["IsCorrect1"]), Convert.ToBoolean(row["IsCorrect2"]), Convert.ToBoolean(row["IsCorrect3"]), Convert.ToBoolean(row["IsCorrect4"]) };

                                for (int i = 0; i < 4; i++)
                                {
                                    if (!string.IsNullOrEmpty(opts[i]))
                                    {
                                        InsertAnswerRecord(conn, trans, newQuestionId, opts[i], isCorrect[i]);
                                    }
                                }
                            }
                            else if (qType == "TrueFalse")
                            {
                                InsertAnswerRecord(conn, trans, newQuestionId, "True", Convert.ToBoolean(row["IsCorrect1"]));
                                InsertAnswerRecord(conn, trans, newQuestionId, "False", Convert.ToBoolean(row["IsCorrect2"]));
                            }
                            else if (qType == "ShortAnswer")
                            {
                                string keyAns = row["Option1"].ToString();
                                if (!string.IsNullOrEmpty(keyAns))
                                {
                                    InsertAnswerRecord(conn, trans, newQuestionId, keyAns, true);
                                }
                            }
                        }

                        trans.Commit();
                    }
                    catch (Exception)
                    {
                        trans.Rollback();
                        throw;
                    }
                }
            }

            bool isAdmin = string.Equals(
                 Convert.ToString(Session["Role"]), "Admin", StringComparison.OrdinalIgnoreCase);

            Response.Redirect(isAdmin ? "AdminQuizManagement.aspx" : "ManageQuiz.aspx");
        }

        private void InsertAnswerRecord(SqlConnection conn, SqlTransaction trans, int questionId, string answerText, bool isCorrect)
        {
            string insertAns = @"INSERT INTO Answer (questionID, answerText, isCorrect) 
                        VALUES (@questionID, @ansText, @isCorrect);";

            using (SqlCommand cmdA = new SqlCommand(insertAns, conn, trans))
            {
                cmdA.Parameters.AddWithValue("@questionID", questionId);
                cmdA.Parameters.AddWithValue("@ansText", answerText);
                cmdA.Parameters.AddWithValue("@isCorrect", isCorrect);
                cmdA.ExecuteNonQuery();
            
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            bool isAdmin = string.Equals(
                Convert.ToString(Session["Role"]), "Admin", StringComparison.OrdinalIgnoreCase);

            Response.Redirect(isAdmin ? "AdminQuizManagement.aspx" : "ManageQuiz.aspx");
        }
    }
}