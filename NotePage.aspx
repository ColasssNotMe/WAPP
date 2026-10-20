<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotePage.aspx.cs" Inherits="Assignment.MaterialPage" %>


<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Learning Material</title>

    <link href="index.css" rel="stylesheet" />
    <link href="NotePage.css" rel="stylesheet" />
</head>

<body>
    <uc:Header runat="server" />

    <form id="form1" runat="server">

        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <span>☒</span>
            Learning Material
            <span>/</span>
            Form 4
            <span>/</span>
            Chapter 1
        </div>

        <!-- Main Content -->
        <main class="learning-container">

            <!-- Chapter Navigation -->
            <div class="chapter-navigation">

                <!-- Previous Topic -->
                <a href="#" class="topic-navigation previous-topic">
                    <span class="arrow">←</span>

                    <div class="topic-text">
                        <span class="topic-label">Previous Topic</span>
                        <span class="topic-title">Chapter 2: Malaysian History
                        </span>
                    </div>
                </a>


                <!-- Next Topic -->
                <a href="#" class="topic-navigation next-topic">

                    <div class="topic-text">
                        <span class="topic-label">Next Topic</span>
                        <span class="topic-title">Chapter 4: Formation of Malaysia
                        </span>
                    </div>

                    <span class="arrow">→</span>
                </a>

            </div>


            <!-- PDF Viewer -->
            <div class="pdf-container">

                <iframe
                    id="pdfFrame"
                    runat="server"
                    class="pdf-frame"
                    title="Learning Material PDF"></iframe>

                <div id="materialNotFound" runat="server"
                    class="material-not-found"
                    visible="false">
                    <div class="empty-state">
                        <div class="empty-icon">📄</div>
                        <h2>Material Not Found</h2>
                        <p>The learning material is unavailable or may have been removed.</p>
                    </div>
                </div>
            </div>

        </main>
    </form>

    <uc:Footer runat="server" />

</body>
</html>
