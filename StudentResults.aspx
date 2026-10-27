<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Results</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="StudentResults.css">
</head>
<body>

    <div class="results-container">

        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Student Results</h1>
                    <p class="page-subtitle">Review quiz results, scores, and answer breakdowns for your students.</p>
                </div>
            </div>
        </header>

        <div class="results-content-grid">

            <main class="card quiz-results-card">
                <h2 class="card-title">Quiz Results</h2>

                <div class="quiz-items-wrapper">

                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 1</h3>
                            <p class="quiz-meta">10 questions • Completed</p>
                        </div>
                        <span class="percentage-badge">92%</span>
                    </div>

                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 2</h3>
                            <p class="quiz-meta">12 questions • Completed</p>
                        </div>
                        <span class="percentage-badge">88%</span>
                    </div>

                    <div class="quiz-row">
                        <div class="quiz-info">
                            <h3 class="quiz-name">Quiz – Chapter 3</h3>
                            <p class="quiz-meta">15 questions • Completed</p>
                        </div>
                        <span class="percentage-badge">91%</span>
                    </div>

                </div>

                <button type="button" class="btn btn-detailed-report">View detailed report</button>
            </main>

            <aside class="card result-details-card">
                <h2 class="card-title">Result Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Quiz</span>
                        <span class="details-value">Quiz – Chapter 3</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Student</span>
                        <span class="details-value">Aiman bin Abdullah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Score</span>
                        <span class="details-value">91%</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Completed</span>
                        <span class="details-value">Today</span>
                    </div>
                </div>

                <div class="info-callout">
                    Aiman answered 14 of 15 questions correctly and needs review on the final short-answer question.
                </div>

                <div class="details-actions">
                    <button type="button" class="btn btn-primary">View answers</button>
                    <button type="button" class="btn btn-secondary">Message student</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>