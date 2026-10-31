<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditClassroom.aspx.cs" Inherits="Assignment.EditClassroom" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Classroom</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="CreateClassroom.css">
</head>
<body>
   <form id="form1" runat="server">
        <uc:Header ID="HeaderControl" runat="server" />
           <link href="index.css" rel="stylesheet" />
        <div class="create-container">

            <header class="create-header">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <h1 class="page-title">Edit Classroom</h1>
                <div class="header-spacer"></div>
            </header>

            <main class="card classroom-details-card">
                <h2 class="card-title">Classroom Details</h2>

                <div class="create-form">

                    <div class="form-group">
                        <label for="txtClassroomName">Classroom name</label>
                        <asp:TextBox ID="txtClassroomName" runat="server" CssClass="form-control" placeholder="Enter classroom name" />
                    </div>

                    <div class="form-group">
                        <label for="txtDescription">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control text-area" placeholder="Enter classroom description..." />
                    </div>

                    <div class="form-actions">
                        <asp:Button ID="btnSaveClassroom" runat="server" Text="Save changes" CssClass="btn btn-primary" OnClick="btnSaveClassroom_Click" />
                        <a href="MyClasses.aspx" class="btn btn-secondary">Cancel</a>
                    </div>

                </div>
            </main>

        </div>
          <uc:Footer ID="FooterControl" runat="server" />
    </form>
</body>
</html>