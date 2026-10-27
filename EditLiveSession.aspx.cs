using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Assignment
{
    public partial class EditLiveSession : System.Web.UI.Page
    {
        private string ConnectionString
        {
            get
            {
                return ConfigurationManager
                    .ConnectionStrings["WAPP"]
                    .ConnectionString;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string sessionID = Session["sessionID"]?.ToString();

                if (string.IsNullOrEmpty(sessionID))
                {
                    Response.Redirect("LiveSessionManagement.aspx");
                    return;
                }

                LoadClasses();
                LoadSession(sessionID);
            }
        }

        private void LoadClasses()
        {
            string query = @"
                SELECT classID
                FROM Class
                ORDER BY classID ASC";

            using (SqlConnection conn =
                new SqlConnection(ConnectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            using (SqlDataAdapter da =
                new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();

                da.Fill(dt);

                ddlClass.DataSource = dt;

                ddlClass.DataTextField = "classID";
                ddlClass.DataValueField = "classID";

                ddlClass.DataBind();
            }
        }

        private void LoadSession(string sessionID)
        {
            string query = @"
                SELECT
                    sessionID,
                    classID,
                    title,
                    starttime,
                    endtime
                FROM LiveSession
                WHERE sessionID = @sessionID";

            using (SqlConnection conn =
                new SqlConnection(ConnectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@sessionID",
                    sessionID);

                conn.Open();

                using (SqlDataReader reader =
                    cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        txtTitle.Text =
                            reader["title"].ToString();

                        ddlClass.SelectedValue =
                            reader["classID"].ToString();

                        DateTime startTime =
                            Convert.ToDateTime(
                                reader["starttime"]);

                        txtStartTime.Text =
                            startTime.ToString(
                                "yyyy-MM-ddTHH:mm");

                        DateTime endTime =
                            Convert.ToDateTime(
                                reader["endtime"]);

                        txtEndTime.Text =
                            endTime.ToString(
                                "yyyy-MM-ddTHH:mm");
                    }
                    else
                    {
                        Session.Remove("sessionID");

                        Response.Redirect(
                            "LiveSessionManagement.aspx");
                    }
                }
            }
        }

        protected void btnSave_Click(
            object sender,
            EventArgs e)
        {
            string sessionID =
                Session["sessionID"]?.ToString();

            if (string.IsNullOrEmpty(sessionID))
            {
                Response.Redirect(
                    "LiveSessionManagement.aspx");

                return;
            }

            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                ShowMessage(
                    "Please enter a session title.");

                return;
            }

            if (string.IsNullOrEmpty(
                ddlClass.SelectedValue))
            {
                ShowMessage(
                    "Please select a classroom.");

                return;
            }

            DateTime startTime;

            if (!DateTime.TryParse(
                txtStartTime.Text,
                out startTime))
            {
                ShowMessage(
                    "Please enter a valid start time.");

                return;
            }

            DateTime endTime;

            if (!DateTime.TryParse(
                txtEndTime.Text,
                out endTime))
            {
                ShowMessage(
                    "Please enter a valid end time.");

                return;
            }

            // End time must be after start time
            if (endTime <= startTime)
            {
                ShowMessage(
                    "End time must be after the start time.");

                return;
            }

            string query = @"
                UPDATE LiveSession
                SET
                    classID = @classID,
                    title = @title,
                    starttime = @starttime,
                    endtime = @endtime
                WHERE sessionID = @sessionID";

            using (SqlConnection conn =
                new SqlConnection(ConnectionString))
            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue(
                    "@classID",
                    ddlClass.SelectedValue);

                cmd.Parameters.AddWithValue(
                    "@title",
                    txtTitle.Text.Trim());

                cmd.Parameters.AddWithValue(
                    "@starttime",
                    startTime);

                cmd.Parameters.AddWithValue(
                    "@endtime",
                    endTime);

                cmd.Parameters.AddWithValue(
                    "@sessionID",
                    sessionID);

                conn.Open();

                cmd.ExecuteNonQuery();
            }

            Session.Remove("sessionID");

            Response.Redirect(
                "LiveSessionManagement.aspx");
        }

        protected void btnCancel_Click(
            object sender,
            EventArgs e)
        {
            Session.Remove("sessionID");

            Response.Redirect(
                "LiveSessionManagement.aspx");
        }

        private void ShowMessage(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }
    }
}