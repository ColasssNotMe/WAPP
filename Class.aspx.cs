using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Class : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userID = GetLoggedInUserID();

            if (userID == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadClass(userID);
                LoadLearningMaterials(userID);
                LoadQuizzes(userID);
            }
        }

        private string GetLoggedInUserID()
        {
            if (Session["userID"] == null)
            {
                return null;
            }

            return Session["userID"].ToString();
        }

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["WAPP"]
                .ConnectionString;
        }

        private int GetClassID()
        {
            string queryStringID = Request.QueryString["classID"];

            int classID;

            if (int.TryParse(queryStringID, out classID))
            {
                return classID;
            }

            if (Session["classID"] != null)
            {
                if (int.TryParse(
                    Session["classID"].ToString(),
                    out classID))
                {
                    return classID;
                }
            }

            return 0;
        }

        protected string GetClassIDForLink()
        {
            return GetClassID().ToString();
        }

        private void LoadClass(string userID)
        {
            int classID = GetClassID();

            if (classID == 0)
            {
                Response.Redirect("StudentClassroom.aspx");
                return;
            }

            string query = @"
                SELECT
                    c.classID,
                    c.className,
                    u.firstName,
                    u.lastName
                FROM Class c
                INNER JOIN Teacher t
                    ON c.teacherID = t.teacherID
                INNER JOIN [User] u
                    ON t.userID = u.userID
                INNER JOIN Enrolment e
                    ON c.classID = e.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE c.classID = @classID
                  AND s.userID = @userID";

            using (SqlConnection conn =
                   new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@classID",
                        classID);

                    cmd.Parameters.AddWithValue(
                        "@userID",
                        userID);

                    conn.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            Response.Redirect(
                                "StudentClassroom.aspx");

                            return;
                        }

                        className.InnerText =
                            reader["className"].ToString();

                        string firstName =
                            reader["firstName"].ToString();

                        string lastName =
                            reader["lastName"].ToString();

                        teacherName.InnerText =
                            "Cikgu " +
                            firstName +
                            (string.IsNullOrWhiteSpace(lastName)
                                ? ""
                                : " " + lastName);
                    }
                }
            }
        }

        private void LoadLearningMaterials(string userID)
        {
            int classID = GetClassID();

            string query = @"
                SELECT
                    m.materialID,
                    m.title,
                    m.chapter,
                    m.contentType,
                    m.fileURL,
                    m.durationMins,
                    m.uploadDate
                FROM Material m
                INNER JOIN Class c
                    ON m.classID = c.classID
                INNER JOIN Enrolment e
                    ON c.classID = e.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                WHERE m.classID = @classID
                  AND s.userID = @userID
                  AND m.status = 'Published'
                ORDER BY m.chapter ASC,
                         m.uploadDate ASC";

            DataTable materials = new DataTable();

            using (SqlConnection conn =
                   new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@classID",
                        classID);

                    cmd.Parameters.AddWithValue(
                        "@userID",
                        userID);

                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(materials);
                    }
                }
            }

            LearningMaterialsRepeater.DataSource =
                materials;

            LearningMaterialsRepeater.DataBind();

            materialPlaceholder.Visible =
                materials.Rows.Count == 0;
        }

        private void LoadQuizzes(string userID)
        {
            int classID = GetClassID();

            string query = @"
                SELECT
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    MAX(r.score) AS score
                FROM Quiz q
                INNER JOIN Class c
                    ON q.classID = c.classID
                INNER JOIN Enrolment e
                    ON c.classID = e.classID
                INNER JOIN Student s
                    ON e.studentID = s.studentID
                LEFT JOIN Result r
                    ON r.quizID = q.quizID
                    AND r.studentID = s.studentID
                WHERE q.classID = @classID
                  AND s.userID = @userID
                GROUP BY
                    q.quizID,
                    q.title,
                    q.totalMarks,
                    q.createdDate
                ORDER BY q.createdDate ASC";

            DataTable quizzes = new DataTable();

            using (SqlConnection conn =
                   new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd =
                       new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@classID",
                        classID);

                    cmd.Parameters.AddWithValue(
                        "@userID",
                        userID);

                    using (SqlDataAdapter adapter =
                           new SqlDataAdapter(cmd))
                    {
                        adapter.Fill(quizzes);
                    }
                }
            }

            QuizRepeater.DataSource = quizzes;
            QuizRepeater.DataBind();

            quizPlaceholder.Visible =
                quizzes.Rows.Count == 0;
        }

        protected bool HasAttempt(object dataItem)
        {
            DataRowView row =
                dataItem as DataRowView;

            if (row == null)
            {
                return false;
            }

            if (row["score"] == DBNull.Value)
            {
                return false;
            }

            return true;
        }

        protected string GetScoreDisplay(object dataItem)
        {
            DataRowView row =
                dataItem as DataRowView;

            if (row == null)
            {
                return "";
            }

            if (row["score"] == DBNull.Value)
            {
                return "";
            }

            decimal score =
                Convert.ToDecimal(row["score"]);

            decimal totalMarks =
                Convert.ToDecimal(row["totalMarks"]);

            return "Score: " +
                   score +
                   " / " +
                   totalMarks;
        }

        protected void LearningMaterialsRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenMaterial")
            {
                int materialID;

                if (int.TryParse(
                    e.CommandArgument.ToString(),
                    out materialID))
                {
                    Session["materialId"] =
                        materialID.ToString();

                    Response.Redirect(
                        "NotePage.aspx");
                }
            }
        }

        protected void QuizRepeater_ItemCommand(
            object source,
            RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "OpenQuiz")
            {
                int quizID;

                if (int.TryParse(
                    e.CommandArgument.ToString(),
                    out quizID))
                {
                    Session["quizID"] =
                        quizID.ToString();

                    Response.Redirect(
                        "QuizAttempt.aspx");
                }
            }
        }
    }
}