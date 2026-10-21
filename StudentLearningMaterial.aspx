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

    <uc:Header runat="server" />
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
                    <img src="svg/search.svg" height="50" width="50" />
                    <asp:TextBox
                        ID="txtSearch"
                        runat="server"
                        CssClass="search-input"
                        placeholder="Search materials..."
                        AutoPostBack="true"
                        OnTextChanged="txtSearch_TextChanged"/>
                </div>
            </section>





            <!-- Learning Materials -->
            <section class="materials-grid" id="materialsGrid">

                <asp:Repeater ID="rptMaterials" runat="server">

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

                                <p>
                                    <%# Eval("duratinoMins") %>
                                </p>
                                <a href='LearningMaterialDetails.aspx?id=<%# Eval("materialID") %>'
                                    class="view-materials">View Materials

                        <img src="svg/right-arrow.svg"
                            width="20"
                            height="20"
                            alt="View" />

                                </a>

                            </div>

                        </article>

                    </ItemTemplate>

                </asp:Repeater>

            </section>
        </main>

    </form>


    <uc:Footer runat="server" />

</body>
</html>
