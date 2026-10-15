<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Profile</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- External Stylesheet -->
    <link rel="stylesheet" href="TeacherProfile.css">
</head>
<body>

    <div class="profile-container">
        
        <!-- Header Section with Back Arrow Button on Left and Centered Title -->
        <header class="profile-header">
            <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                <!-- Pure SVG Arrow Icon (No Lucide JS script required) -->
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
            </a>
            <h1 class="page-title">Teacher Profile</h1>
            <div class="header-spacer"></div>
        </header>

        <!-- Main Content Layout -->
        <div class="profile-content-grid">
            
            <!-- Left Column: Summary Card -->
            <aside class="card profile-summary-card">
                <div class="avatar-header">
                    <div class="avatar-circle">CN</div>
                    <div class="user-identity">
                        <h2>Cikgu Nurul</h2>
                        <p>Sejarah teacher • SMK Taman Melawati</p>
                    </div>
                </div>

                <div class="meta-details-list">
                    <div class="meta-row">
                        <span class="meta-label">Role</span>
                        <span class="meta-value">Teacher</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">School</span>
                        <span class="meta-value">SMK Taman Melawati</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Subject</span>
                        <span class="meta-value">Sejarah KSSM</span>
                    </div>
                    <div class="meta-row">
                        <span class="meta-label">Joined</span>
                        <span class="meta-value">January 2026</span>
                    </div>
                </div>
            </aside>

            <!-- Right Column: Account Settings Card -->
            <main class="card account-settings-card">
                <h2 class="settings-title">Account Settings</h2>
                
                <form class="settings-form" onsubmit="event.preventDefault();">
                    <div class="form-group">
                        <label for="fullName">Full name</label>
                        <input type="text" id="fullName" class="form-control" value="Cikgu Nurul" placeholder="Enter your full name">
                    </div>

                    <div class="form-group">
                        <label for="email">Email address</label>
                        <input type="email" id="email" class="form-control" value="nurul@ncient.edu.my" placeholder="Enter your email address">
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone number</label>
                        <input type="tel" id="phone" class="form-control" value="+60 12-345 6789" placeholder="Enter your phone number">
                    </div>

                    <div class="form-group">
                        <label for="school">School</label>
                        <input type="text" id="school" class="form-control" value="SMK Taman Melawati" placeholder="Enter your school name">
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">Save changes</button>
                        <button type="button" class="btn btn-secondary">Change password</button>
                    </div>
                </form>
            </main>

        </div>

    </div>

</body>
</html>