using System;

namespace Assignment
{
    public partial class LiveSession : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            presentationFrame.Attributes["src"] = "https://meet.jit.si/ncientClass_" + Session["sessionID"].ToString();
        }
    }
}