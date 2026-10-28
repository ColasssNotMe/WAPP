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

    <form id="form1" runat="server">

    <uc:Header runat="server" />
        <div class="breadcrumb">
            Learning Material <span> </span>
            <span id="titleLabel" runat="server">/</span>
            <span id="chapterLabel" runat="server">/</span>
        </div>

        <main class="learning-container">

            <div class="chapter-navigation">

                <a href="StudentLearningMaterial.aspx" class="topic-navigation previous-topic">
                    <img src="svg/left-arrow.svg" width="30" height="30" class="arrow"/>

                    <span class="topic-text">
                        <span class="topic-title">Back to Learning Material</span>
                    </span>
                </a>

            </div>

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

    <uc:Footer runat="server" />
    </form>

</body>
</html>
