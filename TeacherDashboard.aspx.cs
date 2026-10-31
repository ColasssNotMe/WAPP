using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class TeacherDashboard : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["WAPP"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            try
            {
                if (Session["userID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                int userID;

                if (!int.TryParse(
                    Session["userID"].ToString(),
                    out userID))
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                int teacherID = GetTeacherID(userID);

                if (teacherID == 0)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                LoadTeacherName(userID);
                LoadDashboardCounts(teacherID);
                LoadClassroomSummary(teacherID);
                LoadRecentMaterials(teacherID);
                LoadRecentQuizzes(teacherID);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "TeacherDashboard Error: " + ex.Message);
            }
        }

        private int GetTeacherID(int userID)
        {
            string query = @"
                SELECT teacherID
                FROM Teacher
                WHERE userID = @userID
            ";

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@userID",
                        userID);

                    connection.Open();

                    object result = command.ExecuteScalar();

                    if (result == null ||
                        result == DBNull.Value)
                    {
                        return 0;
                    }

                    return Convert.ToInt32(result);
                }
            }
        }

        private void LoadTeacherName(int userID)
        {
            string query = @"
                SELECT
                    firstName,
                    lastName
                FROM [User]
                WHERE userID = @userID
            ";

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@userID",
                        userID);

                    connection.Open();

                    using (SqlDataReader reader =
                        command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string firstName =
                                reader["firstName"] == DBNull.Value
                                    ? ""
                                    : reader["firstName"].ToString();

                            string lastName =
                                reader["lastName"] == DBNull.Value
                                    ? ""
                                    : reader["lastName"].ToString();

                            string fullName =
                                (firstName + " " + lastName).Trim();

                            if (string.IsNullOrEmpty(fullName))
                            {
                                fullName = "Teacher";
                            }

                            lblTeacherName.Text = fullName;
                        }
                    }
                }
            }
        }

        private void LoadDashboardCounts(int teacherID)
        {
            string query = @"
                SELECT

                    -- Total unique students enrolled
                    (
                        SELECT COUNT(DISTINCT e.studentID)
                        FROM Enrolment e
                        INNER JOIN Class c
                            ON e.classID = c.classID
                        WHERE c.teacherID = @teacherID
                    ) AS studentCount,

                    -- Number of classrooms
                    (
                        SELECT COUNT(*)
                        FROM Class c
                        WHERE c.teacherID = @teacherID
                    ) AS classroomCount,

                    -- Total quizzes belonging to this teacher's classes
                    (
                        SELECT COUNT(*)
                        FROM Quiz q
                        INNER JOIN Class c
                            ON q.classID = c.classID
                        WHERE c.teacherID = @teacherID
                    ) AS quizCount,

                    -- Materials added during the current month
                    (
                        SELECT COUNT(*)
                        FROM Material m
                        INNER JOIN Class c
                            ON m.classID = c.classID
                        WHERE c.teacherID = @teacherID
                          AND m.uploadDate >=
                              DATEFROMPARTS(
                                  YEAR(GETDATE()),
                                  MONTH(GETDATE()),
                                  1
                              )
                          AND m.uploadDate <
                              DATEADD(
                                  MONTH,
                                  1,
                                  DATEFROMPARTS(
                                      YEAR(GETDATE()),
                                      MONTH(GETDATE()),
                                      1
                                  )
                              )
                    ) AS noteCount
            ";

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@teacherID",
                        teacherID);

                    connection.Open();

                    using (SqlDataReader reader =
                        command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblStudentCount.Text =
                                reader["studentCount"].ToString();

                            lblActiveClassrooms.Text =
                                reader["classroomCount"].ToString();

                            lblQuizCount.Text =
                                reader["quizCount"].ToString();

                            lblNoteCount.Text =
                                reader["noteCount"].ToString();
                        }
                    }
                }
            }
        }

        private void LoadClassroomSummary(int teacherID)
        {
            string query = @"
                SELECT
                    c.classID,
                    c.className,

                    COUNT(DISTINCT e.studentID) AS studentCount

                FROM Class c

                LEFT JOIN Enrolment e
                    ON c.classID = e.classID

                WHERE c.teacherID = @teacherID

                GROUP BY
                    c.classID,
                    c.className

                ORDER BY
                    c.className
            ";

            DataTable table = new DataTable();

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@teacherID",
                        teacherID);

                    using (SqlDataAdapter adapter =
                        new SqlDataAdapter(command))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            rptClassrooms.DataSource = table;
            rptClassrooms.DataBind();

            pnlNoClassrooms.Visible = table.Rows.Count == 0;
        }

        private void LoadRecentMaterials(int teacherID)
        {
            string query = @"
                SELECT TOP 3
                    m.materialID,
                    m.title,
                    c.className,
                    m.uploadDate

                FROM Material m

                INNER JOIN Class c
                    ON m.classID = c.classID

                WHERE c.teacherID = @teacherID

                ORDER BY
                    m.uploadDate DESC
            ";

            DataTable table = new DataTable();

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@teacherID",
                        teacherID);

                    using (SqlDataAdapter adapter =
                        new SqlDataAdapter(command))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            rptMaterials.DataSource = table;
            rptMaterials.DataBind();

            pnlNoMaterials.Visible = table.Rows.Count == 0;
        }

        private void LoadRecentQuizzes(int teacherID)
        {
            string query = @"
                SELECT TOP 2
                    q.quizID,
                    q.title,
                    c.className,
                    q.createdDate

                FROM Quiz q

                INNER JOIN Class c
                    ON q.classID = c.classID

                WHERE c.teacherID = @teacherID

                ORDER BY
                    q.createdDate DESC
            ";

            DataTable table = new DataTable();

            using (SqlConnection connection =
                new SqlConnection(ConnectionString))
            {
                using (SqlCommand command =
                    new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue(
                        "@teacherID",
                        teacherID);

                    using (SqlDataAdapter adapter =
                        new SqlDataAdapter(command))
                    {
                        adapter.Fill(table);
                    }
                }
            }

            rptQuizzes.DataSource = table;
            rptQuizzes.DataBind();

            pnlNoQuizzes.Visible = table.Rows.Count == 0;
        }
    }
}