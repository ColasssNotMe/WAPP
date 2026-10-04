<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="Assignment.Footer" %>


<style>
    .site-footer {
        width: 100%;
        background-color: #e9e9e9;
        color: #333;
        font-family: "Plus Jakarta Sans", Arial, sans-serif;
    }

    .footer-main {
        display: flex;
        justify-content: space-between;
        padding: 2rem 2.5rem 1.5rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    .footer-brand {
        width: 42%;
    }

    .footer-logo {
        width: 6.5rem;
        height: 2.5rem;
        margin-bottom: 1rem;
    }

        .footer-logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

    .footer-brand p {
        max-width: 24rem;
        margin: 0;
        font-size: 0.8rem;
        line-height: 1.6;
        color: #333;
    }

    .footer-links {
        display: flex;
        gap: 4.5rem;
        padding-right: 2rem;
    }

    .footer-column {
        display: flex;
        flex-direction: column;
        min-width: 5rem;
    }

        .footer-column h4 {
            margin: 0 0 0.7rem;
            font-size: 0.8rem;
            font-weight: 700;
            color: #222;
        }

        .footer-column a {
            margin-bottom: 0.55rem;
            color: #333;
            text-decoration: none;
            font-size: 0.8rem;
            line-height: 1.4;
        }

            .footer-column a:hover {
                text-decoration: underline;
            }

    .footer-bottom {
        border-top: 1px solid #c8c8c8;
        padding: 0.55rem 1.5rem;
    }

        .footer-bottom p {
            margin: 0;
            font-size: 0.55rem;
            color: #666;
        }
</style>

<footer class="site-footer">
    <div class="footer-main">

        <div class="footer-brand">
            <div class="footer-logo">
                <img src="Images/logo.png" alt="Ncient Education Logo" />
            </div>

            <p>
                Ncient empowers Malaysian secondary school students
                to master Sejarah through structured notes, interactive
                gamified quizzes, and live teacher-led sessions.
            </p>
        </div>

        <div class="footer-links">

            <div class="footer-column">
                <h4>NAVIGATION</h4>
                <a href="HomePage.aspx">Home</a>
                <a href="LearningMaterials.aspx">Learning Materials</a>
                <a href="Quiz.aspx">Quiz</a>
                <a href="LiveSession.aspx">Live Session</a>
                <a href="AboutUs.aspx">About Us</a>
            </div>

            <div class="footer-column">
                <h4>ACCOUNT</h4>
                <a href="Login.aspx">Login</a>
                <a href="Register.aspx">Register</a>
            </div>

            <div class="footer-column">
                <h4>SUPPORT</h4>
                <a href="HelpCentre.aspx">Help Centre</a>
                <a href="FAQ.aspx">FAQ</a>
                <a href="ContactUs.aspx">Contact Us</a>
                <a href="ReportProblem.aspx">Report a Problem</a>
            </div>

        </div>
    </div>

    <div class="footer-bottom">
        <p>
            © 2026 Ncient Education. All rights reserved.
            Made for Malaysian Sejarah Learners.
        </p>
    </div>
</footer>
