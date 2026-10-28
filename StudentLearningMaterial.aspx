<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentLearningMaterial.aspx.cs" Inherits="Assignment.StudentLearningMaterial" %>

<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Learning Materials</title>

    <link rel="stylesheet" href="index.css" />
    <link rel="stylesheet" href="StudentLearningmaterial.css" />
</head>

<body>

    <form id="form1" runat="server">
    <uc:Header runat="server" />

        <main class="learning-page">

            <div class="page-toolbar">
                <a href="HomePage.aspx" class="home-link">Home</a>
            </div>

            <section class="learning-header">

                <h1>Learning Materials</h1>

                <p>
                    Explore Sejarah topics and learning notes designed
                <br />
                    to guide you through key historical milestones.
                </p>

            </section>

            <section class="search-container">
                <div class="search-box">
                    <img src="svg/search.svg" height="30" width="30" />
                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="search-input"
                        placeholder="Search materials..."
                        AutoPostBack="true"
                        OnTextChanged="txtSearch_TextChanged"/>
                </div>
            </section>

            <section class="materials-grid" id="materialsGrid">

                <asp:Repeater ID="rptMaterials" runat="server"
                    OnItemCommand="rptMaterials_ItemCommand">

                    <ItemTemplate>

                        <article class="material-card">

                            <span class="chapter-badge">Chapter <%# Eval("chapter") %>
                            </span>

                            <div class="material-icon">
                                <i class="fa-regular fa-square"></i>
                            </div>

                            <h2>
                                <%# Eval("title") %>
                            </h2>

                            <div class="card-footer">

                                <p class="duration-text">
                                    Suggested reading duration: <%# Eval("durationMins") %> mins
                                </p>
                                <asp:LinkButton
                                    ID="lnkViewMaterial"
                                    runat="server"
                                    CommandName="OpenMaterial"
                                    CommandArgument='<%# Eval("materialID") %>'
                                    CssClass="view-materials">
                                    View Material
                                <img src="svg/right-arrow.svg"
                                    width="20"
                                    height="20"
                                    alt="View" />
                                </asp:LinkButton>

                            </div>

                        </article>

                    </ItemTemplate>

                </asp:Repeater>

            </section>
        </main>

    <uc:Footer runat="server" />
    </form>


</body>
</html>
