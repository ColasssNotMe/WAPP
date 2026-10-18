using System;

namespace Assignment
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["username"]!=null)
//logged in
            {
                headerActions.Style["visibility"] = "hidden";
                headerProfile.Style["visibility"] = "visible";
                roleDebug.Text = Session["role"]?.ToString();
            }
            else
            {
                headerActions.Style["visibility"] = "visible";
                headerProfile.Style["visibility"] = "hidden";
                roleDebug.Text = Session["role"]?.ToString();
            }
        }



    }
}