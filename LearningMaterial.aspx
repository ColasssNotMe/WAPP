<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LearningMaterial.aspx.cs" Inherits="Assignment.LearningMaterial" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>Learning Materials</title>

    <!-- Plus Jakarta Sans -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap"
        rel="stylesheet" />

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


        /* =========================================
           MAIN CONTAINER
        ========================================= */

        .materials-page {
            width: 90%;
            max-width: 1000px;

            margin: 35px auto 60px auto;
        }


        /* =========================================
           PAGE HEADER
        ========================================= */

        .materials-header {
            text-align: center;

            margin-bottom: 30px;
        }

        .materials-title {
            margin: 0;

            font-size: 2rem;
            line-height: 1.15;

            font-weight: 700;

            color: #111111;
        }

        .materials-subtitle {
            width: 600px;
            max-width: 90%;

            margin: 10px auto 20px auto;

            font-size: 1rem;
            line-height: 1.4;

            color: #333333;
        }


        /* =========================================
           SEARCH BAR
        ========================================= */

        .search-container {
            width: 600px;
            max-width: 90%;

            height: 45px;

            margin: 0 auto;

            display: flex;
            align-items: center;

            border: 1px solid #777777;

            border-radius: 8px;

            background-color: #ffffff;
        }

        .search-icon {
            width: 45px;

            display: flex;
            align-items: center;
            justify-content: center;

            flex-shrink: 0;
        }

        .search-icon svg {
            width: 18px;
            height: 18px;

            stroke: #111111;
        }

        .search-input {
            flex: 1;

            height: 100%;

            border: none;
            outline: none;

            padding: 0 10px 0 0;

            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 1rem;

            color: #222222;

            background-color: transparent;
        }

        .search-input::placeholder {
            color: #999999;
        }


        /* =========================================
           MATERIAL GRID
        ========================================= */

        .materials-grid {
            display: grid;

            grid-template-columns: repeat(2, 1fr);

            column-gap: 70px;
            row-gap: 50px;

            margin-top: 32px;
        }


        /* =========================================
           MATERIAL CARD
        ========================================= */

        .material-card {
            min-height: 190px;

            padding: 12px;

            display: flex;
            flex-direction: column;

            background-color: #d9d9d9;

            border-radius: 8px;

            color: #222222;
        }


        /* =========================================
           CARD TOP
        ========================================= */

        .material-card-top {
            display: flex;

            align-items: center;
            justify-content: space-between;

            margin-bottom: 8px;
        }


        /* Chapter badge */

        .chapter-badge {
            min-width: 65px;

            padding: 5px 12px;

            background-color: #ffffff;

            border-radius: 999px;

            text-align: center;

            font-size: 0.65rem;
            line-height: 1;

            color: #222222;
        }


        /* Close / placeholder icon */

        .card-icon {
            width: 25px;
            height: 25px;

            position: relative;

            flex-shrink: 0;
        }

        .card-icon::before,
        .card-icon::after {
            content: "";

            position: absolute;

            width: 22px;
            height: 1px;

            background-color: #555555;

            top: 12px;
            left: 1px;
        }

        .card-icon::before {
            transform: rotate(45deg);
        }

        .card-icon::after {
            transform: rotate(-45deg);
        }


        /* =========================================
           CARD CONTENT
        ========================================= */

        .material-card-title {
            margin: 0 0 8px 0;

            font-size: 1.5rem;
            line-height: 1.2;

            font-weight: 500;

            color: #222222;
        }

        .material-card-description {
            margin: 0;

            font-size: 1rem;
            line-height: 1.35;

            color: #555555;
        }


        /* =========================================
           CARD BOTTOM
        ========================================= */

        .material-card-bottom {
            margin-top: auto;

            display: flex;

            align-items: center;
            justify-content: space-between;
        }

        .subtopic-count {
            font-size: 0.7rem;

            color: #444444;
        }

        .view-button {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 7px;

            min-width: 120px;
            height: 30px;

            padding: 0 12px;

            border: none;
            border-radius: 999px;

            background-color: #ffffff;

            color: #222222;

            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 0.7rem;
            font-weight: 500;

            text-decoration: none;

            cursor: pointer;
        }

        .view-button svg {
            width: 14px;
            height: 14px;

            stroke: #222222;
        }

        .view-button:hover {
            background-color: #eeeeee;
        }


        /* =========================================
           LOAD MORE
        ========================================= */

        .load-more-container {
            display: flex;

            justify-content: center;

            margin-top: 60px;
        }

        .load-more-button {
            padding: 8px 18px;

            border: none;
            border-radius: 6px;

            background-color: #d9d9d9;

            color: #333333;

            font-family: "Plus Jakarta Sans", sans-serif;
            font-size: 0.8rem;
            font-weight: 500;

            cursor: pointer;
        }

        .load-more-button:hover {
            background-color: #c8c8c8;
        }


        /* =========================================
           RESPONSIVE
        ========================================= */

        @media (max-width: 700px) {

            .materials-page {
                width: 90%;
            }

            .materials-title {
                font-size: 1.75rem;
            }

            .materials-grid {
                grid-template-columns: 1fr;

                gap: 25px;
            }

            .materials-subtitle {
                font-size: 0.9rem;
            }

            .search-container {
                width: 100%;
            }

            .material-card-title {
                font-size: 1.3rem;
            }

            .material-card-description {
                font-size: 0.9rem;
            }

        }

    </style>

