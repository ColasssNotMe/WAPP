
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
                            placeholder="Search classroom or teacher"
                            AutoPostBack="true"
                            OnTextChanged="txtClassroomSearch_TextChanged" />

                        <asp:DropDownList
                            ID="ddlClassroomStatus"
                            runat="server"
                            CssClass="select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlClassroomStatus_SelectedIndexChanged">

                            <asp:ListItem Text="Status: All" Value="" />
                            <asp:ListItem Text="Active" Value="Active" />
                            <asp:ListItem Text="Inactive" Value="Inactive" />

                        </asp:DropDownList>

                    </div>

                    <div class="table-wrap">

                        <table>
                            <thead>
                                <tr>
                                    <th>Classroom Name</th>
                                    <th>Teacher</th>
                                    <th>Student Count</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>

                            <tbody>

                                <asp:Repeater
                                    ID="rptClassrooms"
                                    runat="server">

                                    <ItemTemplate>
                                        <tr>
                                            <td class="name">
                                                <%#: Eval("ClassName") %>
                                            </td>

                                            <td class="teacher">
                                                <%#: Eval("TeacherName") %>
                                            </td>

                                            <td>
                                                <%#: Eval("StudentCount") %>
                                            </td>

                                            <td class='status <%#: Convert.ToString(Eval("Status")).ToLowerInvariant() %>'>
                                                <%#: Eval("Status") %>
                                            </td>

                                            <td class="actions">
                                                <a href='AdminClassroomDetails.aspx?classID=<%# Eval("ClassID") %>'>
                                                    View
                                                </a>
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
                            placeholder="Search session, classroom or teacher"
                            AutoPostBack="true"
                            OnTextChanged="txtSessionSearch_TextChanged" />

                        <asp:DropDownList
                            ID="ddlSessionStatus"
                            runat="server"
                            CssClass="select"
                            AutoPostBack="true"
                            OnSelectedIndexChanged="ddlSessionStatus_SelectedIndexChanged">

                            <asp:ListItem Text="Status: All" Value="" />
                            <asp:ListItem Text="Live" Value="Live" />
                            <asp:ListItem Text="Scheduled" Value="Scheduled" />
                            <asp:ListItem Text="Completed" Value="Completed" />
                            <asp:ListItem Text="Cancelled" Value="Cancelled" />

                        </asp:DropDownList>

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
                        <dd>4 Amanah</dd>
                    </div>

                    <div class="row">
                        <dt>Teacher</dt>
                        <dd>Cikgu Nurul</dd>
                    </div>

                    <div class="row">
                        <dt>School</dt>
                        <dd>SMK Taman Melawati</dd>
                    </div>

                    <div class="row">
                        <dt>Subject</dt>
                        <dd>Form 4 • Sejarah KSSM</dd>
                    </div>

                    <div class="row">
                        <dt>Students</dt>
                        <dd>30</dd>
                    </div>

                    <div class="row">
                        <dt>Invite code</dt>
                        <dd>AMANAH26</dd>
                    </div>

                    <div class="row">
                        <dt>Status</dt>
                        <dd class="ok">Active</dd>
                    </div>
                </dl>

                <p class="note">
                    Select View in the classroom table to open the classroom details.
                    The information above is currently sample content.
                </p>

                <div class="btn-row">
                    <asp:Button
                        ID="btnRefresh"
                        runat="server"
                        Text="Refresh"
                        CssClass="btn primary"
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
