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
            Learning Material
            <span id="titleLabel" runat="server">/</span>
            <span id="chapterLabel" runat="server">/</span>
        </div>

        <!-- Main Content -->
        <main class="learning-container">

            <!-- Chapter Navigation -->
            <div class="chapter-navigation">

                <a href="StudentLearningMaterial.aspx" class="topic-navigation previous-topic">
                    <span class="arrow">←</span>

                    <span class="topic-text">
                        <span class="topic-title">Back to Learning Material</span>
                    </span>
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
