using System;

namespace Assignment
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnGetCode_Click(object sender, EventArgs e)
        {
            InfoMessage.Visible = false;
            ErrorMessage.Visible = false;
            SuccessMessage.Visible = false;

            if (!Page.IsValid)
            {
                return;
            }

            string message;
            bool sent = OtpService.RequestCode(EmailTextBox.Text, out message);

            if (sent)
            {
                InfoMessage.Text = message;
                InfoMessage.Visible = true;
            }
            else
            {
                ErrorMessage.Text = message;
                ErrorMessage.Visible = true;
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            InfoMessage.Visible = false;
            ErrorMessage.Visible = false;
            SuccessMessage.Visible = false;

            if (!Page.IsValid)
            {
                return;
            }

            string email = EmailTextBox.Text.Trim();
            string newPassword = NewPasswordTextBox.Text;
            string confirmPassword = ConfirmPasswordTextBox.Text;

            if (newPassword != confirmPassword)
            {
                ShowError("The two passwords do not match.");
                return;
            }

            string error;

            if (!OtpService.VerifyCode(email, OtpTextBox.Text, out error))
            {
                ShowError(error);
                return;
            }

            OtpService.UpdatePassword(email, newPassword);

            EmailTextBox.Enabled = false;
            OtpTextBox.Enabled = false;
            NewPasswordTextBox.Enabled = false;
            ConfirmPasswordTextBox.Enabled = false;

            btnGetCode.Enabled = false;
            btnChangePassword.Visible = false;

            SuccessMessage.Text =
                "Your password has been changed. You can now sign in with the new password.";
            SuccessMessage.Visible = true;
        }

        private void ShowError(string message)
        {
            ErrorMessage.Text = message;
            ErrorMessage.Visible = true;
        }
    }
}
