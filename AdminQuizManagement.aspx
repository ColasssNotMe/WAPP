<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminQuizManagement.aspx.cs" Inherits="Assignment.AdminQuizManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quiz Management | Ncient</title>
    <link rel="stylesheet" href="AdminQuizManagement.css" />
    <link rel="stylesheet" href="index.css" />
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header ID="HeaderControl" runat="server" />

        <main class="dashboard">
            <header class="page-header">
                <div>
                    <h1>Quiz Management</h1>
                    <p>Review and manage Sejarah quizzes across all teachers and classrooms.</p>
                </div>

                <asp:Button
                    ID="btnCreate"
                    runat="server"
                    CssClass="primary-button"
                    Text="Create New Quiz +"
                    OnClick="btnCreate_Click" />
            </header>

            <section class="content-grid" aria-label="Quiz library and details">
                <section class="panel">
                    <h2 class="panel-heading">Quiz library</h2>

                    <p class="panel-description">
                        <asp:Label ID="lblTotalQuizzes" runat="server" />
                        quizzes ·
                        <asp:Label ID="lblQuestionCount" runat="server" />
                        questions
                    </p>

                    <div class="tab-list">
                        <asp:Button
                            ID="btnTabQuizzes"
                            runat="server"
                            CssClass="tab active"
                            Text="Quizzes"
                            OnClick="btnTabQuizzes_Click" />

                        <asp:Button
                            ID="btnTabQuestions"
                            runat="server"
                            CssClass="tab"
                            Text="Questions"
                            OnClick="btnTabQuestions_Click" />
                    </div>

                    <div class="filter-row">
                        <label class="search-field">
                            <svg viewBox="0 0 24 24" fill="none"
                                stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" aria-hidden="true">
                                <circle cx="11" cy="11" r="7" />
                                <path d="m20 20-3.5-3.5" />
                            </svg>

                            <asp:TextBox
                                ID="txtSearch"
                                runat="server"
                                placeholder="Search quizzes or questions..." />
                        </label>

                        <asp:Button
                            ID="btnSearch"
                            runat="server"
                            CssClass="primary-button"
                            Text="Search"
                            OnClick="btnSearch_Click" />

                        <asp:Button
                            ID="btnReset"
                            runat="server"
                            CssClass="secondary-button"
                            Text="Reset"
                            OnClick="btnReset_Click" />
                    </div>

                    <asp:Panel ID="pnlQuizzes" runat="server">
                        <div class="table-wrap">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Quiz Title</th>
                                        <th>Class</th>
                                        <th>Subject</th>
                                        <th>Created By</th>
                                        <th>Number of Questions</th>
                                        <th>Total Marks</th>
                                        <th>Created Date</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <asp:Repeater
                                        ID="QuizRepeater"
                                        runat="server"
                                        OnItemCommand="Row_Command">

                                        <ItemTemplate>
                                            <tr class='<%# GetRowClass(Eval("quizID")) %>'
                                                onclick="if (event.target.tagName !== 'A') this.querySelector('a').click();">

                                                <td>
                                                    <asp:LinkButton
                                                        ID="lnkSelectQuiz"
                                                        runat="server"
                                                        CssClass="cell-link"
                                                        CommandName="SelectQuiz"
                                                        CommandArgument='<%# Eval("quizID") %>'
                                                        Text='<%#: Eval("title") %>'
                                                        CausesValidation="false" />
                                                </td>

                                                <td><%#: GetText(Eval("className")) %></td>
                                                <td><%#: GetText(Eval("subject")) %></td>
                                                <td><%#: GetText(Eval("teacherName")) %></td>
                                                <td class="quiz-count"><%#: Eval("questionCount") %></td>
                                                <td class="quiz-count"><%#: Eval("totalMarks") %></td>
                                                <td><%#: GetDate(Eval("createdDate")) %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:PlaceHolder
                                        ID="emptyQuizzes"
                                        runat="server"
                                        Visible="false">

                                        <tr>
                                            <td colspan="7" class="empty-row">
                                                No quizzes found.
                                            </td>
                                        </tr>
                                    </asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>

                    <asp:Panel
                        ID="pnlQuestions"
                        runat="server"
                        Visible="false">

                        <div class="table-wrap">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Question</th>
                                        <th>Quiz</th>
                                        <th>Type</th>
                                        <th>Correct Answer</th>
                                        <th>Marks</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <asp:Repeater
                                        ID="QuestionRepeater"
                                        runat="server"
                                        OnItemCommand="Row_Command">

                                        <ItemTemplate>
                                            <tr class='<%# GetRowClass(Eval("quizID")) %>'
                                                onclick="if (event.target.tagName !== 'A') this.querySelector('a').click();">

                                                <td class="question-text">
                                                    <asp:LinkButton
                                                        ID="lnkSelectQuestionQuiz"
                                                        runat="server"
                                                        CssClass="cell-link"
                                                        CommandName="SelectQuiz"
                                                        CommandArgument='<%# Eval("quizID") %>'
                                                        Text='<%#: Eval("questionText") %>'
                                                        CausesValidation="false" />
                                                </td>

                                                <td><%#: GetText(Eval("quizTitle")) %></td>
                                                <td><%#: GetText(Eval("questionType")) %></td>
                                                <td><%#: GetText(Eval("answerText")) %></td>
                                                <td class="quiz-count"><%#: Eval("marks") %></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:PlaceHolder
                                        ID="emptyQuestions"
                                        runat="server"
                                        Visible="false">

                                        <tr>
                                            <td colspan="5" class="empty-row">
                                                No questions found.
                                            </td>
                                        </tr>
                                    </asp:PlaceHolder>
                                </tbody>
                            </table>
                        </div>
                    </asp:Panel>

                    <div class="pagination">
                        <span class="pagination-note">
                            Showing
                            <asp:Label ID="lblShowing" runat="server" />
                            of
                            <asp:Label ID="lblTotal" runat="server" />
                            <asp:Label ID="lblItemName" runat="server" />
                        </span>
                    </div>
                </section>

                <aside class="panel">
                    <h2 class="panel-heading">Quiz Details</h2>

                    <asp:Panel ID="pnlDetails" runat="server">
                        <dl class="detail-list">
                            <dt>Quiz</dt>
                            <dd><asp:Label ID="lblDetTitle" runat="server" /></dd>

                            <dt>Teacher</dt>
                            <dd><asp:Label ID="lblDetTeacher" runat="server" /></dd>

                            <dt>Class</dt>
                            <dd><asp:Label ID="lblDetClass" runat="server" /></dd>

                            <dt>Subject</dt>
                            <dd><asp:Label ID="lblDetSubject" runat="server" /></dd>

                            <dt>Questions</dt>
                            <dd><asp:Label ID="lblDetQuestions" runat="server" /></dd>

                            <dt>Total Marks</dt>
                            <dd><asp:Label ID="lblDetMarks" runat="server" /></dd>

                            <dt>Created</dt>
                            <dd><asp:Label ID="lblDetDate" runat="server" /></dd>
                        </dl>

                        <div class="detail-actions">
                            <asp:button ID="btnView" runat="server" Text="View Quiz" CssClass="secondary-button" OnClick="btnView_Click"/>

                            <asp:Button
                                ID="btnEdit"
                                runat="server"
                                CssClass="secondary-button"
                                Text="Edit quiz"
                                OnClick="btnEdit_Click"
                                CausesValidation="false" />

                            <asp:Button
                                ID="btnDelete"
                                runat="server"
                                CssClass="danger-button"
                                Text="Delete quiz"
                                OnClick="btnDelete_Click"
                                OnClientClick="return confirm('Are you sure you want to delete this quiz?');"
                                CausesValidation="false" />
                        </div>
                    </asp:Panel>

                    <asp:Panel
                        ID="pnlNoSelection"
                        runat="server"
                        Visible="false">

                        <p class="detail-note">No quiz selected.</p>
                    </asp:Panel>
                </aside>
            </section>
        </main>

        <uc:Footer ID="FooterControl" runat="server" />
    </form>
</body>
</html>