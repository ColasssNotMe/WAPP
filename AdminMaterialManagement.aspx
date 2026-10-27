<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminMaterialManagement.aspx.cs" Inherits="Assignment.AdminMaterialManagement" %>
<%@ Register Src="~/Header.ascx" TagPrefix="uc" TagName="Header" %>
<%@ Register Src="~/Footer.ascx" TagPrefix="uc" TagName="Footer" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Learning Materials Management | Ncient</title>
  <link rel="stylesheet" href="AdminMaterialManagement.css">
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <form id="form1" runat="server">
    <uc:Header ID="HeaderControl" runat="server" />

    <main class="dashboard">
      <header class="page-header">
        <div>
          <h1>Learning Materials Management</h1>
          <p>Manage learning notes, revision resources, and teacher uploads across the Sejarah syllabus.</p>
        </div>
        <span class="overview-pill"><asp:Label ID="lblPill" runat="server" /> materials</span>
      </header>

      <section class="content-grid" aria-label="Material library and details">
        <section class="panel">
          <h2 class="panel-heading">Material library</h2>
          <p class="panel-description">
            <asp:Label ID="lblTotalMaterials" runat="server" /> materials ·
            <asp:Label ID="lblPublishedCount" runat="server" /> published ·
            <asp:Label ID="lblDraftCount" runat="server" /> drafts
          </p>

          <div class="filter-row">
            <label class="search-field">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
              <asp:TextBox ID="txtSearch" runat="server" placeholder="Search material title" />
            </label>
            <asp:DropDownList ID="ddlClass" runat="server" CssClass="select-button" />
            <asp:Button ID="btnSearch" runat="server" CssClass="primary-button" Text="Search" OnClick="btnSearch_Click" />
            <asp:Button ID="btnReset" runat="server" CssClass="secondary-button" Text="Reset" OnClick="btnReset_Click" />
          </div>

          <div class="table-wrap">
            <table class="data-table">
              <thead>
                <tr>
                  <th>Title</th>
                  <th>Class</th>
                  <th>Created By</th>
                  <th>Upload Date</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <asp:Repeater ID="MaterialRepeater" runat="server" OnItemCommand="MaterialRepeater_ItemCommand">
                  <ItemTemplate>
                    <tr aria-selected='<%# GetSelected(Eval("materialID")) %>'>
                      <td class="material-title">
                        <asp:LinkButton runat="server" CssClass="row-select-link" CommandName="SelectMaterial" CommandArgument='<%# Eval("materialID") %>' Text='<%# Eval("title") %>' CausesValidation="false" />
                      </td>
                      <td><%# GetText(Eval("className")) %></td>
                      <td><%# GetText(Eval("teacherName")) %></td>
                      <td class="nowrap"><%# GetDate(Eval("uploadDate")) %></td>
                      <td class='<%# GetStatusClass(Eval("status")) %>'><%# GetText(Eval("status")) %></td>
                    </tr>
                  </ItemTemplate>
                </asp:Repeater>
                <asp:PlaceHolder ID="emptyMessage" runat="server" Visible="false">
                  <tr><td colspan="5" class="empty-row">No materials found.</td></tr>
                </asp:PlaceHolder>
              </tbody>
            </table>
          </div>

          <div class="pagination">
            <span class="pagination-note">
              Showing <asp:Label ID="lblShowing" runat="server" /> of
              <asp:Label ID="lblTotal" runat="server" /> materials
            </span>
          </div>
        </section>

        <aside class="panel">
          <h2 class="panel-heading">Material Details</h2>

          <asp:Panel ID="pnlDetails" runat="server">
            <dl class="detail-list">
              <dt>Material</dt><dd><asp:Label ID="lblDetTitle" runat="server" /></dd>
              <dt>Teacher</dt><dd><asp:Label ID="lblDetTeacher" runat="server" /></dd>
              <dt>Class</dt><dd><asp:Label ID="lblDetClass" runat="server" /></dd>
              <dt>Duration</dt><dd><asp:Label ID="lblDetDuration" runat="server" /></dd>
              <dt>Uploaded</dt><dd><asp:Label ID="lblDetDate" runat="server" /></dd>
              <dt>Comments</dt><dd><asp:Label ID="lblDetComments" runat="server" /></dd>
              <dt>Status</dt><dd><asp:Label ID="lblDetStatus" runat="server" /></dd>
            </dl>
            <div class="detail-actions">
              <asp:HyperLink ID="hlView" runat="server" CssClass="primary-button" Target="_blank" Text="View material" />
              <asp:Button ID="btnToggle" runat="server" CssClass="secondary-button" OnClick="btnToggle_Click"
                  OnClientClick="return confirm('Change the status of this material?');" />
              <asp:Button ID="btnDelete" runat="server" CssClass="danger-button" Text="Delete" OnClick="btnDelete_Click"
                  OnClientClick="return confirm('Are you sure you want to delete this learning material? This action cannot be undone.');" />
            </div>
          </asp:Panel>

          <asp:Panel ID="pnlNoSelection" runat="server" Visible="false">
            <p class="detail-note">No material selected.</p>
          </asp:Panel>
        </aside>
      </section>
    </main>

    <uc:Footer ID="FooterControl" runat="server" />
  </form>
</body>
</html>