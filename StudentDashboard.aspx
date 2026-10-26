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

        <!-- =========================
             HEADER
        ========================== -->

        <uc:Header ID="HeaderControl" runat="server" />


        <!-- =========================
             MAIN DASHBOARD
        ========================== -->

        <main class="dashboard">


            <!-- =========================
                 DASHBOARD HEADER
            ========================== -->

            <header class="dashboard-header">

                <div>

                    <h1 class="welcome-title"
                        id="welcomeTitle"
                        runat="server"></h1>

                    <p class="welcome-subtitle">
                        Continue your journey through Malaysian history.
                    </p>

                </div>


                <!-- Overall Progress -->

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


            <!-- =========================
                 LIVE SESSION
            ========================== -->

            <div class="live-session">
                <h3>Join Live Session</h3>

                <input type="text"
                    id="liveSessionCode"
                    runat="server"
                    placeholder="Enter live session code" />

                <asp:Button ID="joinLiveSessionButton"
                    runat="server"
                    Text="Join Session"
                    OnClick="JoinLiveSession_Click" />

                <div id="liveSessionError"
                    runat="server"
                    visible="false">
                </div>
            </div>

            <!-- =========================
                 LEARNING MATERIALS
            ========================== -->

            <section class="section-card">

                <div class="section-title">
                    Learning Materials
                </div>


                <asp:Repeater
                    ID="LearningMaterialsRepeater"
                    runat="server">

                    <ItemTemplate>

                        <div class="learning-item">


                            <!-- Material Icon -->

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


                            <!-- Material Information -->

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("Title") %>
                                </p>

                                <p class="item-info">
                                    <%# Eval("Info") %>
                                </p>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <!-- Empty placeholder -->
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


            <!-- =========================
                 RECENT QUIZ
            ========================== -->

            <section class="section-card">

                <div class="section-title">
                    Recent Quiz
                </div>


                <asp:Repeater
                    ID="RecentQuizRepeater"
                    runat="server">

                    <ItemTemplate>

                        <div class="learning-item">


                            <!-- Quiz Icon -->

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


                            <!-- Quiz Information -->

                            <div class="item-content">

                                <p class="item-title">
                                    <%# Eval("Title") %>
                                </p>

                                <p class="item-info">
                                    <%# Eval("Info") %>
                                </p>

                            </div>

                        </div>

                    </ItemTemplate>

                </asp:Repeater>

                <!-- Empty placeholder -->
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


            <!-- =========================
                 JOIN NEW CLASSROOM
            ========================== -->

            <section class="join-card">


                <!-- Join Header -->

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


                <!-- Description -->

                <p class="join-description">
                    Join another classroom by entering the invite
                    code shared by your teacher.

                </p>


                <!-- Join Form -->

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


        <!-- =========================
             FOOTER
        ========================== -->

        <uc:Footer
            ID="FooterControl"
            runat="server" />


    </form>

</body>

</html>
