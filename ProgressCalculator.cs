using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Assignment
{
    public static class ProgressCalculator
    {
        public static void Recalculate(int studentID)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();

                int totalQuizzes = 0;

                string totalQuery = @"
                    SELECT COUNT(DISTINCT q.quizID)
                    FROM Enrolment e
                    INNER JOIN Quiz q ON q.classID = e.classID
                    WHERE e.studentID = @studentID";

                using (var cmd = new SqlCommand(totalQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    totalQuizzes = Convert.ToInt32(cmd.ExecuteScalar());
                }


                int completedQuizzes = 0;

                string completedQuery = @"
                    SELECT COUNT(DISTINCT r.quizID)
                    FROM Result r
                    INNER JOIN Quiz q ON q.quizID = r.quizID
                    INNER JOIN Enrolment e ON e.classID = q.classID
                    WHERE r.studentID = @studentID
                      AND e.studentID = @studentID";

                using (var cmd = new SqlCommand(completedQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    completedQuizzes = Convert.ToInt32(cmd.ExecuteScalar());
                }


                int progressPercentage = 0;

                if (totalQuizzes > 0)
                {
                    progressPercentage =
                        (int)Math.Round(100.0 * completedQuizzes / totalQuizzes);
                }


                string updateQuery = @"
                    UPDATE Student
                    SET progressPercentage = @progressPercentage
                    WHERE studentID = @studentID";

                using (var cmd = new SqlCommand(updateQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@progressPercentage", progressPercentage);
                    cmd.Parameters.AddWithValue("@studentID", studentID);
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}