</head>


<body>

    <uc:Header ID="HeaderControl" runat="server" />

    <form id="form1" runat="server">

        <main class="materials-page">


            <!-- =========================================
                 PAGE HEADER
            ========================================== -->

            <section class="materials-header">

                <h1 class="materials-title">
                    Learning Materials
                </h1>

                <p class="materials-subtitle">
                    Explore Sejarah topics and learning notes designed
                    <br />
                    to guide you through key historical milestones.
                </p>


                <!-- Search -->

                <div class="search-container">

                    <div class="search-icon">

                        <svg viewBox="0 0 24 24"
                            fill="none"
                            stroke="currentColor"
                            stroke-width="2">

                            <circle cx="11" cy="11" r="7"></circle>

                            <line x1="16.5"
                                y1="16.5"
                                x2="21"
                                y2="21"></line>

                        </svg>

                    </div>

                    <input
                        type="text"
                        class="search-input"
                        placeholder="Search materials ..." />

                </div>

            </section>


            <!-- =========================================
                 MATERIAL CARDS
            ========================================== -->

            <section class="materials-grid">


                <!-- CARD 1 -->

                <article class="material-card">

                    <div class="material-card-top">

                        <span class="chapter-badge">
                            Chapter 1
                        </span>

                        <div class="card-icon"></div>

                    </div>


                    <h2 class="material-card-title">
                        Early Civilizations
                    </h2>


                    <p class="material-card-description">
                        Learn about important early civilizations
                        and their development across Southeast Asia
                        and global trade networks.
                    </p>


                    <div class="material-card-bottom">

                        <span class="subtopic-count">
                            4 Core Subtopics
                        </span>


                        <a href="#" class="view-button">

                            View Materials

                            <svg viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2">

                                <line x1="5"
                                    y1="12"
                                    x2="18"
                                    y2="12"></line>

                                <polyline points="13 7 18 12 13 17"></polyline>

                            </svg>

                        </a>

                    </div>

                </article>


                <!-- CARD 2 -->

                <article class="material-card">

                    <div class="material-card-top">

                        <span class="chapter-badge">
                            Chapter 1
                        </span>

                        <div class="card-icon"></div>

                    </div>


                    <h2 class="material-card-title">
                        Early Civilizations
                    </h2>


                    <p class="material-card-description">
                        Learn about important early civilizations
                        and their development across Southeast Asia
                        and global trade networks.
                    </p>


                    <div class="material-card-bottom">

                        <span class="subtopic-count">
                            4 Core Subtopics
                        </span>


                        <a href="#" class="view-button">

                            View Materials

                            <svg viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2">

                                <line x1="5"
                                    y1="12"
                                    x2="18"
                                    y2="12"></line>

                                <polyline points="13 7 18 12 13 17"></polyline>

                            </svg>

                        </a>

                    </div>

                </article>


                <!-- CARD 3 -->

                <article class="material-card">

                    <div class="material-card-top">

                        <span class="chapter-badge">
                            Chapter 1
                        </span>

                        <div class="card-icon"></div>

                    </div>


                    <h2 class="material-card-title">
                        Early Civilizations
                    </h2>


                    <p class="material-card-description">
                        Learn about important early civilizations
                        and their development across Southeast Asia
                        and global trade networks.
                    </p>


                    <div class="material-card-bottom">

                        <span class="subtopic-count">
                            4 Core Subtopics
                        </span>


                        <a href="#" class="view-button">

                            View Materials

                            <svg viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2">

                                <line x1="5"
                                    y1="12"
                                    x2="18"
                                    y2="12"></line>

                                <polyline points="13 7 18 12 13 17"></polyline>

                            </svg>

                        </a>

                    </div>

                </article>


                <!-- CARD 4 -->

                <article class="material-card">

                    <div class="material-card-top">

                        <span class="chapter-badge">
                            Chapter 1
                        </span>

                        <div class="card-icon"></div>

                    </div>


                    <h2 class="material-card-title">
                        Early Civilizations
                    </h2>


                    <p class="material-card-description">
                        Learn about important early civilizations
                        and their development across Southeast Asia
                        and global trade networks.
                    </p>


                    <div class="material-card-bottom">

                        <span class="subtopic-count">
                            4 Core Subtopics
                        </span>


                        <a href="#" class="view-button">

                            View Materials

                            <svg viewBox="0 0 24 24"
                                fill="none"
                                stroke="currentColor"
                                stroke-width="2">

                                <line x1="5"
                                    y1="12"
                                    x2="18"
                                    y2="12"></line>

                                <polyline points="13 7 18 12 13 17"></polyline>

                            </svg>

                        </a>

                    </div>

                </article>


            </section>


            <!-- =========================================
                 LOAD MORE
            ========================================== -->

            <div class="load-more-container">

                <button
                    type="button"
                    class="load-more-button">

                    Load More

                </button>

            </div>


        </main>

    </form>

    <uc:Footer ID="FooterControl" runat="server" />

</body>

</html>