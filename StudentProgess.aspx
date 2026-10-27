<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Progress</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="StudentProgess.css">
</head>
<body>

    <div class="progress-container">

        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Student Progress</h1>
                    <p class="page-subtitle">Track student mastery, quiz performance, and classroom engagement.</p>
                </div>
            </div>
        </header>

        <div class="progress-content-grid">

            <main class="card student-overview-card">
                <h2 class="card-title">Student Overview</h2>

                <div class="student-items-wrapper">

                    <div class="student-row">
                        <div class="student-info">
                            <h3 class="student-name">Aiman bin Abdullah</h3>
                            <p class="student-meta">user001 • 4 Amanah</p>
                        </div>
                        <span class="percentage-badge">92%</span>
                    </div>

                    <div class="student-row">
                        <div class="student-info">
                            <h3 class="student-name">Nurul Izzati</h3>
                            <p class="student-meta">user002 • 4 Amanah</p>
                        </div>
                        <span class="percentage-badge">88%</span>
                    </div>

                    <div class="student-row">
                        <div class="student-info">
                            <h3 class="student-name">Farhan bin Ahmad</h3>
                            <p class="student-meta">user003 • 4 Amanah</p>
                        </div>
                        <span class="percentage-badge">76%</span>
                    </div>

                    <div class="student-row">
                        <div class="student-info">
                            <h3 class="student-name">Siti Nurhaliza</h3>
                            <p class="student-meta">user004 • 4 Amanah</p>
                        </div>
                        <span class="percentage-badge">91%</span>
                    </div>

                </div>

                <button type="button" class="btn btn-export-report">Export report</button>
            </main>

            <aside class="card progress-details-card">
                <h2 class="card-title">Progress Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Student</span>
                        <span class="details-value">Aiman bin Abdullah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Classroom</span>
                        <span class="details-value">4 Amanah • Sejarah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Overall progress</span>
                        <span class="details-value">92%</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Last quiz</span>
                        <span class="details-value">Quiz – Chapter 3</span>
                    </div>
                </div>

                <div class="info-callout">
                    Aiman is on track with notes and quizzes, but needs extra review on Chapter 4 topics.
                </div>

                <div class="details-actions">
                    <button type="button" class="btn btn-primary">View report</button>
                    <button type="button" class="btn btn-secondary">Message student</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>