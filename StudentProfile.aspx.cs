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
            // Check whether user is logged in
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
                txtOtpEmail.Text = Session["email"]?.ToString() ?? "";
                txtRole.Text = Session["role"]?.ToString() ?? "Student";

                string profilePicUrl =
                    Session["profilePic"]?.ToString() ?? "~/svg/user.svg";

                profilePic.ImageUrl = profilePicUrl;
            }

            LoadStudentProfile();
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
                    cmd.Parameters.AddWithValue(
                        "@firstName",
                        txtFirstName.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@lastName",
                        txtLastName.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@username",
                        txtUsername.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@email",
                        txtEmail.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@gradeLevel",
                        txtGrade.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@school",
                        txtSchool.Text.Trim());

                    cmd.Parameters.AddWithValue(
                        "@userId",
                        Session["userId"]);

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

            Session["profilePic"] = imageUrl;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
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
                saveResult.InnerText =
                    "Error updating profile: " + ex.Message;

                saveResult.Attributes["class"] =
                    "save-result error";

                saveResult.Visible = true;
            }
        }

        // =========================================================
        // CHANGE PASSWORD (EMAIL OTP)
        // The OTP generation / sending / verification lives in OtpService
        // so the Login > Forgot Password page can reuse it.
        // =========================================================

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            lblOtpInfo.Text = "";
            lblPasswordError.Text = "";

            // Start from the account's own registered email.
            txtOtpEmail.Text = Session["email"]?.ToString() ?? txtEmail.Text.Trim();
            txtOtp.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            ShowPasswordModal();
        }

        protected void btnClosePasswordModal_Click(object sender, EventArgs e)
        {
            HidePasswordModal();
        }

        protected void btnGetCode_Click(object sender, EventArgs e)
        {
            ShowPasswordModal();

            lblOtpInfo.Text = "";
            lblPasswordError.Text = "";

            string message;
            OtpService.RequestCode(txtOtpEmail.Text, out message);
            lblOtpInfo.Text = message;
        }

        protected void btnSubmitPasswordChange_Click(object sender, EventArgs e)
        {
            ShowPasswordModal();
            lblPasswordError.Text = "";

            string email = txtOtpEmail.Text.Trim();
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            // Check the password rules first so a valid code is not wasted.
            if (newPassword.Length < 8)
            {
                lblPasswordError.Text =
                    "The new password must be at least 8 characters long.";
                return;
            }

            if (newPassword != confirmPassword)
            {
                lblPasswordError.Text = "The two passwords do not match.";
                return;
            }

            string error;

            if (!OtpService.VerifyCode(email, txtOtp.Text, out error))
            {
                lblPasswordError.Text = error;
                return;
            }

            OtpService.UpdatePassword(email, newPassword);

            HidePasswordModal();

            txtOtp.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            saveResult.InnerText =
                "Password changed successfully. Use the new password next time you sign in.";
            saveResult.Attributes["class"] = "save-result success";
            saveResult.Visible = true;
        }

        private void ShowPasswordModal()
        {
            pnlPasswordModal.Style["display"] = "flex";
        }

        private void HidePasswordModal()
        {
            pnlPasswordModal.Style["display"] = "none";
        }

    }
}