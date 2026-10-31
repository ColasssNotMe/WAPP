<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Assignment.HomePage" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html>

<head runat="server">
    <title>Ncient</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
    <link href="~/index.css" rel="stylesheet" />
    <link href="~/Homepage.css" rel="stylesheet" />

</head>

<body>
    <form runat="server">
        <uc:Header ID="HeaderControl" runat="server" />

        <div class="bg-container-color-only">

            <div class="hero">

                <div class="hero-content">

                    <h1 class="hero-title">Learn History.<br />
                        Test your Knowledge
                    </h1>

                    <h2 class="hero-subtitle">Discover the Past
                    </h2>

                    <p class="hero-description">
                        Explore Sejarah through interactive visual folios, bite-sized
                chronological breakdowns, gamified exam drills, and live
                teacher-led masterclasses crafted specifically for SPM excellence.
                    </p>

                    <div class="button-container">
                        <button class="hero-button" type="button">
                            Start Learning
                        </button>

                        <button class="hero-button" type="button">
                            Take A Quiz
                        </button>
                    </div>

                </div>

                <div>
                    <img class="hero-image"
                        src="img/hero.png"
                        alt="History Image" />
                </div>

            </div>
            <div class="stats-container">

                <div class="stat-item">
                    <div class="stat-number">10+</div>
                    <div class="stat-label">Learning Material</div>
                </div>

                <div class="stat-item">
                    <div class="stat-number">120+</div>
                    <div class="stat-label">Quiz Question</div>
                </div>

                <div class="stat-item">
                    <div class="stat-number">98.4%</div>
                    <div class="stat-label">Grade Pass Student</div>
                </div>
            </div>

        </div>

        <hr style="margin: 0 0 20px 0; border: none; height: 2px; background-color: black" />

        <div class="learning-section">

            <h3 class="learning-title">Everything You Need to Learn Sejarah
            </h3>

            <p class="learning-subtitle">
                Built purposefully to replace dry textbook memorization with visual
        storytelling, active recall drills, and direct educator guidance.
            </p>

            <div class="learning-cards">

                <div class="learning-card">

                    <div class="card-icon">
                        <span class="material-symbols-outlined">menu_book</span>
                    </div>
                    <h4 class="card-title">Learning Materials
                    </h4>

                    <p class="card-description">
                        Access Sejarah notes and structured
                materials. Comprehensive chapter
                summaries, mind maps, and historical
                chronologies designed for rapid revision.
                    </p>


                </div>

                <div class="learning-card">

                    <div class="card-icon">
                        <span class="material-symbols-outlined">quiz</span>
                    </div>
                    <h4 class="card-title">Interactive Quizzes
                    </h4>

                    <p class="card-description">
                        Test knowledge with available
                History quizzes. Gamified topic
                drills, exam scenario questions, and
                timed trial paper simulations.
                    </p>


                </div>

                <div class="learning-card">

                    <div class="card-icon">
                        <span class="material-symbols-outlined">co_present</span>
                    </div>
                    <h4 class="card-title">Live Session
                    </h4>

                    <p class="card-description">
                        Join classroom live sessions and
                learn directly with teachers. Ask
                questions in real-time, clarify
                confusing timelines, and review past
                exam topics.
                    </p>


                </div>

                <div class="learning-card">

                    <div class="card-icon">
                        <span class="material-symbols-outlined">monitoring</span>
                    </div>
                    <h4 class="card-title">Learning Progress
                    </h4>

                    <p class="card-description">
                        Track quiz results and syllabus
                mastery. Get granular breakdowns of
                topic scores before actual school
                examinations with actionable study
                recommendations.
                    </p>


                </div>
            </div>
        </div>

        <hr style="margin: 0 20px 0 0; border: none; height: 2px; background-color: black" />

        <section class="how-it-works">

            <div class="how-it-works-container">

                <p class="how-label">
                    Simple Step
                </p>

                <h2 class="how-title">How Ncient Works
                </h2>

                <p class="how-description">
                    A three-step evidence-based learning cycle tailored to help
            Malaysian students retain historical concepts and conquer
            exam formats effortlessly.
                </p>

                <div class="how-cards">

                    <div class="how-card">

                        <div class="how-card-top">

                            <div class="how-number">
                                01
                            </div>

                        </div>

                        <h3 class="how-card-title">Learn
                        </h3>

                        <p class="how-card-description">
                            Explore History learning materials and notes.
                    Study bite-sized chapter breakdowns, audio summaries,
                    and chronologies organized by standard KSSM syllabus units.
                        </p>

                    </div>

                    <div class="how-card">

                        <div class="how-card-top">

                            <div class="how-number">
                                02
                            </div>

                        </div>

                        <h3 class="how-card-title">Practice
                        </h3>

                        <p class="how-card-description">
                            Attempt quizzes and test your understanding.
                    Challenge yourself with topical quizzes, past-year
                    trials, and earn mastery badges to reinforce memory retention.
                        </p>

                    </div>

                    <div class="how-card">

                        <div class="how-card-top">

                            <div class="how-number">
                                03
                            </div>

                        </div>

                        <h3 class="how-card-title">Improve
                        </h3>

                        <p class="how-card-description">
                            Attempt quizzes and test your understanding.
                    Challenge yourself with topical quizzes, past-year
                    trials, and earn mastery badges to reinforce memory retention.
                        </p>

                    </div>

                </div>

            </div>

        </section>

        <uc:Footer ID="FooterControl" runat="server" />
    </form>

</body>
</html>
