<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="ManageStudents.css">
</head>
<body>

    <div class="student-list-container">
        
        <!-- Header Section -->
        <header class="page-header">
            <div class="header-left">
                <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="19" y1="12" x2="5" y2="12"></line>
                        <polyline points="12 19 5 12 12 5"></polyline>
                    </svg>
                </a>
                <div class="title-group">
                    <h1 class="page-title">Student List</h1>
                    <p class="page-subtitle">Track student progress, attendance, and classroom participation.</p>
                </div>
            </div>

            <div class="students-count-badge">
                <span>30 students</span>
            </div>
        </header>

        <!-- Student List Card Container -->
        <main class="card student-list-card">
            <div class="students-wrapper">

                <!-- Student Row 1 -->
                <div class="student-row">
                    <div class="student-info-group">
                        <div class="avatar-circle">A</div>
                        <div class="student-details">
                            <h2 class="student-name">Aiman bin Abdullah</h2>
                            <p class="student-meta">user001 • 4 Amanah</p>
                        </div>
                    </div>
                    <div class="student-status-group">
                        <span class="status-badge active">Active</span>
                        <span class="progress-percentage">92%</span>
                    </div>
                </div>

                <!-- Student Row 2 -->
                <div class="student-row">
                    <div class="student-info-group">
                        <div class="avatar-circle">N</div>
                        <div class="student-details">
                            <h2 class="student-name">Nurul Izzati</h2>
                            <p class="student-meta">user002 • 4 Amanah</p>
                        </div>
                    </div>
                    <div class="student-status-group">
                        <span class="status-badge active">Active</span>
                        <span class="progress-percentage">88%</span>
                    </div>
                </div>

                <!-- Student Row 3 -->
                <div class="student-row">
                    <div class="student-info-group">
                        <div class="avatar-circle">F</div>
                        <div class="student-details">
                            <h2 class="student-name">Farhan bin Ahmad</h2>
                            <p class="student-meta">user003 • 4 Amanah</p>
                        </div>
                    </div>
                    <div class="student-status-group">
                        <span class="status-badge active">Active</span>
                        <span class="progress-percentage">76%</span>
                    </div>
                </div>

                <!-- Student Row 4 -->
                <div class="student-row">
                    <div class="student-info-group">
                        <div class="avatar-circle">S</div>
                        <div class="student-details">
                            <h2 class="student-name">Siti Nurhaliza</h2>
                            <p class="student-meta">user004 • 4 Amanah</p>
                        </div>
                    </div>
                    <div class="student-status-group">
                        <span class="status-badge active">Active</span>
                        <span class="progress-percentage">91%</span>
                    </div>
                </div>

                <!-- Student Row 5 -->
                <div class="student-row">
                    <div class="student-info-group">
                        <div class="avatar-circle">M</div>
                        <div class="student-details">
                            <h2 class="student-name">Muhammad Irfan</h2>
                            <p class="student-meta">user005 • 4 Amanah</p>
                        </div>
                    </div>
                    <div class="student-status-group">
                        <span class="status-badge active">Active</span>
                        <span class="progress-percentage">84%</span>
                    </div>
                </div>

            </div>
        </main>

    </div>

</body>
</html>