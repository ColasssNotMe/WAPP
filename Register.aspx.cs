using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace Assignment
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("Homepage");
            }

        }

        protected void togglePasswordView(object sender, EventArgs e)
        {
            if (PasswordTextBox.TextMode == System.Web.UI.WebControls.TextBoxMode.Password)
            {
                PasswordTextBox.TextMode = System.Web.UI.WebControls.TextBoxMode.SingleLine;
            }
            else
            {
                PasswordTextBox.TextMode = System.Web.UI.WebControls.TextBoxMode.Password;
            }
        }

        protected void toggleConfirmPasswordView(object sender, EventArgs e)
        {
            if (ConfirmPasswordTextBox.TextMode == System.Web.UI.WebControls.TextBoxMode.Password)
            {
                ConfirmPasswordTextBox.TextMode = System.Web.UI.WebControls.TextBoxMode.SingleLine;
            }
            else
            {
                ConfirmPasswordTextBox.TextMode = System.Web.UI.WebControls.TextBoxMode.Password;
            }
        }


        private bool IsPasswordStrong(string password)
        {
            bool hasUppercase = Regex.IsMatch(password, @"[A-Z]");
            bool hasLowercase = Regex.IsMatch(password, @"[a-z]");
            bool hasNumber = Regex.IsMatch(password, @"[0-9]");
            bool hasSymbol = Regex.IsMatch(password, @"[^a-zA-Z0-9]");

            return hasUppercase && hasLowercase && hasNumber && hasSymbol;
        }

        protected void CreateAccountButton_Click(object sender, EventArgs e)
        {

            if (!IsPasswordStrong(PasswordTextBox.Text))
            {
                SignupMessage.Text = "Password does not meet the requirements.";
                SignupMessage.CssClass = "signup-message error";
                return;
            }

            if (PasswordTextBox.Text != ConfirmPasswordTextBox.Text)
            {
                SignupMessage.Text = "Passwords do not match.";
                SignupMessage.CssClass = "signup-message error";
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                const string checkQuery = @"
            SELECT COUNT(*)
            FROM [User]
            WHERE email = @email";

                const string checkUsernameQuery = @"
            SELECT COUNT(*)
            FROM [User]
            WHERE username = @username";

                using (SqlCommand checkCommand =
                       new SqlCommand(checkQuery, conn))
                {
                    checkCommand.Parameters.AddWithValue(
                        "@email",
                        EmailTextBox.Text.Trim());

                    int sameEmailCount = Convert.ToInt32(checkCommand.ExecuteScalar());

                    if (sameEmailCount > 0)
                    {
                        errMsg.Text = "This email is already registered.";
                        errMsg.CssClass = "signup-message error";
                        return;
                    }
                }

                using (SqlCommand checkCommand =
                       new SqlCommand(checkUsernameQuery, conn))
                {
                    checkCommand.Parameters.AddWithValue(
                        "@username",
                        UsernameTextBox.Text.Trim());

                    int sameUsernameCount = Convert.ToInt32(checkCommand.ExecuteScalar());

                    if (sameUsernameCount > 0)
                    {
                        errMsg.Text = "This username is already been used.";
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
                    command.Parameters.AddWithValue("@profilePic", "svg/user.svg");
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