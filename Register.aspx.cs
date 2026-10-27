using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void CreateAccountButton_Click(object sender, EventArgs e)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                const string checkQuery = @"
            SELECT COUNT(*)
            FROM [User]
            WHERE email = @email";

                using (SqlCommand checkCommand =
                       new SqlCommand(checkQuery, conn))
                {
                    checkCommand.Parameters.AddWithValue(
                        "@email",
                        EmailTextBox.Text.Trim());

                    int count = Convert.ToInt32(checkCommand.ExecuteScalar());

                    if (count > 0)
                    {
                        errMsg.Text = "This email is already registered.";
                        errMsg.CssClass = "signup-message error";
                        return;
                    }
                }

                const string userQuery = @"
            INSERT INTO [User]
                (username, email, password, firstName, lastName,
                 role, profilePic, dateRegistered)
            OUTPUT INSERTED.userID
            VALUES
                (@username, @email, @password, @firstName, @lastName,
                 @role, @profilePic, @dateRegistered)";

                int userId;

                PasswordManager passwordManager = new PasswordManager();

                using (SqlCommand command =
                       new SqlCommand(userQuery, conn))
                {
                    command.Parameters.AddWithValue("@username", UsernameTextBox.Text.Trim());
                    command.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());
                    command.Parameters.AddWithValue("@password", passwordManager.HashPassword(PasswordTextBox.Text));
                    command.Parameters.AddWithValue("@firstName", FirstNameTextBox.Text.Trim());
                    command.Parameters.AddWithValue("@lastName", LastNameTextBox.Text.Trim());
                    command.Parameters.AddWithValue("@role", RoleRadioList.SelectedValue);
                    command.Parameters.AddWithValue("@profilePic", DBNull.Value);
                    command.Parameters.AddWithValue("@dateRegistered", DateTime.Now);

                    userId = Convert.ToInt32(command.ExecuteScalar());
                }

                if (RoleRadioList.SelectedValue == "Student")
                {
                    const string studentQuery = @"
                INSERT INTO Student
                    (userID, school)
                VALUES
                    (@userID, @school)";

                    using (SqlCommand studentCommand =
                           new SqlCommand(studentQuery, conn))
                    {
                        studentCommand.Parameters.AddWithValue("@userID", userId);
                        studentCommand.Parameters.AddWithValue("@school", SchoolDropDown.SelectedValue);
                        studentCommand.ExecuteNonQuery();
                    }
                }
                else
                {
                    const string teacherQuery = @"
                INSERT INTO Teacher
                    (userID,  school, approved)
                VALUES
                    (@userID,  @school, 'false')";

                    using (SqlCommand command =
                           new SqlCommand(teacherQuery, conn))
                    {
                        command.Parameters.AddWithValue("@userID", userId);
                        command.Parameters.AddWithValue("@school", SchoolDropDown.SelectedValue);
                        command.ExecuteNonQuery();
                    }
                }

                Response.Redirect("HomePage.aspx");
            }
        }
    }
}