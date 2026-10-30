
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentClassLearningMaterial.aspx.cs" Inherits="Assignment.StudentClassLearningMaterial" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Class Learning Materials</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentClassLearningMaterial.css" />
</head>
<body>
    <form id="form1" runat="server">
        <uc:Header runat="server" />

        <main class="learning-page">
            <div class="page-toolbar">
                <a href="StudentDashboard.aspx" class="topic-navigation return">
                    <span class="arrow">&#8592;</span>
                    <span class="topic-title">Return To Dashboard</span>
                </a>
            </div>

            <section class="learning-header">
                <h1>
                    <asp:Literal ID="litClassName" runat="server" />
                </h1>
                <p>Learning Material</p>
            </section>

            <section class="search-container">
                <div class="search-box">
                    <svg xmlns="http://www.w3.org/2000/svg"
                         width="20"
                         height="20"
                         viewBox="0 0 24 24"
                         fill="none"
                         stroke="currentColor"
                         stroke-width="1.8"
                         stroke-linecap="round"
                         stroke-linejoin="round"
                         aria-hidden="true">
                        <circle cx="11" cy="11" r="7"></circle>
                        <path d="m20 20-4-4"></path>
                    </svg>

                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="search-input"
                        placeholder="Search materials..."
                        AutoPostBack="true"
                        OnTextChanged="txtSearch_TextChanged" />
                </div>
            </section>

            <section class="materials-grid">
                <asp:Repeater
                    ID="rptMaterials"
                    runat="server"
                    OnItemCommand="rptMaterials_ItemCommand">

                    <ItemTemplate>
                        <article class="material-card">
                            <span class="chapter-badge">
                                Chapter <%#: Eval("chapter") %>
                            </span>

                            <h2><%#: Eval("title") %></h2>

                            <div class="card-footer">
                                <p class="duration-text">
                                    <%#: Eval("durationMins") %> mins reading
                                </p>

                                <asp:LinkButton
                                    ID="lnkViewMaterial"
                                    runat="server"
                                    CommandName="OpenMaterial"
                                    CommandArgument='<%# Eval("materialID") %>'
                                    CssClass="view-materials">
                                    <span>View Materials</span>
                                    <span class="card-arrow">&#8594;</span>
                                </asp:LinkButton>
                            </div>
                        </article>
                    </ItemTemplate>
                </asp:Repeater>
            </section>

            <asp:Panel
                ID="pnlNoMaterials"
                runat="server"
                CssClass="no-materials"
                Visible="false">
                No learning materials found for this class.
            </asp:Panel>
        </main>

        <uc:Footer runat="server" />
    </form>
</body>
</html>
