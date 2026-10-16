using System;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Login : System.Web.UI.Page
    {

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {
            if (EmailTextBox.Text=="admin@company.com" && PasswordTextBox.Text=="password")
            {
                Session["email"] = EmailTextBox.Text;
                Session["username"] = username.Text;
                Session["userId"] = 1;
                Response.Redirect("Dashboard.aspx");
            }
        }
    }
}