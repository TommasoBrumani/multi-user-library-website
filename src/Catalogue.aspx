<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="true" AutoEventWireup="true" CodeFile="Catalogue.aspx.cs" Inherits="Catalogue" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1 style="color:black">Our books</h1>
    <div class="searchtool">
    <!-- The search bar (filtered to avoid weird characters) -->
    <asp:TextBox ID="bookTextBox" runat="server" placeholder="Search title" CssClass="searchbar"></asp:TextBox>
    <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="bookTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom" ValidChars="._-,;:()'!? " runat="server">
    </asp:FilteredTextBoxExtender>
    <br />
    <asp:Button ID="searchButton" runat="server" Text="Search" OnClick="searchButton_Click" CssClass="searchbutton" />
    </div>
   


        <div class="displayresult">

            <!-- List view to display all of the books, or those whose title was searched -->
            <asp:ListView ID="ListView1" runat="server" DataKeyNames="BookId" DataSourceID="listDataSource"
                OnSelectedIndexChanged="selected">

                <EmptyDataTemplate>
                    <!-- When there are no books corresponding to the search string -->
                    There are no books corresponding to the selected criteria.
                </EmptyDataTemplate>

                <ItemTemplate>
                    <!-- The template for the books in the list -->
                    <table class="resulttable">
                        <tr>
                            <td class="booktitle">
                                <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("Title") %>' CssClass="booktitle" Font-Bold="True" />
                            </td>
                            <td class="invisiblecell">
                                <asp:Label ID="bookIdLabel" runat="server" Text='<%# Eval("BookId") %>' Visible="False" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table class="bookinfos">
                                    <tr>
                                        <td class="infoalignright">
                                            <p class="cellcontent">Author : </p>
                                        </td>
                                        <td class="infoalignleft">
                                            <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("Author") %>' Font-Bold="True" />
                                        </td>
                                        <td class="infoalignright">
                                            <p class="cellcontent">Date of publishing : </p>
                                        </td>
                                        <td class="infoalignleft">
                                            <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("PublishingDate", "{0:d}") %>' Font-Bold="True" />
                                        </td>
                                        <td class="centerbutton">
                                            <asp:Button ID="detailsButton" runat="server" Text="Details" CommandName="select" CssClass="detailsbutton" /></td>
                                    </tr>
                                    <tr>
                                        <td class="infoalignright">
                                            <p class="cellcontent">Editor :</p>
                                        </td>
                                        <td class="infoalignleft">
                                            <asp:Label ID="editorLabel1" runat="server" Text='<%# Eval("Publisher") %>' Font-Bold="True" />
                                        </td>
                                        <td class="infoalignright">
                                            <p class="cellcontent">Number of pages : </p>
                                        </td>
                                        <td class="infoalignleft">
                                            <asp:Label ID="pagesLabel1" runat="server" Text='<%# Eval("NumOfPages") %>' Font-Bold="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="infoalignright">
                                            <p class="cellcontent">Genre :</p>
                                        </td>
                                        <td class="infoalignleft">
                                            <asp:Label ID="genreLabel1" runat="server" Text='<%# Eval("Genre") %>' Font-Bold="True" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <asp:Image ID="image" runat="server" ImageUrl='<%# Eval("Image").ToString() == "" ? "~/images/books/NoImage.png" : Eval("Image") %>' AlternateText="Book Image" Height="100" Width="100" /></td>
                        </tr>

                        <!-- If the user is logged in, shows book availability -->
                        <asp:LoginView ID="LoginView1" runat="server">
                            <LoggedInTemplate>
                                <tr>

                                    <td class="infoalignright">
                                        <p class="cellcontent">Status :</p>
                                    </td>
                                    <td class="infoalignleft"><span class="boldtext">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Status") %>' />
                                    </span></td>
                                </tr>
                            </LoggedInTemplate>

                        </asp:LoginView>
                    </table>

                </ItemTemplate>

                <LayoutTemplate>
                    <!-- List layout, with the items and the navigation buttons at the bottom -->
                    <div id="itemPlaceholderContainer" runat="server" style="overflow-y: scroll; height: 70vh">
                        <span runat="server" id="itemPlaceholder" />
                    </div>

                    <div style="text-align: center">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="5">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="detailsbutton" />
                                <asp:NumericPagerField />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="detailsbutton" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </LayoutTemplate>

            </asp:ListView>
        </div>

    <!-- Data source to extract from the database the books with which to populate the list view on page load -->
    <asp:SqlDataSource ID="listDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="
                SELECT [BookId], [Title], [Author], [Publisher], [PublishingDate], [NumOfPages], [Genre], [Image], [Status] 
                FROM [Books]
                ORDER BY [Title]
        ">
    </asp:SqlDataSource>

</asp:Content>
