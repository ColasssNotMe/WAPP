<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="AdminUserManagement.aspx.cs"
    Inherits="Assignment.AdminUserManagement" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>User Management | Ncient</title>

    <link rel="stylesheet" href="AdminUserManagement.css" />
    <link rel="stylesheet" href="index.css" />
</head>
<body>
<form id="form1" runat="server">

    <uc:Header ID="HeaderControl" runat="server" />

    <main class="dashboard">

        <header class="page-header">
            <div>
                <h1>User Management</h1>
                <p>
                    Manage platform accounts, roles, and access for
                    students, teachers, and administrators.
                </p>
            </div>

            <div class="header-actions">
                <span class="overview-pill">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0" />
                    users
                </span>

                <asp:Button ID="btnAddUser" runat="server"
                    Text="+ Add New User"
                    CssClass="btn btn-primary"
                    CausesValidation="false"
                    OnClick="btnAddUser_Click" />
            </div>
        </header>

        <asp:Panel ID="pendingNotice" runat="server" CssClass="notice-bar">
            <span class="notice-icon">&#9888;</span>
            <span>
                <asp:Label ID="lblPendingCount" runat="server" Text="0" />
                teachers are awaiting approval. Pending teachers cannot
                access teacher functions until approved.
            </span>
        </asp:Panel>

        <div class="content-grid">

        <section class="panel">

            <div class="section-heading">
                <div>
                    <h2 class="panel-heading">User Directory</h2>
                    <p class="panel-description">
                        View and manage platform accounts.
                    </p>
                </div>
            </div>

            <div class="tab-list">

                <asp:LinkButton ID="btnAllUsers" runat="server"
                    CssClass="tab"
                    OnClick="btnAllUsers_Click">
                    All Users
                </asp:LinkButton>

                <asp:LinkButton ID="btnStudents" runat="server"
                    CssClass="tab"
                    OnClick="btnStudents_Click">
                    Students
                </asp:LinkButton>

                <asp:LinkButton ID="btnTeachers" runat="server"
                    CssClass="tab"
                    OnClick="btnTeachers_Click">
                    Teachers
                </asp:LinkButton>

                <asp:LinkButton ID="btnPendingTeachers" runat="server"
                    CssClass="tab"
                    OnClick="btnPendingTeachers_Click">
                    Pending Teachers
                </asp:LinkButton>

            </div>

            <div class="directory-summary">
                <asp:Label ID="lblSectionTitle" runat="server"
                    Text="All Users" />
                <span class="summary-count">
                    <asp:Label ID="lblSectionCount" runat="server" Text="0" />
                    accounts
                </span>
            </div>

            <div class="filter-row">
                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="search-input"
                    placeholder="Search name, username or email" />

                <asp:Button ID="btnSearch" runat="server"
                    Text="Search"
                    CssClass="search-button"
                    OnClick="btnSearch_Click" />

                <asp:Button ID="btnReset" runat="server"
                    Text="Reset"
                    CssClass="reset-button"
                    CausesValidation="false"
                    OnClick="btnReset_Click" />
            </div>

            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th id="thStatus" runat="server">Account Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="UserRepeater" runat="server"
                            OnItemCommand="UserRepeater_ItemCommand">
                            <ItemTemplate>
                                <tr class='<%# GetRowClass(Eval("userID")) %>'>

                                    <td class="user-name">
                                        <asp:LinkButton ID="btnSelectUser"
                                            runat="server"
                                            CssClass="row-select-link"
                                            CommandName="SelectUser"
                                            CommandArgument='<%# Eval("userID") %>'
                                            Text='<%# Server.HtmlEncode(
                                                Eval("firstName") + " " + Eval("lastName")) %>' />
                                    </td>

                                    <td><%#: Eval("username") %></td>
                                    <td class="user-email"><%#: Eval("email") %></td>
                                    <td><%#: Eval("role") %></td>

                                    <asp:PlaceHolder runat="server"
                                        Visible='<%# ShowStatus %>'>
                                        <td>
                                            <%# GetStatusText(Eval("approved")) %>
                                        </td>
                                    </asp:PlaceHolder>

                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>

            <asp:Panel ID="emptyMessage" runat="server"
                CssClass="empty-message" Visible="false">
                No user accounts found.
            </asp:Panel>

            <div class="pagination">
                <span class="pagination-note">
                    Showing
                    <asp:Label ID="lblShowing" runat="server" Text="0" />
                    of
                    <asp:Label ID="lblTotal" runat="server" Text="0" />
                    accounts
                </span>
            </div>

        </section>

        <aside class="panel detail-panel">
            <h2 class="panel-heading">User Details</h2>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false">
                <asp:Label ID="lblMessage" runat="server" />
            </asp:Panel>

            <asp:Panel ID="pnlAdd" runat="server" Visible="false" CssClass="edit-form">
                <div class="field">
                    <label for="<%= ddlNewRole.ClientID %>">Role</label>
                    <asp:DropDownList ID="ddlNewRole" runat="server"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlNewRole_SelectedIndexChanged">
                        <asp:ListItem Text="Student" Value="Student" />
                        <asp:ListItem Text="Teacher" Value="Teacher" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                    </asp:DropDownList>
                </div>

                <asp:Panel ID="pnlNewSchool" runat="server" CssClass="field">
                    <label for="<%= txtNewSchool.ClientID %>">School</label>
                    <asp:TextBox ID="txtNewSchool" runat="server"
                        placeholder="Enter school name" />
                </asp:Panel>

                <div class="field">
                    <label for="<%= txtNewFirstName.ClientID %>">First name</label>
                    <asp:TextBox ID="txtNewFirstName" runat="server" />
                </div>
                <div class="field">
                    <label for="<%= txtNewLastName.ClientID %>">Last name</label>
                    <asp:TextBox ID="txtNewLastName" runat="server" />
                </div>
                <div class="field">
                    <label for="<%= txtNewUsername.ClientID %>">Username</label>
                    <asp:TextBox ID="txtNewUsername" runat="server" />
                </div>
                <div class="field">
                    <label for="<%= txtNewEmail.ClientID %>">Email</label>
                    <asp:TextBox ID="txtNewEmail" runat="server" TextMode="Email" />
                </div>
                <div class="field">
                    <label for="<%= txtNewPassword.ClientID %>">Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server"
                        TextMode="Password" autocomplete="new-password" />
                </div>

                <div class="action-row">
                    <asp:Button ID="btnCreate" runat="server" Text="Create User"
                        CssClass="btn btn-primary"
                        OnClick="btnCreate_Click" />
                    <asp:Button ID="btnCancelAdd" runat="server" Text="Cancel"
                        CssClass="btn btn-secondary"
                        CausesValidation="false"
                        OnClick="btnCancelAdd_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlDetails" runat="server">

                <asp:Panel ID="pnlView" runat="server">
                    <dl class="detail-list">
                        <dt>Name</dt>
                        <dd><asp:Label ID="lblDetName" runat="server" /></dd>

                        <dt>Username</dt>
                        <dd><asp:Label ID="lblDetUsername" runat="server" /></dd>

                        <dt>Email</dt>
                        <dd class="detail-email"><asp:Label ID="lblDetEmail" runat="server" /></dd>

                        <dt>Role</dt>
                        <dd><asp:Label ID="lblDetRole" runat="server" /></dd>

                        <dt id="dtSchool" runat="server">School</dt>
                        <dd id="ddSchool" runat="server">
                            <asp:Label ID="lblDetSchool" runat="server" />
                        </dd>

                        <dt id="dtGrade" runat="server">Grade Level</dt>
                        <dd id="ddGrade" runat="server">
                            <asp:Label ID="lblDetGrade" runat="server" />
                        </dd>

                        <dt>Joined</dt>
                        <dd><asp:Label ID="lblDetJoined" runat="server" /></dd>

                        <dt id="dtApproval" runat="server">Approval</dt>
                        <dd id="ddApproval" runat="server">
                            <asp:Label ID="lblDetApproval" runat="server" />
                        </dd>
                    </dl>
                </asp:Panel>

                <asp:Panel ID="pnlEdit" runat="server" Visible="false" CssClass="edit-form">
                    <div class="field">
                        <label for="<%= txtFirstName.ClientID %>">First name</label>
                        <asp:TextBox ID="txtFirstName" runat="server" />
                    </div>
                    <div class="field">
                        <label for="<%= txtLastName.ClientID %>">Last name</label>
                        <asp:TextBox ID="txtLastName" runat="server" />
                    </div>
                    <div class="field">
                        <label for="<%= txtUsername.ClientID %>">Username</label>
                        <asp:TextBox ID="txtUsername" runat="server" />
                    </div>
                    <div class="field">
                        <label for="<%= txtEmail.ClientID %>">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />
                    </div>
                     <div class="field">
                    <label for="<%= txtPassword.ClientID %>">New Password</label>
                        <asp:TextBox ID="txtPassword" runat="server"
                            TextMode="SingleLine"
                            autocomplete="off" />
                    </div>
                    <div class="field" id="fieldSchool" runat="server">
                        <label for="<%= txtSchool.ClientID %>">School</label>
                        <asp:TextBox ID="txtSchool" runat="server" />
                    </div>
                    <div class="field" id="fieldGrade" runat="server">
                        <label for="<%= txtGrade.ClientID %>">Grade level</label>
                        <asp:TextBox ID="txtGrade" runat="server" />
                    </div>

                    <div class="action-row">
                        <asp:Button ID="btnSave" runat="server" Text="Save"
                            CssClass="btn btn-primary"
                            OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                            CssClass="btn btn-secondary"
                            CausesValidation="false"
                            OnClick="btnCancel_Click" />
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlActions" runat="server" CssClass="action-row">
                    <asp:Button ID="btnEdit" runat="server" Text="Edit"
                        CssClass="btn btn-secondary"
                        OnClick="btnEdit_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                        CssClass="btn btn-danger"
                        OnClientClick="return confirm('Delete this account? This cannot be undone.');"
                        OnClick="btnDelete_Click" />
                </asp:Panel>

                <asp:Panel ID="pnlApprovalActions" runat="server"
                    CssClass="action-row" Visible="false">
                    <asp:Button ID="btnApprove" runat="server" Text="Approve"
                        CssClass="btn btn-success"
                        OnClick="btnApprove_Click" />
                    <asp:Button ID="btnReject" runat="server" Text="Reject"
                        CssClass="btn btn-danger"
                        OnClientClick="return confirm('Reject this teacher?');"
                        OnClick="btnReject_Click" />
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="pnlNoSelection" runat="server" Visible="false">
                <p class="panel-description">No user selected.</p>
            </asp:Panel>
        </aside>

        </div>

    </main>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>
