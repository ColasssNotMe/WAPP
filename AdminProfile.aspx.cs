using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            private void loadUserData {

                const SqlCommand = "SELECT * FROM User WHERE userID = @userID";

                try {
                    
                } catch (Exception ex) {
                    ShowErrorMessage("An error occurred while loading user data: " + ex.Message);
    }
            }
        }
    }
}