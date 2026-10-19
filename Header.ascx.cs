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

                string profilePath = Session["profilePic"]?.ToString();
                if (string.IsNullOrWhiteSpace(profilePath))
                {
                    profilePath = "svg/user.svg";
                }

                profilePic.Src = ResolveUrl("~/" + profilePath);


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


        protected void ProfileButton_Click(object sender, EventArgs e)
        {
            string role = Session["role"]?.ToString()?.ToLower().Trim();

            if (role=="admin")
            {
                Response.Redirect("AdminProfile.aspx");
            }else if (role=="teacher")
            {
                Response.Redirect("TeacherProfile.aspx");
            }else if (role =="student")
            {
                Response.Redirect("StudentProfile.aspx");
            }
            else
            {
                Response.Redirect("HomePage"); 
            }

        }
        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }


    }
}