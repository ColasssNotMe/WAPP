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
                <p>Oversee classrooms, teacher assignments, students and quizzes.</p>
            </div>
            <span class="count-pill" id="totalClassrooms" runat="server">0 classrooms</span>
        </div>

        <main class="layout">

            <!-- ======================== CLASSROOM LIST ======================== -->
            <section class="card">
                <h2>Classroom directory</h2>
                <p class="meta" id="classroomMeta" runat="server">Loading...</p>

                <div class="toolbar">
                    <asp:TextBox ID="txtClassroomSearch" runat="server" CssClass="search-input"
                        placeholder="Search classroom or teacher..." />
                    <asp:Button ID="btnClassroomSearch" runat="server" Text="Search"
                        CssClass="btn primary" OnClick="btnClassroomSearch_Click" CausesValidation="false" />
                    <asp:Button ID="btnClassroomReset" runat="server" Text="Reset"
                        CssClass="btn" OnClick="btnClassroomReset_Click" CausesValidation="false" />
                </div>

                <div class="table-wrap">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Open</th>
                                <th>Classroom</th>
                                <th>Teacher</th>
                                <th>Students</th>
                                <th>Quizzes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="rptClassrooms" runat="server" OnItemCommand="rptClassrooms_ItemCommand">
                                <ItemTemplate>
                                    <tr class='<%# Convert.ToString(Eval("ClassID")) == hfSelectedClassID.Value ? "selected-row" : "" %>'>
                                        
                                        <td class="name"><%#: Eval("ClassName") %></td>
                                        <td class="teacher"><%#: Eval("TeacherName") %></td>
                                        <td><%#: Eval("StudentCount") %></td>
                                        <td><%#: Eval("QuizCount") %></td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton1" runat="server" Text="View"
                                                CommandName="SelectClass" CommandArgument='<%# Eval("ClassID") %>'
                                                CssClass="btn-select" CausesValidation="false" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <% if (rptClassrooms.Items.Count == 0) { %>
                                        <tr><td colspan="5" class="empty">No classrooms found.</td></tr>
                                    <% } %>
                                </FooterTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>

                <div class="table-footer">
                    <asp:Label ID="lblClassroomCount" runat="server" Text="Showing 0 classrooms" />
                </div>
            </section>

            <!-- ======================== DETAILS PANEL ======================== -->
            <aside class="card details">

                <asp:Panel ID="pnlDetails" runat="server">

                    <asp:Label ID="lblMessage" runat="server" CssClass="msg" Visible="false" />

                    <h2>Edit Classroom</h2>

                    <div class="field">
                        <label>Classroom name</label>
                        <asp:TextBox ID="txtClassName" runat="server" CssClass="input" />
                    </div>

                    <div class="field">
                        <label>Teacher</label>
                        <asp:DropDownList ID="ddlTeacher" runat="server" CssClass="select" />
                    </div>

                    <div class="field-grid">
                        <div class="field">
                            <label>School / Description</label>
                            <asp:TextBox ID="txtSchool" runat="server" CssClass="input" />
                        </div>
                        <div class="field">
                            <label>Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="input" />
                        </div>
                    </div>

                    <div class="field">
                        <label>Invite code</label>
                        <asp:TextBox ID="txtInviteCode" runat="server" CssClass="input" />
                    </div>

                    <div class="btn-row">
                        <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                            CssClass="btn primary" OnClick="btnSave_Click" CausesValidation="false" />
                        <asp:Button ID="btnDeleteClassroom" runat="server" Text="Delete Classroom"
                            CssClass="btn btn-danger" OnClick="btnDeleteClassroom_Click" CausesValidation="false"
                            OnClientClick="return confirm('Delete this classroom and all its students, quizzes and sessions?');" />
                    </div>

                    <div class="section-title"><span>Overall</span></div>
                    <div class="field-grid">
                        <div class="field">
                            <label>Total students</label>
                            <asp:Label ID="lblTotalStudents" runat="server" Text="0" />
                        </div>
                        <div class="field">
                            <label>Total quizzes</label>
                            <asp:Label ID="lblTotalQuizzes" runat="server" Text="0" />
                        </div>
                    </div>

                    <!-- Students List -->
                    <div class="section-title"><span>Students</span></div>
                    <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
                        <HeaderTemplate>
                            <table class="mini-table">
                                <thead>
                                    <tr><th>Student</th><th style="width: 80px;"></th></tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%#: Eval("StudentName") %></td>
                                <td>
                                    <asp:LinkButton ID="btnRemoveStudent" runat="server" Text="Remove"
                                        CommandName="RemoveStudent" CommandArgument='<%# Eval("StudentID") %>'
                                        CssClass="btn-mini" CausesValidation="false"
                                        OnClientClick="return confirm('Remove this student from the classroom?');" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                            <% if (rptStudents.Items.Count == 0) { %>
                                <span class="empty-msg">No students enrolled.</span>
                            <% } %>
                        </FooterTemplate>
                    </asp:Repeater>

                    <!-- Quizzes List (View Only) -->
                    <div class="section-title"><span>Quizzes</span></div>
                    <asp:Repeater ID="rptQuizzes" runat="server">
                        <HeaderTemplate>
                            <table class="mini-table">
                                <thead>
                                    <tr><th>Quiz</th><th style="width: 80px;"></th></tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%#: Eval("QuizTitle") %></td>
                                <td>
                                    <asp:HyperLink ID="lnkViewQuiz" runat="server" Text="View"
                                        NavigateUrl='<%# "AdminViewQuiz?quizID=" + Eval("QuizID") %>'
                                        CssClass="btn-select" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                            <% if (rptQuizzes.Items.Count == 0) { %>
                                <span class="empty-msg">No quizzes in this classroom.</span>
                            <% } %>
                        </FooterTemplate>
                    </asp:Repeater>

                </asp:Panel>

                <asp:Panel ID="pnlNoSelection" runat="server">
                    <h2>Classroom Details</h2>
                    <p class="note">
                        Select <strong>Open</strong> on a classroom to view and manage its details, students and quizzes.
                    </p>
                </asp:Panel>

            </aside>

        </main>
    </div>

    <uc:Footer ID="FooterControl" runat="server" />

</form>
</body>
</html>