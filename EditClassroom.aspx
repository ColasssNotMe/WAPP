<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Classroom</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="EditClassroom.css">
</head>
<body>

    <div class="create-container">

        <header class="create-header">
            <a href="javascript:history.back()" class="back-btn" aria-label="Go Back">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="19" y1="12" x2="5" y2="12"></line>
                    <polyline points="12 19 5 12 12 5"></polyline>
                </svg>
            </a>
            <h1 class="page-title">Edit Classroom</h1>
            <div class="header-spacer"></div>
        </header>

        <main class="card classroom-details-card">
            <h2 class="card-title">Classroom Details</h2>

            <form class="create-form" onsubmit="event.preventDefault();">

                <div class="form-group">
                    <label for="classroomName">Classroom name</label>
                    <input type="text" id="classroomName" class="form-control" value="Sejarah Form 4 • 4 Amanah" placeholder="Enter classroom name">
                </div>

                <div class="form-row-two">
                    <div class="form-group">
                        <label for="formSelect">Form</label>
                        <input type="text" id="formSelect" class="form-control" value="Form 4" placeholder="e.g. Form 4">
                    </div>
                    <div class="form-group">
                        <label for="classSelect">Class</label>
                        <input type="text" id="classSelect" class="form-control" value="4 Amanah" placeholder="e.g. 4 Amanah">
                    </div>
                </div>

                <div class="form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" class="form-control" value="Sejarah KSSM" placeholder="Enter subject name">
                </div>

                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" class="form-control text-area" rows="4" placeholder="Enter classroom description...">Primary classroom for Form 4 Sejarah lessons, quizzes, and live review sessions.</textarea>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Create classroom</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back()">Cancel</button>
                </div>

            </form>
        </main>

    </div>

</body>
</html>