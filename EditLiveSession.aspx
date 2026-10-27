<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="EditLiveSession.aspx.cs"
    Inherits="Assignment.EditLiveSession" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Edit Live Session</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="LiveSessionForm.css">

</head>

<body>

<form id="form1" runat="server">

    <div class="sessions-container">

        <!-- Header -->
        <header class="page-header">

            <div class="header-left">

                <a href="LiveSessionManagement.aspx"
                   class="back-btn"
                   aria-label="Go Back">

                    <svg xmlns="http://www.w3.org/2000/svg"
                         width="24"
                         height="24"
                         viewBox="0 0 24 24"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="2.5"
                         stroke-linecap="round"
                         stroke-linejoin="round">

                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>

                    </svg>

                </a>

                <div class="title-group">

                    <h1 class="page-title">
                        Edit Live Session
                    </h1>

                    <p class="page-subtitle">
                        Update the details of your scheduled live session.
                    </p>

                </div>

            </div>

        </header>


        <!-- Form -->
        <main class="form-container">

            <div class="card">

                <h2 class="card-title">
                    Session Information
                </h2>


                <!-- Session Title -->
                <div class="form-group">

                    <label for="txtTitle">
                        Session Title
                    </label>

                    <asp:TextBox
                        ID="txtTitle"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter session title">
                    </asp:TextBox>

                </div>


                <!-- Classroom -->
                <div class="form-group">

                    <label for="ddlClass">
                        Classroom
                    </label>

                    <asp:DropDownList
                        ID="ddlClass"
                        runat="server"
                        CssClass="form-input">
                    </asp:DropDownList>

                </div>


                <!-- Start Time -->
                <div class="form-group">

                    <label for="txtStartTime">
                        Start Time
                    </label>

                    <asp:TextBox
                        ID="txtStartTime"
                        runat="server"
                        CssClass="form-input"
                        TextMode="DateTimeLocal">
                    </asp:TextBox>

                </div>


                <!-- End Time -->
                <div class="form-group">

                    <label for="txtEndTime">
                        End Time
                    </label>

                    <asp:TextBox
                        ID="txtEndTime"
                        runat="server"
                        CssClass="form-input"
                        TextMode="DateTimeLocal">
                    </asp:TextBox>

                </div>


                <!-- Message -->
                <asp:Label
                    ID="lblMessage"
                    runat="server"
                    CssClass="form-message"
                    Visible="false">
                </asp:Label>


                <!-- Actions -->
                <div class="form-actions">

                    <asp:Button
                        ID="btnCancel"
                        runat="server"
                        Text="Cancel"
                        CssClass="btn btn-secondary"
                        OnClick="btnCancel_Click" />

                    <asp:Button
                        ID="btnSave"
                        runat="server"
                        Text="Save Changes"
                        CssClass="btn btn-primary"
                        OnClick="btnSave_Click" />

                </div>

            </div>

        </main>

    </div>

</form>

</body>
</html>