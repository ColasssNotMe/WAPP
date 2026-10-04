<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="Assignment.StudentDashboard" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Dashboard</title>

    <style type="text/css">
        * {
            box-sizing: border-box;
            font-family: "Plus Jakarta Sans", sans-serif;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #111111;
        }

        /* =========================
       DASHBOARD CONTAINER
    ========================= */

        .dashboard {
            width: 90%;
            max-width: 1000px;
            margin: 35px auto 50px auto;
            padding: 0;
        }


        /* =========================
       HEADER
    ========================= */

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 25px;
        }

        .welcome-title {
            margin: 0;
            font-size: 2rem;
            line-height: 1.15;
            font-weight: 700;
            color: #111111;
        }

        .welcome-subtitle {
            margin: 12px 0 0 0;
            font-size: 1rem;
            line-height: 1.4;
            font-weight: 400;
            color: #555555;
        }


        /* =========================
       PROGRESS CARD
    ========================= */

        .progress-card {
            width: 220px;
            padding: 15px;
            background-color: #ffffff;
            border: 1px solid #e8e8e8;
            border-radius: 8px;
        }

        .progress-label {
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: #555555;
        }

        .progress-content {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .progress-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: #111111;
        }

        .progress-bar {
            flex: 1;
            height: 8px;
            background-color: #eeeeee;
            border-radius: 999px;
            overflow: hidden;
        }

        .progress-fill {
            width: 75%;
            height: 100%;
            background-color: #111111;
            border-radius: inherit;
        }


        /* =========================
       SECTION CARDS
    ========================= */

        .section-card {
            background-color: #ffffff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            margin-bottom: 20px;
            overflow: hidden;
        }

        .section-title {
            padding: 18px 20px 12px 20px;
            font-size: 1.5rem;
            font-weight: 700;
            color: #222222;
        }


        /* =========================
       LEARNING / QUIZ ITEMS
    ========================= */

        .learning-item {
            display: flex;
            align-items: center;
            gap: 15px;
            min-height: 70px;
            padding: 12px 20px;
            border-top: 1px solid #eeeeee;
        }

        .item-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            color: #222222;
        }

            .item-icon svg {
                width: 28px;
                height: 28px;
            }

        .item-content {
            min-width: 0;
        }

        .item-title {
            margin: 0;
            font-size: 1rem;
            line-height: 1.35;
            font-weight: 600;
            color: #222222;
        }

        .item-info {
            margin: 5px 0 0 0;
            font-size: 0.8rem;
            line-height: 1.35;
            color: #777777;
        }


        /* =========================
       LIVE SESSION
    ========================= */

        .live-session {
            width: 100%;
            margin: 25px 0;
            padding: 20px;
            background-color: #d9d9d9;
            border-radius: 8px;
        }

        .live-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 15px;
            font-size: 1.2rem;
            font-weight: 700;
            color: #222222;
        }

        .live-icon {
            display: flex;
            align-items: center;
        }

            .live-icon svg {
                width: 22px;
                height: 22px;
            }

        .invite-row {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .invite-label {
            font-size: 1rem;
            color: #555555;
        }

        .invite-input {
            width: 200px;
            height: 38px;
            padding: 0 10px;
            border: 1px solid #bbbbbb;
            border-radius: 5px;
            background-color: #ffffff;
            outline: none;
            font-family: inherit;
            font-size: 1rem;
        }


        /* =========================
       JOIN CLASSROOM
    ========================= */

        .join-card {
            background-color: #ffffff;
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            padding: 20px;
        }

        .join-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .join-title-wrapper {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .plus-icon {
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #d9d9d9;
            border-radius: 50%;
            font-size: 1.2rem;
            color: #333333;
        }

        .join-title {
            margin: 0;
            font-size: 1.5rem;
            font-weight: 700;
            color: #222222;
        }

        .invite-code-badge {
            padding: 6px 10px;
            background-color: #eeeeee;
            border-radius: 999px;
            font-size: 0.8rem;
            color: #555555;
        }

        .join-description {
            margin: 15px 0;
            font-size: 1rem;
            line-height: 1.45;
            color: #555555;
        }

        .join-form {
            display: flex;
            gap: 10px;
        }

        .classroom-input {
            flex: 1;
            height: 45px;
            padding: 0 14px;
            border: 1px solid #dddddd;
            border-radius: 5px;
            outline: none;
            font-family: inherit;
            font-size: 1rem;
            color: #333333;
        }

            .classroom-input::placeholder {
                color: #999999;
            }

        .join-button {
            width: 150px;
            height: 45px;
            border: none;
            border-radius: 5px;
            background-color: #111111;
            color: #ffffff;
            font-family: inherit;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: opacity 0.2s ease;
        }

            .join-button:hover {
                opacity: 0.8;
            }

        .switch-info {
            margin: 12px 0 0 0;
            font-size: 0.8rem;
            line-height: 1.4;
            color: #888888;
        }


        /* =========================
       RESPONSIVE
    ========================= */

        @media (max-width: 700px) {

            .dashboard {
                width: 90%;
            }

            .dashboard-header {
                flex-direction: column;
                gap: 20px;
            }

            .progress-card {
                width: 100%;
            }

            .section-title {
                font-size: 1.25rem;
            }

            .join-header {
                align-items: flex-start;
                gap: 15px;
                flex-direction: column;
            }

            .join-form {
                flex-direction: column;
            }

            .classroom-input {
                width: 100%;
            }

            .join-button {
                width: 100%;
            }

            .invite-row {
                flex-direction: column;
                align-items: flex-start;
            }
        }
    </style>
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
                    <h1 class="welcome-title">Welcome back, Aiman!
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
