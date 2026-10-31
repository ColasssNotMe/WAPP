using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace Assignment
{
    public partial class AdminProfile : Page
    {
        private static string ConnString
        {
            get { return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString; }
        }

        private int UserId
        {
            get { return Convert.ToInt32(Session["userID"]); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userid"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                SetEditMode(false);
                LoadUserData();
            }
        }

        private void SetEditMode(bool editing)
        {
            usernameInput.Attributes["readonly"] = editing ? null : "readonly";
            email.Attributes["readonly"] = editing ? null : "readonly";
            firstName.Attributes["readonly"] = editing ? null : "readonly";
            lastName.Attributes["readonly"] = editing ? null : "readonly";
            school.Attributes["readonly"] = editing ? null : "readonly";

            btnEdit.Visible = !editing;
            pnlEditActions.Visible = editing;
            lblEditing.Visible = editing;
        }

        private void LoadUserData()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();

                    string query =
                        "SELECT username, email, firstName, lastName, dateRegistered " +
                        "FROM [User] WHERE userID = @userID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string first = reader["firstName"].ToString();
                                string last = reader["lastName"].ToString();
                                string username = reader["username"].ToString();

                                firstName.Value = first;
                                lastName.Value = last;
                                usernameInput.Value = username;
                                email.Value = reader["email"].ToString();

                                displayName.InnerText = (first + " " + last).Trim();
                                avatar.InnerText = GetInitials(first, last);
                                userMeta.InnerText = username + " • Ncient Education";

                                joinedDate.InnerText = reader["dateRegistered"] != DBNull.Value
                                    ? Convert.ToDateTime(reader["dateRegistered"]).ToString("MMMM yyyy")
                                    : "Not available";
                            }
                            else
                            {
                                ShowMessage("User account could not be found.", false);
                                return;
                            }
                        }
                    }

                    // Only show the school field if this user has a Teacher record
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT school FROM [Teacher] WHERE userID = @userID", conn))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;
                        object result = cmd.ExecuteScalar();

                        schoolField.Visible = result != null;
                        school.Value = (result == null || result == DBNull.Value)
                            ? ""
                            : result.ToString();
                    }
                }
            }
            catch (Exception)
            {
                ShowMessage("Could not load your profile.", false);
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ClearMessages();
            CloseePasswordPanel();
            SetEditMode(true);
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ClearMessages();
            LoadUserData();
            SetEditMode(false);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string first = firstName.Value.Trim();
            string last = lastName.Value.Trim();
            string username = usernameInput.Value.Trim();
            string mail = email.Value.Trim();
            string schoolName = school.Value.Trim();

            if (first == "" || last == "" || username == "" || mail == "")
            {
                SaveFailed("Please fill in username, email, first name and last name.");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(mail, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                SaveFailed("Please enter a valid email address.");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();

                    string duplicateQuery =
                        "SELECT COUNT(*) FROM [User] " +
                        "WHERE (username = @username OR email = @email) " +
                        "AND userID <> @userID";

                    using (SqlCommand cmd = new SqlCommand(duplicateQuery, conn))
                    {
                        cmd.Parameters.Add("@username", SqlDbType.NVarChar, 50).Value = username;
                        cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value = mail;
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;

                        if (Convert.ToInt32(cmd.ExecuteScalar()) > 0)
                        {
                            SaveFailed("That username or email is already in use.");
                            return;
                        }
                    }

                    string updateUser =
                        "UPDATE [User] SET username = @username, email = @email, " +
                        "firstName = @firstName, lastName = @lastName " +
                        "WHERE userID = @userID";

                    using (SqlCommand cmd = new SqlCommand(updateUser, conn))
                    {
                        cmd.Parameters.Add("@username", SqlDbType.NVarChar, 50).Value = username;
                        cmd.Parameters.Add("@email", SqlDbType.NVarChar, 100).Value = mail;
                        cmd.Parameters.Add("@firstName", SqlDbType.NVarChar, 50).Value = first;
                        cmd.Parameters.Add("@lastName", SqlDbType.NVarChar, 50).Value = last;
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;
                        cmd.ExecuteNonQuery();
                    }

                    // Update school only when the field is shown (Teacher record exists)
                    if (schoolField.Visible)
                    {
                        using (SqlCommand cmd = new SqlCommand(
                            "UPDATE [Teacher] SET school = @school WHERE userID = @userID", conn))
                        {
                            cmd.Parameters.Add("@school", SqlDbType.NVarChar, 100).Value =
                                string.IsNullOrWhiteSpace(schoolName)
                                    ? (object)DBNull.Value
                                    : schoolName;
                            cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;
                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                LoadUserData();
                SetEditMode(false);
                ShowMessage("Your profile has been successfully updated.", true);
            }
            catch (Exception)
            {
                SaveFailed("Could not save your profile. Please try again.");
            }
        }

        protected void btnShowPassword_Click(object sender, EventArgs e)
        {
            ClearMessages();
            LoadUserData();
            SetEditMode(false);
            ClearPasswordFields();
            pnlPassword.Visible = true;
            btnShowPassword.Visible = false;
        }

        protected void btnCancelPassword_Click(object sender, EventArgs e)
        {
            ClearMessages();
            CloseePasswordPanel();
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string current = txtCurrentPassword.Text;
            string newPassword = txtNewPassword.Text;
            string confirm = txtConfirmPassword.Text;

            if (current == "" || newPassword == "" || confirm == "")
            {
                PasswordFailed("Please fill in all password fields.");
                return;
            }

            if (newPassword.Length < 8)
            {
                PasswordFailed("New password must be at least 8 characters.");
                return;
            }

            if (newPassword != confirm)
            {
                PasswordFailed("New password and confirmation do not match.");
                return;
            }

            if (newPassword == current)
            {
                PasswordFailed("New password must be different from the current one.");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnString))
                {
                    conn.Open();

                    string storedPassword;
                    using (SqlCommand cmd = new SqlCommand(
                        "SELECT [password] FROM [User] WHERE userID = @userID", conn))
                    {
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;
                        object result = cmd.ExecuteScalar();

                        if (result == null || result == DBNull.Value)
                        {
                            PasswordFailed("Could not find your account password.");
                            return;
                        }
                        storedPassword = result.ToString();
                    }

                    if (storedPassword != HashPassword(current))
                    {
                        PasswordFailed("Your current password is incorrect.");
                        return;
                    }

                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE [User] SET [password] = @password WHERE userID = @userID", conn))
                    {
                        cmd.Parameters.Add("@password", SqlDbType.NVarChar, 255).Value = HashPassword(newPassword);
                        cmd.Parameters.Add("@userID", SqlDbType.Int).Value = UserId;
                        cmd.ExecuteNonQuery();
                    }
                }

                CloseePasswordPanel();
                ShowPasswordMessage("Your password has been successfully updated.", true);
            }
            catch (Exception)
            {
                PasswordFailed("Could not update your password. Please try again.");
            }
        }

        // SHA-256 password hashing (kept compatible with the existing login)
        private static string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(bytes).Replace("-", "").ToLowerInvariant();
            }
        }

        private void CloseePasswordPanel()
        {
            ClearPasswordFields();
            pnlPassword.Visible = false;
            btnShowPassword.Visible = true;
        }

        private void ClearPasswordFields()
        {
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        private void ShowMessage(string message, bool success)
        {
            pageMessage.InnerText = message;
            pageMessage.Attributes["class"] = success ? "toast-message success" : "toast-message error";
            pageMessage.Visible = true;
        }

        private void ShowPasswordMessage(string message, bool success)
        {
            passwordMessage.InnerText = message;
            passwordMessage.Attributes["class"] = success ? "toast-message success" : "toast-message error";
            passwordMessage.Visible = true;
        }

        private void ClearMessages()
        {
            pageMessage.InnerText = "";
            pageMessage.Visible = false;
            passwordMessage.InnerText = "";
            passwordMessage.Visible = false;
        }

        // Profile save errors keep editing enabled
        private void SaveFailed(string message)
        {
            SetEditMode(true);
            ShowMessage(message, false);
        }

        // Password errors keep the form open
        private void PasswordFailed(string message)
        {
            ShowPasswordMessage(message, false);
            pnlPassword.Visible = true;
            btnShowPassword.Visible = false;
        }

        private static string GetInitials(string first, string last)
        {
            string a = string.IsNullOrWhiteSpace(first) ? "" : first.Trim().Substring(0, 1);
            string b = string.IsNullOrWhiteSpace(last) ? "" : last.Trim().Substring(0, 1);
            return (a + b).ToUpperInvariant();
        }
    }
}