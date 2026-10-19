using System;

namespace Assignment
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            welcomeTitle.InnerText = "Welcome, " + Session["username"] + "!";
        }
    }
}