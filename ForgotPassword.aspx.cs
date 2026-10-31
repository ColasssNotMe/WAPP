using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        private bool IsPasswordStrong(string password)
        {
            bool hasUppercase = Regex.IsMatch(password, @"[A-Z]");
            bool hasLowercase = Regex.IsMatch(password, @"[a-z]");
            bool hasNumber = Regex.IsMatch(password, @"[0-9]");
            bool hasSymbol = Regex.IsMatch(password, @"[^a-zA-Z0-9]");
            return hasUppercase && hasLowercase && hasNumber && hasSymbol;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("HomePage.aspx");
            }
        }

        // send OTP
        protected void btnSendOTP_Click(object sender, EventArgs e) {
            string email = txtEmail.Text.Trim();
            // 1. Verify user exists in database
            if (!UserExists(email))
            {
                lblMessageStep1.Text = "No account found with this email address.";
                return;
            }
            // 2. Generate 6-digit OTP
            string otp = GenerateOTP();

            // 3. Send via SMTP (smtp4dev)
            if (SendOTPEmail(email, otp))
            {
                // Store in session with 5 minutes expiry
                Session["ResetEmail"] = email;
                Session["ResetOTP"] = otp;
                Session["ResetOTPExpiry"] = DateTime.Now.AddMinutes(5);
                litSentToEmail.Text = email;
                ResetMultiView.SetActiveView(ViewOTP);
            }
            else
            {
                lblMessageStep1.Text = "Unable to send verification email. Please try again later.";
            }
        }

        //verify OTP
        protected void btnVerifyOTP_Click(object sender, EventArgs e) {
            if (Session["ResetOTP"] == null || Session["ResetOTPExpiry"] == null)
            {
                lblMessageStep2.Text = "Your verification session has expired. Please try again.";
                return;
            }
            DateTime expiry = (DateTime)Session["ResetOTPExpiry"];
            if (DateTime.Now > expiry)
            {
                lblMessageStep2.Text = "The code has expired. Click 'Resend' to get a new one.";
                return;
            }
            string enteredOtp = txtOTP.Text.Trim();
            string expectedOtp = Session["ResetOTP"].ToString();
            if (enteredOtp == expectedOtp)
            {
                // OTP matches! Move to Step 3: Set new password
                ResetMultiView.SetActiveView(ViewNewPassword);
            }
            else
            {
                lblMessageStep2.Text = "Incorrect verification code. Please check your email and try again.";
            }
        }
        protected void btnResendOTP_Click(object sender, EventArgs e) {
            string email = Session["ResetEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                ResetMultiView.SetActiveView(ViewEmail);
                return;
            }
            string newOtp = GenerateOTP();
            Session["ResetOTP"] = newOtp;
            Session["ResetOTPExpiry"] = DateTime.Now.AddMinutes(5);
            if (SendOTPEmail(email, newOtp))
            {
                lblMessageStep2.ForeColor = System.Drawing.Color.Green;
                lblMessageStep2.Text = "A new verification code has been sent.";
            }
            else
            {
                lblMessageStep2.ForeColor = System.Drawing.Color.Red;
                lblMessageStep2.Text = "Failed to resend code. Please try again later.";
            }
        }
        protected void btnChangeEmail_Click(object sender, EventArgs e) {
            Session.Remove("ResetOTP");
            Session.Remove("ResetOTPExpiry");
            ResetMultiView.SetActiveView(ViewEmail);
        }

        //save new password
        protected void btnSavePassword_Click(object sender, EventArgs e) {
            string email = Session["ResetEmail"]?.ToString();
            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("Login.aspx");
                return;
            }
            string newPassword = txtNewPassword.Text.Trim();
            if (!IsPasswordStrong(newPassword))
            {
                lblMessageStep3.Text = "Password does not meet the requirements.";
                return;
            }
            if (newPassword != txtConfirmPassword.Text.Trim())
            {
                lblMessageStep3.Text = "Passwords do not match.";
                return;
            }
            // Hash the password using your existing PasswordManager (BCrypt)
            PasswordManager pm = new PasswordManager();
            string hashedPassword = pm.HashPassword(newPassword);
            string connStr = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE [User] SET password = @newPassword WHERE email = @email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@newPassword", hashedPassword);
                    cmd.Parameters.AddWithValue("@email", email);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            // Cleanup session
            Session.Remove("ResetEmail");
            Session.Remove("ResetOTP");
            Session.Remove("ResetOTPExpiry");
            // Redirect to login page so user can log in with new password
            Response.Redirect("Login.aspx");
        }

        //helper method
        private bool UserExists(string email)
        {
            string connStr = ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(1) FROM [User] WHERE email = @email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@email", email);
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }
        private string GenerateOTP()
        {
            using (var rng = RandomNumberGenerator.Create())
            {
                byte[] bytes = new byte[4];
                uint value;
                do
                {
                    rng.GetBytes(bytes);
                    value = BitConverter.ToUInt32(bytes, 0);
                } while (value >= 4294500000U);
                return (100000 + value % 900000).ToString();
            }
        }
        private bool SendOTPEmail(string toEmail, string otp)
        {
            try
            {
                using (MailMessage mail = new MailMessage())
                {
                    mail.To.Add(toEmail);
                    mail.Subject = $"{otp} is your Ncient account verification code";
                    mail.IsBodyHtml = false;
                    mail.Body =
$@"Hi,
We received a request to reset your password for your Ncient Education account ({toEmail}).
Your verification code is:
{otp}
This code is valid for 5 minutes. For your security, never share this code with anyone.
If you didn't request a password reset, you can safely ignore this email. Your account remains secure.
Thank you,
The Ncient Security Team
---
This is an automated message, please do not reply to this email.";
                    using (SmtpClient smtp = new SmtpClient())
                    {
                        smtp.Send(mail);
                    }
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}