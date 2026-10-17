<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Learning Materials / Notes</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="ManageNotes.css">
</head>
<body>

    <div class="notes-container">
        
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
                    <h1 class="page-title">Manage sNotes</h1>
                    <p class="page-subtitle">Publish structured notes, summaries, and reference materials for your students.</p>
                </div>
            </div>
        </header>

        <!-- Main Grid Layout -->
        <div class="notes-content-grid">
            
            <!-- Left Column: Notes Library Card -->
            <main class="card notes-library-card">
                <h2 class="card-title">Notes Library</h2>

                <div class="note-items-wrapper">
                    
                    <!-- Note 1 -->
                    <div class="note-row">
                        <div class="note-info">
                            <h3 class="note-name">Chapter 1 – Introduction to history</h3>
                            <p class="note-meta">Topic 1 • Updated today</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Note 2 -->
                    <div class="note-row">
                        <div class="note-info">
                            <h3 class="note-name">Chapter 2 – Malay kingdoms</h3>
                            <p class="note-meta">Topic 2 • Updated yesterday</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Note 3 -->
                    <div class="note-row">
                        <div class="note-info">
                            <h3 class="note-name">Chapter 3 – Colonial era</h3>
                            <p class="note-meta">Topic 3 • Updated 2 days ago</p>
                        </div>
                        <span class="status-badge published">Published</span>
                    </div>

                    <!-- Note 4 -->
                    <div class="note-row">
                        <div class="note-info">
                            <h3 class="note-name">Chapter 4 – Independence</h3>
                            <p class="note-meta">Topic 4 • Draft</p>
                        </div>
                        <span class="status-badge draft">Draft</span>
                    </div>

                </div>

                <!-- Add Note Button -->
                <button type="button" class="btn btn-add-note">Add note</button>
            </main>

            <!-- Right Column: Note Details Card -->
            <aside class="card note-details-card">
                <h2 class="card-title">Note Details</h2>

                <div class="details-list">
                    <div class="details-row">
                        <span class="details-label">Note</span>
                        <span class="details-value">Chapter 3 – Colonial era</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Topic</span>
                        <span class="details-value">Topic 3</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Classroom</span>
                        <span class="details-value">4 Amanah • Sejarah</span>
                    </div>
                    <div class="details-row">
                        <span class="details-label">Status</span>
                        <span class="details-value">Published</span>
                    </div>
                </div>

                <!-- Info Callout -->
                <div class="info-callout">
                    This note covers key dates, British administration, and Japanese occupation for the current lesson.
                </div>

                <!-- Action Buttons -->
                <div class="details-actions">
                    <button type="button" class="btn btn-primary">Edit note</button>
                    <button type="button" class="btn btn-secondary">Preview</button>
                </div>
            </aside>

        </div>

    </div>

</body>
</html>