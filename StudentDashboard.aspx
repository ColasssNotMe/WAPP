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
    <uc:Header ID="HeaderControl" runat="server" />

    <form id="form1" runat="server">

        <main class="dashboard">

            <!-- =========================
             HEADER
        ========================== -->

            <header class="dashboard-header">

                <div>
                    <h1 class="welcome-title" id="welcomeTitle" runat="server">
                </h1>

                    <p class="welcome-subtitle">
                        Continue your journey through Malaysian history.
               
                   
                    </p>
                </div>


                <!-- Progress -->

                <div class="progress-card">

                    <div class="progress-label">
                        Overall Progress
               
                   
                    </div>

                    <div class="progress-content">

                        <span class="progress-number">75%
                    </span>

                        <div class="progress-bar">
                            <div class="progress-fill"></div>
                        </div>

                    </div>

                </div>

            </header>

            <!-- =========================
             LIVE SESSION
        ========================== -->

            <section class="live-session">

                <div class="live-title">

                    <span class="live-icon">

                        <svg viewBox="0 0 24 24"
                            fill="currentColor">

                            <circle cx="7" cy="12" r="3" />
                            <circle cx="17" cy="12" r="3" />

                            <path d="M10 10.5h4v3h-4z" />

                        </svg>

                    </span>

                    Live Session

           
               
                </div>


                <div class="invite-row">

                    <span class="invite-label">Invite Code:
                </span>

                    <input
                        type="text"
                        class="invite-input"
                        aria-label="Invite Code" />

                </div>

            </section>

            <!-- =========================
             LEARNING MATERIALS
        ========================== -->

            <section class="section-card">

                <div class="section-title">
                    Learning Materials
           
               
                </div>


                <!-- Chapter -->

                <div class="learning-item">

                    <div class="item-icon">

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
                            Chapter 1 - Introduction to history
                   
                       
                        </p>

                        <p class="item-info">
                            Score: 92% · 2 hours ago
                   
                       
                        </p>

                    </div>

                </div>


                <!-- Quiz -->

                <div class="learning-item">

                    <div class="item-icon">

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
                            Quiz - Chapter 1
                   
                       
                        </p>

                        <p class="item-info">
                            Pending Review · Yesterday
                   
                       
                        </p>

                    </div>

                </div>

            </section>


            <!-- =========================
             RECENT QUIZ
        ========================== -->

            <section class="section-card">

                <div class="section-title">
                    Recent Quiz
           
               
                </div>


                <!-- Chapter -->

                <div class="learning-item">

                    <div class="item-icon">

                        <svg viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="1.7">

                            <path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v15H6.5A2.5 2.5 0 0 0 4 20.5V5.5Z" />
                            <path d="M4 5.5V20.5" />

                        </svg>

                    </div>


                    <div class="item-content">

                        <p class="item-title">
                            Chapter 1 - Introduction to history
                   
                       
                        </p>

                        <p class="item-info">
                            Score: 92% · 2 hours ago
                   
                       
                        </p>

                    </div>

                </div>


                <!-- Quiz -->

                <div class="learning-item">

                    <div class="item-icon">

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
                            Quiz - Chapter 2
                   
                       
                        </p>

                        <p class="item-info">
                            Pending Review · Yesterday
                   
                       
                        </p>

                    </div>

                </div>

            </section>




            <!-- =========================
             JOIN CLASSROOM
        ========================== -->

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
                    Join another classroom by entering the invite code shared by your teacher.
           
               
                </p>


                <div class="join-form">

                    <input
                        type="text"
                        class="classroom-input"
                        placeholder="Enter invite code" />

                    <button
                        type="button"
                        class="join-button">
                        Join

               
                   
                    </button>

                </div>


                <p class="switch-info">
                    You can switch between classrooms later from the classroom selection page.
           
               
                </p>

            </section>

        </main>

    </form>

    <uc:Footer ID="FooterControl" runat="server" />

</body>
</html>
