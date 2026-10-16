using System;
using System.Configuration;
using System.Data.SqlClient;
namespace Assignment
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void SignInButton_Click(object sender, EventArgs e)
        {

            System.Data.SqlClient.SqlConnection conn =
                new System.Data.SqlClient.SqlConnection(
                    ConfigurationManager.ConnectionStrings["WAPP"].ConnectionString
                );
            conn.Open();

            string query = "SELECT * FROM Users WHERE Email=" + EmailTextBox.Text + " AND Password=" + PasswordTextBox.Text;

            SqlCommand cmd = new SqlCommand(query, conn);

            int count = Convert.ToInt32(cmd.ExecuteScalar().ToString());


            if (EmailTextBox.Text == "admin@company.com" && PasswordTextBox.Text == "password")
            {
                Session["email"] = EmailTextBox.Text;
                Session["username"] = "admin";
                Session["userId"] = 0;
                Response.Redirect("Dashboard.aspx");
            }

            if (count > 0)
            {
                SqlCommand cmdType = new SqlCommand("select username, userId from Users where Email='" + EmailTextBox.Text + "' and Password='" + PasswordTextBox.Text + "'", conn);
                SqlDataReader reader = cmdType.ExecuteReader();
                if (reader.Read())
                {
                    Session["email"] = EmailTextBox.Text;
                    Session["username"] = reader["username"].ToString();
                    Session["userId"] = reader["userId"].ToString();
                    Response.Redirect("Dashboard.aspx");
                }
            }

        }
    }
}