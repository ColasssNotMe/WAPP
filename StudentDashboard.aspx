<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="Assignment.StudentDashboard" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <link href="index.css" rel="stylesheet" />
    <link href="StudentDashboard.css" rel="stylesheet" />

    <title>Student Dashboard</title>

</head>

<body>

    <form id="form1" runat="server">

        <uc:Header ID="HeaderControl" runat="server" />

        <main class="dashboard">

            <header class="dashboard-header">

                <div>

                    <h1 class="welcome-title"
                        id="welcomeTitle"
                        runat="server"></h1>

                    <p class="welcome-subtitle">
                        Continue your journey through Malaysian history.
                    </p>

                </div>

                <div class="progress-card">
                    <div class="progress-label">
                        Quiz Progress
                    </div>

                    <div class="progress-content">
                        <span
                            id="progressNumber"
                            runat="server"
                            class="progress-number">0%
                        </span>

                        <div class="progress-bar">
                            <div
                                id="progressFill"
                                runat="server"
                                class="progress-fill">
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <div class="live-session">
                <h3 class="live-title">Join Live Session</h3>

                <div class="join-form">
                    <input type="text"
                        id="liveSessionCode"
                        class="classroom-input"
                        runat="server"
                        placeholder="Enter live session code" />

                    <asp:Button ID="joinLiveSessionButton"
                        runat="server"
                        Text="Join Session"
                        CssClass="join-button"
                        OnClick="JoinLiveSession_Click" />
                </div>

                <div id="liveSessionError"
                    runat="server"
                    class="error-info"
                    visible="false">
                </div>
            </div>

            <section class="section-card">

                <a class="section-title section-title-link" href="StudentLearningMaterial.aspx">
                    <span>Learning Materials</span>

                    <svg class="section-arrow"
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        aria-hidden="true">
                        <path d="M9 5l7 7-7 7" />
                    </svg>
                </a>

                <asp:Repeater
                    ID="LearningMaterialsRepeater"
                    runat="server"
                    OnItemCommand="rptMaterials_ItemCommand">

                    <ItemTemplate>

                        <div class="learning-item">

                            <div class="item-icon" runat="server" id="itemIcon">

                                <svg viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7">

                                    <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5V5.5Z" />

                                    <path d="M4 5.5V20.5" />

                                    <path d="M8 7h8" />

                                    <path d="M8 10h6" />

                                </svg>

                            </div>

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("title") %>
                                </p>

                                <asp:LinkButton
                                    ID="lnkOpenMaterial"
                                    runat="server"
                                    CommandName="OpenMaterial"
                                    CommandArgument='<%# Eval("materialID") %>'
                                    CssClass="material-link">
                                    View Material
                                </asp:LinkButton>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <div id="materialPlaceholder"
                    runat="server"
                    class="empty-placeholder"
                    visible="false">

                    <p class="empty-title">No Learning Materials</p>

                    <p class="empty-info">
                        There are currently no learning materials available.

                    </p>

                </div>

            </section>

            <section class="section-card">

                <a class="section-title section-title-link" href="StudentQuizList.aspx">
                    <span>Recent Quiz</span>

                    <svg class="section-arrow"
                        width="18"
                        height="18"
                        viewBox="0 0 24 24"
                        fill="none"
                        stroke="currentColor"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        aria-hidden="true">
                        <path d="M9 5l7 7-7 7" />
                    </svg>
                </a>

                <asp:Repeater
                    ID="RecentQuizRepeater"
                    runat="server"
                    OnItemCommand="rptQuizzes_ItemCommand">

                    <ItemTemplate>

                        <div class="learning-item">

                            <div class="item-icon" id="itemIcon" runat="server">

                                <svg viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.7">

                                    <rect x="5"
                                        y="3"
                                        width="14"
                                        height="18"
                                        rx="2" />

                                    <path d="M8 7h8" />

                                    <path d="M8 11h8" />

                                    <path d="M8 15h5" />

                                </svg>

                            </div>

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("title") %>
                                </p>

                                <p class="item-info"
                                    runat="server"
                                    visible='<%# HasAttempt(Container.DataItem) %>'>
                                    <%# GetScoreDisplay(Container.DataItem) %>
                                </p>

                                <p class="item-info no-attempt"
                                    runat="server"
                                    visible='<%# !HasAttempt(Container.DataItem) %>'>
                                    No attempt
                                </p>

                                <asp:LinkButton
                                    ID="lnkOpenQuiz"
                                    runat="server"
                                    CommandName="OpenQuiz"
                                    CommandArgument='<%# Eval("quizID") %>'
                                    CssClass="quiz-link">
                                    Attempt Quiz
                                </asp:LinkButton>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <div id="quizPlaceholder"
                    runat="server"
                    class="empty-placeholder"
                    visible="false">

                    <div class="empty-icon">
                    </div>

                    <p class="empty-title">No Recent Quizzes</p>

                    <p class="empty-info">
                        You have not completed any quizzes yet.

                    </p>

                </div>

            </section>

            <section class="join-card">

                <div class="join-header">

                    <div class="join-title-wrapper">

                        <span class="plus-icon">+
                        </span>

                        <h2 class="join-title">Join New Classroom
                        </h2>

                    </div>

                    <span class="invite-code-badge">Enter invite code
                    </span>

                </div>

                <p class="join-description">
                    Join another classroom by entering the invite
                    code shared by your teacher.

                </p>

                <div class="join-form">

                    <input
                        type="text"
                        class="classroom-input"
                        id="classroomCodeInput"
                        runat="server"
                        placeholder="Enter invite code" />

                    <asp:Button
                        ID="JoinButton"
                        runat="server"
                        Text="Join"
                        CssClass="join-button"
                        OnClick="JoinClassroom_Click" />

                </div>

                <p
                    id="errInfo"
                    runat="server"
                    class="error-info"
                    visible="false">
                </p>
            </section>

        </main>

        <uc:Footer
            ID="FooterControl"
            runat="server" />

    </form>

</body>

</html>
