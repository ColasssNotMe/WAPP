<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LiveSession.aspx.cs" Inherits="Assignment.LiveSession" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Live Session</title>

    <link href="index.css" rel="stylesheet" type="text/css" />
    <link href="LiveSession.css" rel="stylesheet" type="text/css" />

</head>

<body>

<form id="form1" runat="server">

    <main class="live-session-page">

        <!-- ==========================
             PAGE HEADER
        =========================== -->

        <section class="session-header">

            <div class="session-heading">

                <h1>Live Session</h1>

                <p class="class-name">
                    &lt;Class Name&gt;
                </p>

            </div>

            <div class="live-indicator">
                <span class="live-dot"></span>
                Live now
            </div>

        </section>


        <!-- ==========================
             SESSION USER INFORMATION
        =========================== -->

        <div class="session-meta">

            <span>
                &lt;Class Name&gt;
            </span>

            <span>
                Aiman bin Abdullah • user001
            </span>

        </div>


        <!-- ==========================
             MAIN SESSION AREA
        =========================== -->

        <section class="session-layout">


            <!-- ==========================
                 PRESENTATION
            =========================== -->

            <div class="presentation-section">

                <div class="presentation-card">

                    <!-- Presentation Header -->

                    <div class="presentation-header">

                        <div class="presenter-info">

                            <span class="monitor-icon">
                                ▣
                            </span>

                            <strong>
                                Cikgu Nurul is presenting
                            </strong>

                        </div>

                        <span class="slide-number">
                            Slide 5 of 12
                        </span>

                    </div>


                    <!-- Presentation Area -->

                    <div class="presentation-screen">

                        <div class="presentation-placeholder">

                            <div class="placeholder-cross cross-one"></div>
                            <div class="placeholder-cross cross-two"></div>

                        </div>

                    </div>


                    <!-- Presentation Controls -->

                    <div class="presentation-controls">

                        <div class="left-controls">

                            <button class="session-button">
                                ♩&nbsp; Muted
                            </button>

                            <button class="session-button">
                                ♧&nbsp; Raise hand
                            </button>

                            <button class="session-button">
                                ⛶&nbsp; Full screen
                            </button>

                        </div>

                        <button class="leave-button">
                            Leave session
                        </button>

                    </div>

                </div>


                <!-- ==========================
                     SESSION INFORMATION
                =========================== -->

                <div class="session-info-card">

                    <div class="teacher-avatar">
                        CN
                    </div>

                    <div class="session-details">

                        <h2>
                            &lt;Room Title&gt;
                        </h2>

                        <p>
                            &lt;Teacher Name&gt;
                        </p>

                        <span>
                            Session code: SEJ-4A
                        </span>

                    </div>

                    <div class="connection-status">
                        Connected • 18:24
                    </div>

                </div>

            </div>


            <!-- ==========================
                 SESSION CHAT
            =========================== -->

            <aside class="chat-panel">

                <div class="chat-header">

                    <h2>
                        Session Chat
                    </h2>

                    <span class="chat-icon">
                        ♡
                    </span>

                </div>

                <p class="chat-description">
                    Messages are visible to your teacher and classmates.
                </p>


                <div class="chat-messages">


                    <!-- Message 1 -->

                    <div class="chat-message">

                        <div class="message-avatar">
                            CN
                        </div>

                        <div class="message-content">

                            <div class="message-top">

                                <strong>
                                    Cikgu Nurul
                                </strong>

                                <span>
                                    11:16
                                </span>

                            </div>

                            <p>
                                Look at the timeline. What did the delegation
                                achieve in London?
                            </p>

                        </div>

                    </div>


                    <!-- Message 2 -->

                    <div class="chat-message">

                        <div class="message-avatar">
                            NH
                        </div>

                        <div class="message-content">

                            <div class="message-top">

                                <strong>
                                    Nur Hannah
                                </strong>

                                <span>
                                    11:17
                                </span>

                            </div>

                            <p>
                                They agreed on independence on 31 August
                                1957, cikgu.
                            </p>

                        </div>

                    </div>


                    <!-- Message 3 -->

                    <div class="chat-message">

                        <div class="message-avatar">
                            AA
                        </div>

                        <div class="message-content">

                            <div class="message-top">

                                <strong>
                                    Aiman (you)
                                </strong>

                                <span>
                                    11:18
                                </span>

                            </div>

                            <p>
                                It also showed cooperation between the Malay
                                Rulers and the Alliance.
                            </p>

                        </div>

                    </div>


                    <!-- Message 4 -->

                    <div class="chat-message">

                        <div class="message-avatar">
                            CN
                        </div>

                        <div class="message-content">

                            <div class="message-top">

                                <strong>
                                    Cikgu Nurul
                                </strong>

                                <span>
                                    11:18
                                </span>

                            </div>

                            <p>
                                Good points! We will check your understanding
                                with a live quiz next.
                            </p>

                        </div>

                    </div>

                </div>


                <!-- ==========================
                     CHAT INPUT
                =========================== -->

                <div class="chat-input-container">

                    <input
                        type="text"
                        class="chat-input"
                        placeholder="Type a message..." />

                    <button class="send-button">
                        ➤
                    </button>

                </div>

            </aside>

        </section>

    </main>

</form>

</body>
</html>