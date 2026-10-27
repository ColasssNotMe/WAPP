using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;
using System.Web.SessionState;

namespace Assignment
{
    /// <summary>
    /// Email OTP flow shared by the Student Profile modal and the
    /// Forgot Password page.
    ///
    /// The code is kept in Session instead of the database because it only
    /// has to survive for the current browser session:
    ///   PwdOtp         -> the 6-digit code
    ///   PwdOtpEmail    -> the email the code was sent to
    ///   PwdOtpExpires  -> when it stops being valid (UTC)
    ///   PwdOtpAttempts -> wrong guesses so far
    ///   PwdOtpLastSent -> used to throttle "Get code"
    /// </summary>
    public static class OtpService
    {
        public const int ValidMinutes = 10;
        public const int ResendSeconds = 60;
        public const int MaxAttempts = 5;

        private const string KeyCode = "PwdOtp";
        private const string KeyEmail = "PwdOtpEmail";
        private const string KeyExpires = "PwdOtpExpires";
        private const string KeyAttempts = "PwdOtpAttempts";
        private const string KeyLastSent = "PwdOtpLastSent";

        private static HttpSessionState Session
        {
            get { return HttpContext.Current.Session; }
        }

        private static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString;
            }
        }

        public static bool EmailExists(string email)
        {
            if (string.IsNullOrWhiteSpace(email))
            {
                return false;
            }

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM [User] WHERE email = @email", conn))
            {
                cmd.Parameters.AddWithValue("@email", email.Trim());

                conn.Open();
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }

        public static bool RequestCode(string email, out string message)
        {
            email = (email ?? string.Empty).Trim();

            if (string.IsNullOrEmpty(email))
            {
                message = "Please enter your registered email address.";
                return false;
            }

            if (!EmailExists(email))
            {
                message = "That email is not registered to an account.";
                return false;
            }

            object lastSent = Session[KeyLastSent];

            if (lastSent != null)
            {
                double elapsed =
                    (DateTime.UtcNow - Convert.ToDateTime(lastSent)).TotalSeconds;

                if (elapsed < ResendSeconds)
                {
                    int wait = ResendSeconds - (int)elapsed;
                    message = "Please wait " + wait +
                              " seconds before requesting another code.";
                    return false;
                }
            }

            string code = GenerateCode();

            try
            {
                SendEmail(email, code);
            }
            catch (Exception)
            {
                message = "We could not send the email right now. Please try again later.";
                return false;
            }

            Session[KeyCode] = code;
            Session[KeyEmail] = email;
            Session[KeyExpires] = DateTime.UtcNow.AddMinutes(ValidMinutes);
            Session[KeyAttempts] = 0;
            Session[KeyLastSent] = DateTime.UtcNow;

            message = "A 6-digit code was sent to " + email +
                      ". It expires in " + ValidMinutes + " minutes.";
            return true;
        }

        public static bool VerifyCode(string email, string enteredCode, out string error)
        {
            error = null;

            string storedCode = Convert.ToString(Session[KeyCode]);
            string storedEmail = Convert.ToString(Session[KeyEmail]);
            object expires = Session[KeyExpires];

            if (string.IsNullOrEmpty(storedCode) ||
                string.IsNullOrEmpty(storedEmail) ||
                expires == null)
            {
                error = "Request a verification code first.";
                return false;
            }

            if (DateTime.UtcNow > Convert.ToDateTime(expires))
            {
                Clear();
                error = "The verification code has expired. Request a new one.";
                return false;
            }

            if (!string.Equals((email ?? string.Empty).Trim(), storedEmail,
                               StringComparison.OrdinalIgnoreCase))
            {
                error = "The email changed. Request a new code for this address.";
                return false;
            }

            if (!string.Equals((enteredCode ?? string.Empty).Trim(), storedCode,
                               StringComparison.Ordinal))
            {
                int attempts = Convert.ToInt32(Session[KeyAttempts] ?? 0) + 1;

                if (attempts >= MaxAttempts)
                {
                    Clear();
                    error = "Too many incorrect attempts. Request a new code.";
                }
                else
                {
                    Session[KeyAttempts] = attempts;
                    error = "The verification code is incorrect. " +
                            (MaxAttempts - attempts) + " attempt(s) left.";
                }

                return false;
            }

            Clear();
            return true;
        }

        public static void UpdatePassword(string email, string plainTextPassword)
        {
            PasswordManager passwordManager = new PasswordManager();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE [User] SET password = @password WHERE email = @email", conn))
            {
                cmd.Parameters.AddWithValue(
                    "@password", passwordManager.HashPassword(plainTextPassword));

                cmd.Parameters.AddWithValue("@email", (email ?? string.Empty).Trim());

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static void Clear()
        {
            Session.Remove(KeyCode);
            Session.Remove(KeyEmail);
            Session.Remove(KeyExpires);
            Session.Remove(KeyAttempts);
            Session.Remove(KeyLastSent);
        }

        private static string GenerateCode()
        {
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                byte[] bytes = new byte[4];
                rng.GetBytes(bytes);

                uint value = BitConverter.ToUInt32(bytes, 0) % 1000000u;
                return value.ToString("D6");
            }
        }

        private static void SendEmail(string toEmail, string code)
        {
            string host = ConfigurationManager.AppSettings["SmtpHost"];
            string portValue = ConfigurationManager.AppSettings["SmtpPort"];
            string user = ConfigurationManager.AppSettings["SmtpUser"];
            string password = ConfigurationManager.AppSettings["SmtpPassword"];

            if (string.IsNullOrWhiteSpace(fromAddress))
            {
                fromAddress = user;
            }

            if (string.IsNullOrWhiteSpace(host) ||
                string.IsNullOrWhiteSpace(user) ||
                string.IsNullOrWhiteSpace(password))
            {
                throw new InvalidOperationException("SMTP settings are not configured.");
            }

            int port = 587;
            int.TryParse(portValue, out port);

            string body =
                "<p>Hello,</p>" +
                "<p>Your Ncient password change code is:</p>" +
                "<p style=\"font-size:24px;font-weight:bold;letter-spacing:4px;\">" +
                code + "</p>" +
                "<p>This code expires in " + ValidMinutes + " minutes. " +
                "If you did not request this, you can ignore this email.</p>";

            using (MailMessage message = new MailMessage(
                fromAddress, toEmail, "Ncient - Your password change code", body))
            using (SmtpClient client = new SmtpClient(host, port))
            {
                message.IsBodyHtml = true;

                client.EnableSsl = true;
                client.UseDefaultCredentials = false;
                client.Credentials = new NetworkCredential(user, password);

                client.Send(message);
            }
        }
    }
}
