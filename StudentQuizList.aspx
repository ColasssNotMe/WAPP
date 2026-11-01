<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="StudentQuizList.aspx.cs"
    Inherits="Assignment.StudentQuizList" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Quiz History</title>

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentQuizList.css" />
</head>

<body>

<form id="form1" runat="server">

        <asp:Panel
            ID="ResultsModal"
            runat="server"
            CssClass="results-overlay"
            Visible="false">

            <div class="results-dialog" role="dialog" aria-modal="true" aria-labelledby="resultsTitle">
                <div class="results-header">
                    <h2 id="resultsTitle">Quiz Results</h2>
                    <p><asp:Literal ID="ResultsSummary" runat="server" /></p>
                </div>

                <div class="results-body">
                    <asp:Repeater ID="ResultsRepeater" runat="server" OnItemDataBound="ResultsRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div class="result-question">
                                <div class="result-question-title">
                                    <span class="result-number"><%# Container.ItemIndex + 1 %>.</span>
                                    <span class="result-question-text"><%#: Eval("QuestionText") %></span>
                                    <span class='result-status <%# Eval("StatusClass") %>'><%#: Eval("StatusText") %></span>
                                </div>

                                <asp:Repeater ID="ResultOptionsRepeater" runat="server">
                                    <ItemTemplate>
                                        <div class='<%# Eval("CssClass") %>'>
                                            <span class="result-option-text"><%#: Eval("AnswerText") %></span>
                                            <span class="result-option-tag"><%#: Eval("Tag") %></span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>

                                <p class="result-unanswered">Your selected answer was not stored for this attempt.</p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="results-footer">
                    <asp:Button ID="CloseResultsButton" runat="server"
                        CssClass="results-close-button" Text="Close"
                        OnClick="CloseResultsButton_Click" />
                </div>
            </div>
        </asp:Panel>



    <uc:Header runat="server" />

    <main class="quiz-page">

        <div class="page-toolbar">

            <a href="StudentDashboard.aspx" class="topic-navigation return">
                <img src="svg/left-arrow.svg" width="30" height="30" class="arrow" />

                <span class="topic-text">
                    <span class="topic-title">Return To Dashboard</span>
                </span>
            </a>

        </div>

        <section class="quiz-header">

            <h1>Quiz History</h1>

            <p>
                Complete quizzes from your enrolled classes and review your previous attempts.
            </p>

            <div class="quiz-search">

                <span class="search-icon">⌕</span>

                <asp:TextBox
                    ID="searchBox"
                    runat="server"
                    CssClass="search-input"
                    placeholder="Search quizzes...">
                </asp:TextBox>

            </div>

        </section>

        <section class="quiz-section">

            <h2 class="section-title">
                Available Quizzes
            </h2>

            <asp:Panel
                ID="availableEmptyPanel"
                runat="server"
                Visible="false"
                CssClass="empty-state">

                <p>No quizzes are currently available.</p>

            </asp:Panel>

            <div class="quiz-grid">

                <asp:Repeater
                    ID="availableQuizRepeater"
                    runat="server"
                    OnItemCommand="AvailableQuizRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="quiz-card">

                            <div class="quiz-card-top">

                                <span class="question-badge">
                                    <%# Eval("QuestionCount") %> Questions
                                </span>


                            </div>

                            <h3>
                                <%# Eval("Title") %>
                            </h3>

                            <p class="quiz-description">
                                <%# Eval("Description") %>
                            </p>

                            <div class="quiz-card-action">

                                <asp:Button
                                    ID="startQuizButton"
                                    runat="server"
                                    Text="Start Quiz"
                                    CssClass="quiz-button"
                                    CommandName="StartQuiz"
                                    CommandArgument='<%# Eval("QuizID") %>' />

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>

        <section class="quiz-section completed-section">

            <h2 class="section-title">
                Completed Quizzes
            </h2>

            <asp:Panel
                ID="completedEmptyPanel"
                runat="server"
                Visible="false"
                CssClass="empty-state">

                <p>You have not completed any quizzes yet.</p>

            </asp:Panel>

            <div class="quiz-grid">

                <asp:Repeater
                    ID="completedQuizRepeater"
                    runat="server"
                    OnItemCommand="CompletedQuizRepeater_ItemCommand">

                    <ItemTemplate>

                        <div class="completed-card">

                            <div class="completed-card-top">

                                <h3>
                                    <%# Eval("Title") %>
                                </h3>

                                <span class="score-badge">
                                    <%# Eval("ScoreText") %>
                                </span>

                            </div>

                            <p class="completed-info">

                                <%# Eval("QuestionCount") %> Questions
                                <br />

                                Time taken:
                                <%# Eval("TimeTakenText") %>

                            </p>

                            <div class="progress-container">

                                <div
                                    class="progress-bar"
                                    style='width: <%# Eval("ScorePercentage") %>%;'>
                                </div>

                            </div>

                            <div class="completed-action">

                                <asp:Button
                                    ID="viewResultButton"
                                    runat="server"
                                    Text="View Result"
                                    CssClass="quiz-button"
                                    CommandName="ViewResult"
                                    CommandArgument='<%# Eval("ResultID") %>' />

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

            </div>

        </section>

    </main>

<uc:Footer runat="server" />

</form>

</body>
</html>