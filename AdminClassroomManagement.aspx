<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminClassroomManagement.aspx.cs" Inherits="Assignment.AdminClassroomManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Classroom Management</title>
    <link rel="stylesheet" href="AdminClassroomManagement.css">
    <link rel="stylesheet" href="index.css">
</head>
<body>
<form id="form1" runat="server">

    <asp:HiddenField ID="hfSelectedClassID" runat="server" />
    <uc:Header ID="HeaderControl" runat="server" />

    <div class="container">

        <div class="page-header">
            <div>
                <h1>Classroom Management</h1>
                <p>Oversee classrooms, teacher assignments, enrolment, and live sessions.</p>
            </div>

            <span class="count-pill" id="totalClassrooms" runat="server">
                0 classrooms
            </span>
        </div>

        <main class="layout">

            <!-- LEFT: CLASSROOM DIRECTORY -->
            <section class="card" aria-labelledby="dir-title">

                <h2 id="dir-title">Classroom directory</h2>

                <p class="meta" id="classroomMeta" runat="server">
                    Loading classrooms...
                </p>

                <!-- C# TAB NAVIGATION -->
                <div class="tabs">

                    <asp:LinkButton
                        ID="btnClassrooms"
                        runat="server"
                        CssClass="tab active"
                        CausesValidation="false"
                        OnClick="btnClassrooms_Click">
                        Classrooms
                    </asp:LinkButton>

                    <asp:LinkButton
                        ID="btnLiveSessions"
                        runat="server"
                        CssClass="tab"
                        CausesValidation="false"
                        OnClick="btnLiveSessions_Click">
                        Live Sessions
                    </asp:LinkButton>

                </div>

                <!-- CLASSROOM SECTION -->
                <asp:Panel ID="pnlClassrooms" runat="server">

                    <div class="toolbar">

                        <asp:TextBox
                            ID="txtClassroomSearch"
                            runat="server"
                            CssClass="search-input"
                            placeholder="Search classroom or teacher..." />

                        <asp:Button 
                            ID="btnClassroomSearch" 
                            runat="server" 
                            Text="Search" 
                            CssClass="btn primary" 
                            OnClick="btnClassroomSearch_Click" 
                            CausesValidation="false" />

                        <asp:Button 
                            ID="btnClassroomReset" 
                            runat="server" 
                            Text="Reset" 
                            CssClass="btn" 
                            OnClick="btnClassroomReset_Click" 
                            CausesValidation="false" />

                    </div>

                    <div class="table-wrap">

                        <table>
                            <thead>
                                <tr>
                                    <th>Select</th>
                                    <th>Classroom Name</th>
                                    <th>Teacher</th>
                                    <th>Student Count</th>
                                    <th>Quiz Count</th>
                                </tr>
                            </thead>

                            <tbody>

                                <asp:Repeater
                                    ID="rptClassrooms"
                                    runat="server"
                                    OnItemCommand="rptClassrooms_ItemCommand">

                                    <ItemTemplate>
                                        <tr class='<%# Convert.ToString(Eval("ClassID")) == hfSelectedClassID.Value ? "selected-row" : "" %>'>
                                            <td>
                                                <asp:LinkButton 
                                                    ID="btnSelect" 
                                                    runat="server" 
                                                    Text="Select" 
                                                    CommandName="SelectClass" 
                                                    CommandArgument='<%# Eval("ClassID") %>' 
                                                    CssClass="btn-select" 
                                                    CausesValidation="false" />
                                            </td>

                                            <td class="name">
                                                <%#: Eval("ClassName") %>
                                            </td>

                                            <td class="teacher">
                                                <%#: Eval("TeacherName") %>
                                            </td>

                                            <td>
                                                <%#: Eval("StudentCount") %>
                                            </td>

                                            <td>
                                                <%#: Eval("QuizCount") %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>

                                    <FooterTemplate>
                                        <% if (rptClassrooms.Items.Count == 0) { %>
                                            <tr>
                                                <td colspan="5" class="empty">
                                                    No classrooms found.
                                                </td>
                                            </tr>
                                        <% } %>
                                    </FooterTemplate>

                                </asp:Repeater>

                            </tbody>
                        </table>

                    </div>

                    <div class="table-footer">
                        <asp:Label
                            ID="lblClassroomCount"
                            runat="server"
                            Text="Showing 0 classrooms" />
                    </div>

                </asp:Panel>

                <!-- LIVE SESSION SECTION -->
                <asp:Panel
                    ID="pnlLiveSessions"
                    runat="server"
                    Visible="false">

                    <div class="toolbar">

                        <asp:TextBox
                            ID="txtSessionSearch"
                            runat="server"
                            CssClass="search-input"
                            placeholder="Search session, classroom or teacher..." />

                        <asp:Button 
                            ID="btnSessionSearch" 
                            runat="server" 
                            Text="Search" 
                            CssClass="btn primary" 
                            OnClick="btnSessionSearch_Click" 
                            CausesValidation="false" />

                        <asp:Button 
                            ID="btnSessionReset" 
                            runat="server" 
                            Text="Reset" 
                            CssClass="btn" 
                            OnClick="btnSessionReset_Click" 
                            CausesValidation="false" />

                    </div>

                    <div class="table-wrap">

                        <table>
                            <thead>
                                <tr>
                                    <th>Session</th>
                                    <th>Classroom</th>
                                    <th>Teacher</th>
                                    <th>Start Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>

                            <tbody>

                                <asp:Repeater
                                    ID="rptSessions"
                                    runat="server">

                                    <ItemTemplate>
                                        <tr>
                                            <td class="name">
                                                <%#: Eval("SessionTitle") %>
                                            </td>

                                            <td>
                                                <%#: Eval("ClassName") %>
                                            </td>

                                            <td class="teacher">
                                                <%#: Eval("TeacherName") %>
                                            </td>

                                            <td>
                                                <%#: Eval("StartTime", "{0:dd MMM yyyy, hh:mm tt}") %>
                                            </td>

                                            <td class='status <%#: Convert.ToString(Eval("Status")).ToLowerInvariant() %>'>
                                                <%#: Eval("Status") %>
                                            </td>
                                        </tr>
                                    </ItemTemplate>

                                    <FooterTemplate>
                                        <% if (rptSessions.Items.Count == 0) { %>
                                            <tr>
                                                <td colspan="5" class="empty">
                                                    No live sessions found.
                                                </td>
                                            </tr>
                                        <% } %>
                                    </FooterTemplate>

                                </asp:Repeater>

                            </tbody>
                        </table>

                    </div>

                    <div class="table-footer">
                        <asp:Label
                            ID="lblSessionCount"
                            runat="server"
                            Text="Showing 0 sessions" />
                    </div>

                </asp:Panel>

            </section>

            <!-- RIGHT: DETAILS PANEL -->
            <aside class="card details">

                <h2>Classroom Details</h2>

                <dl>
                    <div class="row">
                        <dt>Classroom</dt>
                        <dd><asp:Label ID="lblDetailClassName" runat="server" Text="-" /></dd>
                    </div>

                    <div class="row">
                        <dt>Teacher</dt>
                        <dd><asp:Label ID="lblDetailTeacher" runat="server" Text="-" /></dd>
                    </div>

                    <div class="row">
                        <dt>School</dt>
                        <dd><asp:Label ID="lblDetailSchool" runat="server" Text="-" /></dd>
                    </div>

                    <div class="row">
                        <dt>Subject</dt>
                        <dd><asp:Label ID="lblDetailSubject" runat="server" Text="-" /></dd>
                    </div>

                    <div class="row">
                        <dt>Students</dt>
                        <dd><asp:Label ID="lblDetailStudents" runat="server" Text="0" /></dd>
                    </div>

                    <div class="row">
                        <dt>Invite code</dt>
                        <dd><asp:Label ID="lblDetailInviteCode" runat="server" Text="-" /></dd>
                    </div>

                    <div class="row">
                        <dt>Status</dt>
                        <dd class="ok"><asp:Label ID="lblDetailStatus" runat="server" Text="-" /></dd>
                    </div>
                </dl>

                <p class="note">
                    <asp:Label ID="lblNote" runat="server" Text="Select View in the classroom table to open details." />
                </p>

                <div class="btn-row">
                    <asp:Button
                        ID="btnViewDetails"
                        runat="server"
                        Text="View"
                        CssClass="btn primary"
                        CausesValidation="false"
                        OnClick="btnViewDetails_Click" />

                    <asp:Button
                        ID="btnDeleteClassroom"
                        runat="server"
                        Text="Delete"
                        CssClass="btn btn-danger"
                        CausesValidation="false"
                        OnClientClick="return confirm('Are you sure you want to delete this classroom?');"
                        OnClick="btnDeleteClassroom_Click" />

                    <asp:Button
                        ID="btnRefresh"
                        runat="server"
                        Text="Refresh"
                        CssClass="btn"
                        CausesValidation="false"
                        OnClick="btnRefresh_Click" />
                </div>

            </aside>

        </main>

    </div>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>