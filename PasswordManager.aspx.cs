using System;

namespace Assignment
{
    public partial class PasswordManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public bool VerifyPassword(string plainTextPassword, string hashedPassword)
        {
            return BCrypt.Net.BCrypt.Verify(plainTextPassword, hashedPassword);
        }
        public string HashPassword(string plainTextPassword)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword(plainTextPassword);
            return hashedPassword;
        }
    }
}