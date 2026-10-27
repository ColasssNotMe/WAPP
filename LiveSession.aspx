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

                    <!-- Presentation Area -->

                    <div class="presentation-screen">

                        <iframe
                            runat="server"
                            id="presentationFrame"
                            src="https://docs.google.com/presentation/d/e/2PACX-1vQ8k0J6Z3g5F7G9K8J9L4H5N2P3R4S5T6U7V8W9X0Y1Z2A3B4C5D6E7F8G9H0I1J2K3L4M5N6O7P8Q9R0S1T2U3V4W5X6Y7Z8/embed?start=false&loop=false&delayms=3000"
                            frameborder="0"
                            allowfullscreen="true"
                            mozallowfullscreen="true"
                            webkitallowfullscreen="true"   />

                    </div>


                    <!-- Presentation Controls -->

                    <div class="presentation-controls">

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