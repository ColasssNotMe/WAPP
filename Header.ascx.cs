using System;

namespace Assignment
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            //logged in
            {
                headerActions.Style["visibility"] = "hidden";
                headerProfile.Style["visibility"] = "visible";
                roleDebug.Text = Session["role"]?.ToString();
                if (Session["role"]?.ToString().ToLower().Trim() == "admin")
                {
                    dashboardButton.Style["visibility"] = "visible";
                    dashboardButton.HRef = "AdminDashboard.aspx";
                }
                else if (Session["role"]?.ToString().ToLower().Trim() == "teacher")
                {
                    dashboardButton.Style["visibility"] = "visible";
                    dashboardButton.HRef = "TeacherDashboard.aspx";
                }
                else if (Session["role"]?.ToString().ToLower().Trim() == "student")
                {
                    dashboardButton.Style["visibility"] = "visible";
                    dashboardButton.HRef = "StudentDashboard.aspx";
                }
            }
            else
            {
                headerActions.Style["visibility"] = "visible";
                headerProfile.Style["visibility"] = "hidden";
                dashboardButton.Style["visibility"] = "hidden";
                roleDebug.Text = Session["role"]?.ToString();
            }
        }



    }
}