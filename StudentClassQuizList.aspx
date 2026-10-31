
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="StudentClassQuizList.aspx.cs"
    Inherits="Assignment.StudentClassQuizList" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Class Quizzes</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentClassQuizList.css" />
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <main class="quiz-page">
            <div class="page-toolbar">
                <a href="<%: GetReturnUrl() %>" class="topic-navigation return">
                    <img src="svg/left-arrow.svg" width="30" height="30" class="arrow" />

                    <span class="topic-text">
                        <span class="topic-title">Return To Class</span>
                    </span>
                </a>
            </div>

            <section class="quiz-header">
                <h1>
                    <asp:Literal ID="litClassName" runat="server" />
                </h1>

                <p>Quiz</p>

                <div class="quiz-search">
                    <svg class="search-icon"
                         xmlns="http://www.w3.org/2000/svg"
                         width="20"
                         height="20"
                         viewBox="0 0 24 24"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="1.8"
                         stroke-linecap="round"
                         stroke-linejoin="round"
                         aria-hidden="true">
                        <circle cx="11" cy="11" r="7"></circle>
                        <path d="m20 20-4-4"></path>
                    </svg>

                    <asp:TextBox
                        ID="searchBox"
                        runat="server"
                        CssClass="search-input"
                        placeholder="Search quizzes..."
                        AutoPostBack="true"
                        OnTextChanged="searchBox_TextChanged" />
                </div>
            </section>

            <section class="quiz-section">
                <h2 class="section-title">Available Quizzes</h2>

                <asp:Panel
                    ID="availableEmptyPanel"
                    runat="server"
                    Visible="false"
                    CssClass="empty-state">
                    <p>No available quizzes found for this class.</p>
                </asp:Panel>

                <div class="quiz-grid">
                    <asp:Repeater
                        ID="availableQuizRepeater"
                        runat="server"
                        OnItemCommand="AvailableQuizRepeater_ItemCommand">

                        <ItemTemplate>
                            <article class="quiz-card">
                                <div class="quiz-card-top">
                                    <span class="question-badge">
                                        <%#: Eval("QuestionCount") %> Questions
                                    </span>

                                </div>

                                <h3><%#: Eval("Title") %></h3>

                                <p class="quiz-description">
                                    <%#: Eval("Description") %>
                                </p>

                                <div class="quiz-card-action">
                                    <asp:LinkButton
                                        ID="startQuizButton"
                                        runat="server"
                                        CssClass="quiz-button"
                                        CommandName="StartQuiz"
                                        CommandArgument='<%# Eval("QuizID") %>'>
                                        Start Quiz
                                        <span class="button-arrow">&#8594;</span>
                                    </asp:LinkButton>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>

            <section class="quiz-section completed-section">
                <h2 class="section-title">Completed Quizzes</h2>

                <asp:Panel
                    ID="completedEmptyPanel"
                    runat="server"
                    Visible="false"
                    CssClass="empty-state">
                    <p>You have not completed any quizzes in this class yet.</p>
                </asp:Panel>

                <div class="quiz-grid">
                    <asp:Repeater
                        ID="completedQuizRepeater"
                        runat="server"
                        OnItemCommand="CompletedQuizRepeater_ItemCommand">

                        <ItemTemplate>
                            <article class="completed-card">
                                <div class="completed-card-top">
                                    <h3><%#: Eval("Title") %></h3>

                                    <span class="score-badge">
                                        Score: <%#: Eval("ScoreText") %>
                                    </span>
                                </div>

                                <p class="completed-info">
                                    <%#: Eval("QuestionCount") %> Questions
                                    <span class="info-separator">|</span>
                                    Time taken: <%#: Eval("TimeTakenText") %>
                                </p>

                                <div class="progress-container">
                                    <div
                                        class="progress-bar"
                                        style='width: <%#: Eval("ScorePercentage") %>%;'>
                                    </div>
                                </div>

                                <div class="completed-action">
                                    <asp:LinkButton
                                        ID="viewResultButton"
                                        runat="server"
                                        CssClass="quiz-button"
                                        CommandName="ViewResult"
                                        CommandArgument='<%# Eval("QuizID") %>'>
                                        Review Quiz
                                        <span class="button-arrow">&#8594;</span>
                                    </asp:LinkButton>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
        </main>

        <uc:Footer runat="server" />
    </form>
</body>
</html>
