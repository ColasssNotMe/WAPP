<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Session Management</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="LiveSessionManagement.css">
</head>
<body>

    <div class="sessions-container">
        
        <!-- Header Section with Left Back Arrow -->
        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Live Session Management</h1>
                    <p class="page-subtitle">Schedule, manage, and monitor live teacher-led sessions for your classrooms.</p>
                </div>
            </div>
        </header>

        <!-- Main Grid Layout -->
        <div class="sessions-content-grid">
            
            <!-- Left Column: Upcoming Sessions Card -->
            <main class="card sessions-list-card">
                <h2 class="card-title">Upcoming Sessions</h2>

                <div class="session-items-wrapper">
                    
                    <!-- Session 1 -->
                    <div class="session-row">
                        <div class="session-info">
                            <h3 class="session-name">Live review – Chapter 3</h3>
                            <p class="session-meta">Tue • 2:30 PM • 4 Amanah</p>
                        </div>
                        <span class="status-badge scheduled">Scheduled</span>
                    </div>

                    <!-- Session 2 -->
                    <div class="session-row">
                        <div class="session-info">
                            <h3 class="session-name">Live quiz – Chapter 2</h3>
                            <p class="session-meta">Thu • 10:00 AM • Sejarah Revision</p>
                        </div>
                        <span class="status-badge scheduled">Scheduled</span>
                    </div>

                    <!-- Session 3 -->
                    <div class="session-row">
                        <div class="session-info">
                            <h3 class="session-name">Q&A session – Form 4</h3>
                            <p class="session-meta">Fri • 1:00 PM • Sejarah KBAT Workshop</p>
                        </div>
                        <span class="status-badge scheduled">Scheduled</span>
                    </div>

                </div>

                <!-- Schedule Session Button -->
                <button type="button" class="btn btn-schedule-session">Schedule session</button>
            </main>

            <!-- Right Column: Session Details Card -->
            <aside class="card session-details-card">
                <h2 class="card-title">Session Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Session</span>
                        <span class="details-value">Live review – Chapter 3</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Classroom</span>
                        <span class="details-value">4 Amanah • Sejarah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Date</span>
                        <span class="details-value">Tue • 2:30 PM</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Duration</span>
                        <span class="details-value">45 minutes</span>
                    </div>
                </div>

                <!-- Info Callout -->
                <div class="info-callout">
                    Use this session to review Chapter 3 notes, answer questions, and prepare students for the next quiz.
                </div>

                <!-- Action Buttons -->
                <div class="details-actions">
                    <button type="button" class="btn btn-primary">Edit session</button>
                    <button type="button" class="btn btn-secondary">Start session</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>