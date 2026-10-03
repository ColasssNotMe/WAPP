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

    </style>
</head>

<body>
    <uc:Header ID="HeaderControl" runat="server" />

    <div class="hero">

        <div class="hero-content">

            <h1 class="hero-title">
                Learn History.<br />
                Test your Knowledge
            </h1>

            <h2 class="hero-subtitle">
                Discover the Past
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

</body>
</html>