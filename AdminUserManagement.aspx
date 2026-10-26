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

            <span class="overview-pill">
                <asp:Label ID="lblTotalUsers" runat="server" Text="0" />
                users
            </span>
        </header>

        <asp:Panel ID="pendingNotice" runat="server" CssClass="notice-bar">
            <span class="notice-icon">&#9888;</span>
            <span>
                <asp:Label ID="lblPendingCount" runat="server" Text="0" />
                teachers are awaiting approval. Pending teachers cannot
                access teacher functions until approved.
            </span>
        </asp:Panel>

        <section class="panel">

            <div class="section-heading">
                <div>
                    <h2 class="panel-heading">User Directory</h2>
                    <p class="panel-description">
                        View and manage platform accounts.
                    </p>
                </div>
            </div>

            <!-- Four sections -->
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

            <!-- Search -->
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

            <!-- User table -->
            <div class="table-wrap">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Account Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <asp:Repeater ID="UserRepeater" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="user-name">
                                        <%#: Eval("firstName") %>
                                    </td>

                                    <td>
                                        <%#: Eval("username") %>
                                    </td>

                                    <td class="user-email">
                                        <%#: Eval("email") %>
                                    </td>

                                    <td>
                                        <%#: Eval("role") %>
                                    </td>

                                    <td class='<%# GetStatusText(Eval("approved")) %>'>
                                        <%# GetStatusText(Eval("approved")) %>

                                    </td>
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

    </main>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>