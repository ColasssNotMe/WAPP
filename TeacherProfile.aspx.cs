using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class TeacherProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                txtUsername.Text = Session["username"]?.ToString() ?? "";
                usernameDisplay.InnerText = Session["username"]?.ToString() ?? "";
                txtEmail.Text = Session["email"]?.ToString() ?? "";
                txtRole.Text = Session["role"]?.ToString() ?? "Teacher";

                string profilePicUrl = Session["profilePic"]?.ToString() ?? "~/svg/user.svg";
                profilePic.ImageUrl = profilePicUrl;

                LoadTeacherProfile();
            }
        }

        private void LoadTeacherProfile()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                SELECT
                    u.userID,
                    u.username,
                    u.role,
                    u.firstName,
                    u.lastName,
                    u.email,
                    u.dateRegistered,
                    t.school
                FROM [User] u
                LEFT JOIN Teacher t ON u.userID = t.userID
                WHERE u.userID = @userId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtFirstName.Text = reader["firstName"] != DBNull.Value ? reader["firstName"].ToString() : "";
                            txtLastName.Text = reader["lastName"] != DBNull.Value ? reader["lastName"].ToString() : "";
                            txtUsername.Text = reader["username"] != DBNull.Value ? reader["username"].ToString() : "";
                            txtEmail.Text = reader["email"] != DBNull.Value ? reader["email"].ToString() : "";
                            txtRole.Text = reader["role"] != DBNull.Value ? reader["role"].ToString() : "Teacher";

                            string schoolValue = reader["school"] != DBNull.Value ? reader["school"].ToString() : "";

                            // Safe dropdown selection
                            ListItem schoolItem = txtSchool.Items.FindByValue(schoolValue);
                            if (schoolItem != null)
                            {
                                txtSchool.SelectedValue = schoolValue;
                            }
                            else if (!string.IsNullOrEmpty(schoolValue))
                            {
                                txtSchool.Items.Add(new ListItem(schoolValue, schoolValue));
                                txtSchool.SelectedValue = schoolValue;
                            }
                            else
                            {
                                txtSchool.SelectedIndex = 0;
                            }

                            usernameDisplay.InnerText = reader["username"].ToString();
                            accountUsername.InnerText = reader["username"].ToString();
                            accountRole.InnerText = reader["role"].ToString();
                            accountSchool.InnerText = string.IsNullOrEmpty(schoolValue) ? "—" : schoolValue;

                            if (reader["dateRegistered"] != DBNull.Value)
                            {
                                DateTime dateRegistered = Convert.ToDateTime(reader["dateRegistered"]);
                                accountDateRegistered.InnerText = dateRegistered.ToString("MMMM yyyy");
                            }
                            else
                            {
                                accountDateRegistered.InnerText = "—";
                            }
                        }
                    }
                }
            }
        }

        private void SaveProfile()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                UPDATE [User]
                SET
                    firstName = @firstName,
                    lastName = @lastName,
                    username = @username,
                    email = @email
                WHERE userID = @userId;

                IF EXISTS (SELECT 1 FROM Teacher WHERE userID = @userId)
                BEGIN
                    UPDATE Teacher
                    SET school = @school
                    WHERE userID = @userId;
                END
                ELSE
                BEGIN
                    INSERT INTO Teacher (userID, school)
                    VALUES (@userId, @school);
                END";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@firstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@lastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@school", txtSchool.SelectedValue.Trim());
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["username"] = txtUsername.Text.Trim();
            Session["email"] = txtEmail.Text.Trim();

            usernameDisplay.InnerText = txtUsername.Text.Trim();
            accountUsername.InnerText = txtUsername.Text.Trim();

            LoadTeacherProfile();
        }

        private void SaveProfileImage()
        {
            if (!ProfileImageUpload.HasFile)
            {
                return;
            }

            string folderPath = Server.MapPath("~/userImage/");
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName = Path.GetFileName(ProfileImageUpload.FileName);
            string filePath = Path.Combine(folderPath, fileName);

            ProfileImageUpload.SaveAs(filePath);

            string imageUrl = "~/userImage/" + fileName;
            profilePic.ImageUrl = imageUrl;

            string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            string query = "UPDATE [User] SET profilePic = @profilePic WHERE userID = @userId;";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@profilePic", imageUrl);
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            Session["profilePic"] = imageUrl;
        }

        private void ShowSaveError(string message)
        {
            saveResult.InnerText = message;
            saveResult.Attributes["class"] = "save-result error";
            saveResult.Visible = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int currentUserId = Convert.ToInt32(Session["userId"]);
                string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string checkUsernameQuery = @"
                        SELECT COUNT(*)
                        FROM [User]
                        WHERE username = @username
                          AND userID != @userId";

                    using (SqlCommand cmd = new SqlCommand(checkUsernameQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                        cmd.Parameters.AddWithValue("@userId", currentUserId);

                        int usernameCount = Convert.ToInt32(cmd.ExecuteScalar());

                        if (usernameCount > 0)
                        {
                            ShowSaveError("This username is already taken.");
                            return;
                        }
                    }

                    const string checkEmailQuery = @"
                        SELECT COUNT(*)
                        FROM [User]
                        WHERE email = @email
                          AND userID != @userId";

                    using (SqlCommand cmd = new SqlCommand(checkEmailQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@userId", currentUserId);

                        int emailCount = Convert.ToInt32(cmd.ExecuteScalar());

                        if (emailCount > 0)
                        {
                            ShowSaveError("This email is already registered.");
                            return;
                        }
                    }
                }

                SaveProfile();
                SaveProfileImage();
                ChangePassword();

                saveResult.InnerText = "Profile updated successfully.";
                saveResult.Attributes["class"] = "save-result success";
                saveResult.Visible = true;
            }
            catch (Exception ex)
            {
                ShowSaveError("Error updating profile: " + ex.Message);
            }
        }

        private void ChangePassword()
        {
            string newPassword = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(newPassword))
                return;

            PasswordManager passwordManager = new PasswordManager();
            string hashedPassword = passwordManager.HashPassword(newPassword);

            string connectionString = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            string query = "UPDATE [User] SET password = @password WHERE userID = @userId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@password", hashedPassword);
                cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void btnDiscard_Click(object sender, EventArgs e)
        {
            LoadTeacherProfile();
            saveResult.Visible = false;
        }
    }
}