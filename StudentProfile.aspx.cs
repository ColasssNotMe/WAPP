using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

namespace Assignment
{
    public partial class StudentProfile : System.Web.UI.Page
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
                txtRole.Text = Session["role"]?.ToString() ?? "Student";

                string profilePicUrl =
                    Session["profilePic"]?.ToString() ?? "~/svg/user.svg";

                profilePic.ImageUrl = profilePicUrl;

                LoadStudentProfile();
            }

        }

        private void LoadStudentProfile()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                SELECT
                    u.userId,
                    u.username,
                    u.role,
                    u.firstName,
                    u.lastName,
                    u.email,
                    u.dateRegistered,
                    s.gradeLevel,
                    s.school
                FROM [User] u
                INNER JOIN Student s
                    ON u.userId = s.userId
                WHERE u.userId = @userId";

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
                            txtFirstName.Text = reader["firstName"].ToString();
                            txtLastName.Text = reader["lastName"].ToString();
                            txtUsername.Text = reader["username"].ToString();
                            txtEmail.Text = reader["email"].ToString();
                            txtRole.Text = reader["role"].ToString();
                            txtGrade.Text = reader["gradeLevel"].ToString();
                            txtSchool.Text = reader["school"].ToString();
                            accountUserId.InnerText = reader["userId"].ToString();
                            accountUsername.InnerText = reader["username"].ToString();
                            accountRole.InnerText = reader["role"].ToString();
                            accountSchool.InnerText = reader["school"].ToString();

                            if (reader["dateRegistered"] != DBNull.Value)
                            {
                                DateTime dateRegistered =
                                    Convert.ToDateTime(reader["dateRegistered"]);

                                accountDateRegistered.InnerText =
                                    dateRegistered.ToString("MMMM yyyy");
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
            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                UPDATE [User]
                SET
                    firstName = @firstName,
                    lastName = @lastName,
                    username = @username,
                    email = @email
                WHERE userId = @userId;

                UPDATE Student
                SET
                    gradeLevel = @gradeLevel,
                    school = @school
                WHERE userId = @userId;
            ";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@firstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@lastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@gradeLevel", txtGrade.Text.Trim());
                    cmd.Parameters.AddWithValue("@school", txtSchool.Text.Trim());
                    cmd.Parameters.AddWithValue("@userId", Session["userId"]);

                    conn.Open();

                    cmd.ExecuteNonQuery();
                }
            }



            Session["username"] = txtUsername.Text.Trim();
            Session["email"] = txtEmail.Text.Trim();

            usernameDisplay.InnerText =
                txtUsername.Text.Trim();

            accountUsername.InnerText =
                txtUsername.Text.Trim();

            LoadStudentProfile();
        }

        private void SaveProfileImage()
        {
            if (!ProfileImageUpload.HasFile)
            {
                return;
            }

            string folderPath =
                Server.MapPath("~/userImage/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            string fileName =
                Path.GetFileName(ProfileImageUpload.FileName);

            string extension =
                Path.GetExtension(fileName).ToLower();

            string[] allowedExtensions =
            {
                ".jpg",
                ".jpeg",
                ".png",
                ".gif",
                ".webp"
            };

            string filePath =
                Path.Combine(folderPath, fileName);

            ProfileImageUpload.SaveAs(filePath);

            string imageUrl = "~/userImage/" + fileName;

            profilePic.ImageUrl = imageUrl;


            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

            string query = @"
                UPDATE [User]
                SET
                    profilePic = @profilePic
                WHERE userId = @userId; ";

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
                string connectionString =
                    ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;

                using (SqlConnection conn =
                       new SqlConnection(connectionString))
                {
                    conn.Open();

                    const string checkUsernameQuery = @"
                        SELECT COUNT(*)
                        FROM [User]
                        WHERE username = @username
                          AND userId != @userId";

                    using (SqlCommand cmd =
                           new SqlCommand(checkUsernameQuery, conn))
                    {
                        cmd.Parameters.Add("@username", System.Data.SqlDbType.NVarChar, 40).Value =
                            txtUsername.Text.Trim();
                        cmd.Parameters.Add("@userId", System.Data.SqlDbType.Int).Value =
                            currentUserId;

                        int usernameCount =
                            Convert.ToInt32(cmd.ExecuteScalar());

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
                          AND userId != @userId";

                    using (SqlCommand cmd =
                           new SqlCommand(checkEmailQuery, conn))
                    {
                        cmd.Parameters.Add("@email", System.Data.SqlDbType.NVarChar, 100).Value =
                            txtEmail.Text.Trim();
                        cmd.Parameters.Add("@userId", System.Data.SqlDbType.Int).Value =
                            currentUserId;

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

                saveResult.InnerText =
                    "Profile updated successfully.";

                saveResult.Attributes["class"] =
                    "save-result success";

                saveResult.Visible = true;
            }
            catch (Exception ex)
            {
                ShowSaveError("Error updating profile: " + ex.Message);
            }
        }
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string newPassword = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(newPassword))
            {
                saveResult.InnerText =
                    "Please enter a password.";

                saveResult.Attributes["class"] =
                    "save-result error";

                saveResult.Visible = true;

                return;
            }

            if (newPassword.Length < 8)
            {
                saveResult.InnerText =
                    "Password must be at least 8 characters long.";

                saveResult.Attributes["class"] =
                    "save-result error";

                saveResult.Visible = true;

                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            string query = @"
                UPDATE [User]
                SET
                    password = @password
                WHERE userId = @userId;
            ";
            PasswordManager passwordManager = new PasswordManager();
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue(
                        "@password",
                        passwordManager.HashPassword(newPassword));
                    cmd.Parameters.AddWithValue(
                        "@userId",
                        Session["userId"]);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            saveResult.InnerText =
                "Profile updated successfully.";
            saveResult.Attributes["class"] =
                "save-result success";
            saveResult.Visible = true;
        }
    }
}