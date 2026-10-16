using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RoleRadioList_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (RoleRadioList.SelectedValue == "Teacher")
            {
                FormPanel.Style["visibility"] = "hidden";
                FormRequired.Enabled = false;
            }
            else
            {
                FormPanel.Style["visibility"] = "visible";
                FormRequired.Enabled = true;
            }
        }
        protected void CreateAccountButton_Click(object sender, EventArgs e)
        {
            System.Data.SqlClient.SqlConnection conn =
                new System.Data.SqlClient.SqlConnection(
                    ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString
                );
            conn.Open();

            string query = "SELECT count(*) FROM [User] WHERE Email=@email";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());
            int count = Convert.ToInt32(cmd.ExecuteScalar());


            if (count > 0)
            {
                errMsg.Text = "This email is already registered.";
                errMsg.CssClass = "signup-message error";
                return;
            }
            else
            {
                string query1 = @"
    INSERT INTO [User]
    (username, email, password, firstName, lastName, role, profilePic, dateRegistered)
    VALUES
    (@username, @email, @password, @firstName, @lastName, @role, @profilePic, @dateRegistered)";

                SqlCommand cmd1 = new SqlCommand(query1, conn);
                    cmd1.Parameters.AddWithValue("@username", UsernameTextBox.Text.Trim());
                    cmd1.Parameters.AddWithValue("@email", EmailTextBox.Text.Trim());
                    cmd1.Parameters.AddWithValue("@password", PasswordTextBox.Text);
                    cmd1.Parameters.AddWithValue("@firstName", FirstNameTextBox.Text.Trim());
                    cmd1.Parameters.AddWithValue("@lastName", LastNameTextBox.Text.Trim());
                    cmd1.Parameters.AddWithValue("@role", RoleRadioList.SelectedValue);
                    cmd1.Parameters.AddWithValue("@profilePic", null);
                    cmd1.Parameters.AddWithValue("@dateRegistered", DateTime.Now);

                    cmd1.ExecuteNonQuery();
                Response.Redirect("HomePage.aspx");
            }

        }
    }
}