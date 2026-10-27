<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Classroom Details</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="ClassroomDetails.css">
</head>
<body>

    <div class="details-container">

        <header class="details-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Classroom Details</h1>

                </div>
            </div>

            <div class="students-badge">
                <span>30 students</span>
            </div>
        </header>

        <div class="details-content-grid">

            <main class="card main-details-card">

                <div class="card-header">
                    <div class="header-info">
                        <div class="card-icon-box">
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z"></path>
                                <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z"></path>
                            </svg>
                        </div>
                        <div class="title-meta">
                            <h2 class="class-name">4 Amanah • Sejarah</h2>
                            <span class="class-sub">Form 4 • 4 Amanah</span>
                        </div>
                    </div>
                    <span class="status-tag">Active</span>
                </div>

                <div class="meta-details-list">
                    <div class="meta-row">
                        <span class="meta-label">Teacher</span>
                        <span class="meta-value">Cikgu Nurul</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Invite code</span>
                        <span class="meta-value">SEJARAH-4A</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Created</span>
                        <span class="meta-value">January 2026</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Last updated</span>
                        <span class="meta-value">Today</span>
                    </div>
                </div>

                <div class="description-callout">
                    This classroom is used for daily lessons, live review sessions, and quiz assignments for Form 4 students.
                </div>

                <div class="card-actions">
                    <button type="button" class="btn btn-primary">Edit classroom</button>
                    <button type="button" class="btn btn-secondary">Copy invite code</button>
                </div>

            </main>

            <aside class="card quick-actions-card">
                <h2 class="card-title">Quick Actions</h2>

                <div class="actions-list">
                    <button type="button" class="btn btn-action-primary">Manage students</button>
                    <button type="button" class="btn btn-action-secondary">Manage topics</button>
                    <button type="button" class="btn btn-action-secondary">Manage quizzes</button>
                    <button type="button" class="btn btn-action-secondary">Start live session</button>
                </div>

            </aside>

        </div>

    </div>

</body>
</html>