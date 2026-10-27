using System;

namespace Assignment
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"] != null)
            {
                headerActions.Visible = false;
                headerProfile.Visible = true;
                //roleDebug.Text = Session["role"]?.ToString();

                string profilePath = Session["profilePic"]?.ToString();
                if (string.IsNullOrWhiteSpace(profilePath))
                {
                    profilePath = "svg/user.svg";
                }

                profilePic.Src = ResolveUrl(profilePath);

                if (Session["role"]?.ToString().ToLower().Trim() == "admin")
                {
                    dashboardButton.Visible = true;
                    dashboardButton.HRef = "AdminDashboard.aspx";
                }
                else if (Session["role"]?.ToString().ToLower().Trim() == "teacher")
                {
                    dashboardButton.Visible = true;
                    dashboardButton.HRef = "TeacherDashboard.aspx";
                    classroomButton.HRef = "MyClasses.aspx";
                }
                else if (Session["role"]?.ToString().ToLower().Trim() == "student")
                {
                    dashboardButton.Visible = true;
                    dashboardButton.HRef = "StudentDashboard.aspx";
                    classroomButton.HRef = "StudentClassroom.aspx";
                }
                classroomButton.Visible = true;
            }
            else
            {
                headerActions.Visible = true;
                headerProfile.Visible = false;
                dashboardButton.Visible = false;
                classroomButton.Visible = false;
                //roleDebug.Text = Session["role"]?.ToString();
            }
        }

        protected void DashboardButton_Click(object sender, EventArgs e)
        {
            string role = Session["role"]?.ToString()?.ToLower().Trim();
            if (role == "admin")
            {
                Response.Redirect("AdminDashboard.aspx");
            }
            else if (role == "teacher")
            {
                Response.Redirect("TeacherDashboard.aspx");
            }
            else if (role == "student")
            {
                Response.Redirect("StudentDashboard.aspx");
            }
            else
            {
                Response.Redirect("HomePage");
            }
        }

        protected void ProfileButton_Click(object sender, EventArgs e)
        {
            string role = Session["role"]?.ToString()?.ToLower().Trim();

            if (role == "admin")
            {
                Response.Redirect("AdminProfile.aspx");
            }
            else if (role == "teacher")
            {
                Response.Redirect("TeacherProfile.aspx");
            }
            else if (role == "student")
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