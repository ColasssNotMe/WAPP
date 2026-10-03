<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Assignment.HomePage" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>History Quiz</title>

    <style type="text/css">
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #ffffff;
        }

        /* Main hero section */
        .hero {
            width: 90%;
            max-width: 1000px;
            margin: 35px auto;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 55px;
        }

        /* Left section */
        .hero-content {
            width: 42%;
        }

        .hero-title {
            margin: 0;
            font-size: 2rem;
            line-height: 1.15;
            font-weight: 700;
            color: #111111;
        }

        .hero-subtitle {
            margin: 12px 0 18px 0;
            font-size: 1.5rem;
            font-weight: 400;
            text-align: center;
            color: #111111;
        }

        .hero-description {
            margin: 0 0 12px 0;
            font-size: 1rem;
            line-height: 1.35;
            text-align: justify;
            color: #222222;
        }

        /* Buttons */
        .button-container {
            display: flex;
            gap: 45px;
            margin-top: 8px;
        }

        .hero-button {
            border: none;
            background-color: #d9d9d9;
            color: #333333;
            padding: 7px 13px;
            border-radius: 6px;
            font-size: 9px;
            cursor: pointer;
        }

            .hero-button:hover {
                background-color: #c8c8c8;
            }

        /* Right image */
        .hero-image {
            width: 240px;
            height: 136px;
            object-fit: cover;
            display: block;
        }

        .stats-container {
            width: 100%;
            display: flex;
            justify-content: space-around;
            align-items: center;
            background-color: #d9d9d9;
            border-radius: 5px;
            padding: 10px 0;
            box-sizing: border-box;
        }

        .stat-item {
            flex: 1;
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #111;
            margin-bottom: 5px;
        }

        .stat-label {
            font-size: 1rem;
            color: #333;
        }


        .learning-section {
            width: 90%;
            max-width: 1000px;
            margin: 30px auto 50px auto;
            text-align: center;
        }

        .learning-title {
            margin: 0;
            font-size: 2rem;
            font-weight: bold;
            color: #111111;
        }

        .learning-subtitle {
            width: 600px;
            max-width: 90%;
            margin: 8px auto 25px auto;
            font-size: 1rem;
            line-height: 1.4;
            color: #555555;
        }

        /* Four cards */
        .learning-cards {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            text-align: left;
        }

        .learning-card {
            flex: 1;
            min-height: 175px;
            padding: 14px;
            background-color: #d9d9d9;
            border-radius: 8px;
            color: #222222;
        }

        /* Image / icon placeholder */
        .card-icon {
            width: 34px;
            height: 34px;
            margin-bottom: 10px;
            border: 1px solid #777777;
            background-color: #d9d9d9;
            position: relative;
        }

            /* Create the X shown in your screenshot */
            .card-icon::before,
            .card-icon::after {
                content: "";
                position: absolute;
                width: 45px;
                height: 1px;
                background-color: #777777;
                top: 16px;
                left: -6px;
            }

            .card-icon::before {
                transform: rotate(45deg);
            }

            .card-icon::after {
                transform: rotate(-45deg);
            }

        .card-title {
            margin: 0 0 8px 0;
            font-size: 1.5rem;
            font-weight: bold;
            color: #222222;
        }

        .card-description {
            margin: 0;
            min-height: 58px;
            font-size: 1rem;
            line-height: 1.45;
            color: #555555;
        }

        .card-link {
            display: inline-block;
            margin-top: 10px;
            color: #111111;
            text-decoration: none;
            font-size: 1rem;
            font-weight: bold;
        }

            .card-link:hover {
                text-decoration: underline;
            }
    </style>
</head>

<body>
    <uc:Header ID="HeaderControl" runat="server" />

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
                src="https://picsum.photos/240/136"
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


    <hr style="margin: 20px 0; border: none; height: 2px; background-color: black" />

<div class="learning-section">

    <h3 class="learning-title">
        Everything You Need to Learn Sejarah
    </h3>

    <p class="learning-subtitle">
        Built purposefully to replace dry textbook memorization with visual
        storytelling, active recall drills, and direct educator guidance.
    </p>


    <div class="learning-cards">

        <!-- Card 1 -->
        <div class="learning-card">

            <div class="card-icon"></div>

            <h4 class="card-title">
                Learning Materials
            </h4>

            <p class="card-description">
                Access Sejarah notes and structured
                materials. Comprehensive chapter
                summaries, mind maps, and historical
                chronologies designed for rapid revision.
            </p>

            <a href="#" class="card-link">
                Explore Notes →
            </a>

        </div>


        <!-- Card 2 -->
        <div class="learning-card">

            <div class="card-icon"></div>

            <h4 class="card-title">
                Interactive Quizzes
            </h4>

            <p class="card-description">
                Test knowledge with available
                History quizzes. Gamified topic
                drills, exam scenario questions, and
                timed trial paper simulations.
            </p>

            <a href="#" class="card-link">
                Attempt Quizzes →
            </a>

        </div>


        <!-- Card 3 -->
        <div class="learning-card">

            <div class="card-icon"></div>

            <h4 class="card-title">
                Live Session
            </h4>

            <p class="card-description">
                Join classroom live sessions and
                learn directly with teachers. Ask
                questions in real-time, clarify
                confusing timelines, and review past
                exam topics.
            </p>

            <a href="#" class="card-link">
                Join Schedule →
            </a>

        </div>


        <!-- Card 4 -->
        <div class="learning-card">

            <div class="card-icon"></div>

            <h4 class="card-title">
                Learning Progress
            </h4>

            <p class="card-description">
                Track quiz results and syllabus
                mastery. Get granular breakdowns of
                topic scores before actual school
                examinations with actionable study
                recommendations.
            </p>

            <a href="#" class="card-link">
                View Progress →
            </a>

        </div>

    </div>

</div>

</body>
</html>
