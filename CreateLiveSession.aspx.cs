using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CreateLiveSession : System.Web.UI.Page
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
                LoadClasses();
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

                ddlClass.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select Classroom --",
                        ""));
            }
        }

        protected void btnCreate_Click(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                ShowMessage(
                    "Please enter a session title.");

                return;
            }

            if (string.IsNullOrEmpty(ddlClass.SelectedValue))
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

            if (endTime <= startTime)
            {
                ShowMessage(
                    "End time must be after the start time.");

                return;
            }

            string query = @"
                INSERT INTO LiveSession
                (
                    classID,
                    title,
                    starttime,
                    endtime
                )
                VALUES
                (
                    @classID,
                    @title,
                    @starttime,
                    @endtime
                )";

            using (SqlConnection conn =
                new SqlConnection(ConnectionString))

            using (SqlCommand cmd =
                new SqlCommand(query, conn))
            {
                cmd.Parameters.AddWithValue("@classID", ddlClass.SelectedValue);
                cmd.Parameters.AddWithValue("@title", txtTitle.Text.Trim());
                cmd.Parameters.AddWithValue("@starttime", startTime);
                cmd.Parameters.AddWithValue("@endtime", endTime);

                conn.Open();

                cmd.ExecuteNonQuery();
            }

            Response.Redirect(
                "LiveSessionManagement.aspx");
        }

        protected void btnCancel_Click(
            object sender,
            EventArgs e)
        {
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