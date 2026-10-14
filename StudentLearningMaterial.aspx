<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentLearningMaterial.aspx.cs" Inherits="Assignment.StudentLearningMaterial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Learning Materials</title>

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentLearningmaterial.css" />
</head>

<body>

<form id="form1" runat="server">

    <main class="learning-page">

        <!-- Page Header -->
        <section class="learning-header">

            <h1>Learning Materials</h1>

            <p>
                Explore Sejarah topics and learning notes designed
                <br />
                to guide you through key historical milestones.
            </p>

        </section>


        <!-- Search -->
        <section class="search-container">

            <div class="search-box">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input
                    type="text"
                    id="searchMaterials"
                    placeholder="Search materials ..."
                    onkeyup="searchMaterials()" />

            </div>

        </section>


        <!-- Learning Materials -->
        <section class="materials-grid" id="materialsGrid">

            <!-- Card 1 -->
            <article class="material-card">

                <span class="chapter-badge">
                    Chapter 1
                </span>

                <div class="material-icon">
                    <i class="fa-regular fa-square"></i>
                </div>

                <h2>Early Civilizations</h2>

                <p>
                    Learn about important early civilizations and their
                    development across Southeast Asia and global trade networks.
                </p>

                <div class="card-footer">

                    <span class="subtopic-count">
                        4 Core Subtopics
                    </span>

                    <a href="LearningMaterialDetails.aspx"
                       class="view-materials">
                        View Materials
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </article>


            <!-- Card 2 -->
            <article class="material-card">

                <span class="chapter-badge">
                    Chapter 1
                </span>

                <div class="material-icon">
                    <i class="fa-regular fa-square"></i>
                </div>

                <h2>Early Civilizations</h2>

                <p>
                    Learn about important early civilizations and their
                    development across Southeast Asia and global trade networks.
                </p>

                <div class="card-footer">

                    <span class="subtopic-count">
                        4 Core Subtopics
                    </span>

                    <a href="LearningMaterialDetails.aspx"
                       class="view-materials">
                        View Materials
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </article>


            <!-- Card 3 -->
            <article class="material-card">

                <span class="chapter-badge">
                    Chapter 1
                </span>

                <div class="material-icon">
                    <i class="fa-regular fa-square"></i>
                </div>

                <h2>Early Civilizations</h2>

                <p>
                    Learn about important early civilizations and their
                    development across Southeast Asia and global trade networks.
                </p>

                <div class="card-footer">

                    <span class="subtopic-count">
                        4 Core Subtopics
                    </span>

                    <a href="LearningMaterialDetails.aspx"
                       class="view-materials">
                        View Materials
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </article>


            <!-- Card 4 -->
            <article class="material-card">

                <span class="chapter-badge">
                    Chapter 1
                </span>

                <div class="material-icon">
                    <i class="fa-regular fa-square"></i>
                </div>

                <h2>Early Civilizations</h2>

                <p>
                    Learn about important early civilizations and their
                    development across Southeast Asia and global trade networks.
                </p>

                <div class="card-footer">

                    <span class="subtopic-count">
                        4 Core Subtopics
                    </span>

                    <a href="LearningMaterialDetails.aspx"
                       class="view-materials">
                        View Materials
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </article>

        </section>

    </main>

</form>



</body>
</html>