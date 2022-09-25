<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Borrowings.aspx.cs" Inherits="user_Borrowings" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="contentwrap">
          
        <span class="headingspan">Borrowed books: </span><br />

        <div class="searchtool">
        <!-- This span is only shown to librarians, and allows to switch between the borrowings of different users -->
            <span id="LibrarianView" runat="server">
                By User: 
                <asp:DropDownList ID="BorrowerDropDownList" runat="server" AutoPostBack="True" 
                    DataSourceID="BorrowerSource" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
                <asp:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="BorrowerDropDownList"></asp:ListSearchExtender>                      
            </span>

            <br /><br />

            <!-- Search bar -->
            <asp:TextBox ID="bookTextBox" runat="server" placeholder="Search title" CssClass="searchbar"></asp:TextBox> 
            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="bookTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars="._-,;:()'!? " runat="server">
            </asp:FilteredTextBoxExtender>
            <asp:Button ID="searchButton" runat="server" Text="Search" OnClick="searchButton_Click" CssClass="searchbutton" />
        </div>

        <br/><br />

        <!-- List view for displaying the  borrowed books -->
        <asp:ListView ID="ListView1" runat="server" DataSourceID="listDataSource" >
     
            <EmptyDataTemplate>
                <!-- When there are no books corresponding to the search screen -->
                There are no books corresponding to the selected criteria.
            </EmptyDataTemplate>
     
            <ItemTemplate>
                <!-- The template for the books in the list -->
                <div style="float:left;margin:0px 50px">
                   <asp:Image ID="image" runat="server" ImageUrl='<%# Eval("Image").ToString() == "" ? "~/images/books/NoImage.png" : Eval("Image") %>' AlternateText="Book Image" Height="120" Width="120" />
                </div>
                <br />
                <span class="boldtext"> 
                  <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("Title") %>' />
                </span>
                <br />
                Author:
                <span class="boldtext">
                  <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("Author") %>' />
                </span>
                Date of publishing:
                <span class="boldtext">
                  <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("PublishingDate", "{0:d}") %>' />
                </span>
                <br />
                Status:
                <span class="boldtext">
                  <asp:Label ID="statusLabel1" runat="server" Text='<%# Eval("Status") %>' />
                </span>
                Due Date:
                <span class="boldtext">
                  <asp:Label ID="dueDateLabel1" runat="server" Text='<%# Eval("DueDate", "{0:d}") %>' />
                </span>
                <br /><br /><br /><br />
            </ItemTemplate>

            <LayoutTemplate>
                <!-- List layout, with the items and the navigation buttons at the bottom -->
                <div id="itemPlaceholderContainer" runat="server" style="overflow-y: scroll; height: 65vh">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="text-align:center">
                    <asp:DataPager ID="DataPager1" runat="server" PageSize="3">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="detailsbutton" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="detailsbutton" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
     
         </asp:ListView>

        <!-- Data source for the drop down list used by librarians to select which user's borrowings to see -->
        <asp:SqlDataSource ID="BorrowerSource" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="
                SELECT DISTINCT [Us1].[UserName]
                FROM [aspnet_Users] AS [Us1] 
                WHERE ([Us1].[UserName] IN (
                    SELECT [Us2].[UserName]
                    FROM [aspnet_Users] AS [Us2]
                    JOIN [aspnet_UsersInRoles] AS [UsR] ON [Us2].[UserId]=[UsR].[UserId]
                    JOIN [aspnet_Roles] AS [Rol] ON [UsR].[RoleId]=[Rol].[RoleId]
                    WHERE ([Rol].[RoleName] = @role)
                    ))
            ">
            <SelectParameters>
                <asp:Parameter Name="role" Type="String" DefaultValue="User"/>
            </SelectParameters>
        </asp:SqlDataSource>

        <!-- Data source to extract from the database the books with which to populate the list view on page load -->
        <asp:SqlDataSource ID="listDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="
                SELECT [Boo].[Title], [Boo].[Author], [Boo].[PublishingDate], [Boo].[Image], [Boo].[Status], [Bor].[DueDate] 
                FROM [Books] AS [Boo]
                JOIN [Borrowings] AS [Bor] ON [Boo].[BookId] = [Bor].[BookId]            
                WHERE ([UserId] IN (
                    SELECT [UserId] 
                    FROM [aspnet_Users] 
                    WHERE([Username] = @UserName)
                ))
            ">
             <SelectParameters>
                <asp:ControlParameter Name="UserName" Type="String" ControlID="BorrowerDropDownList" PropertyName="Text" />
            </SelectParameters>
         </asp:SqlDataSource>
    </div>
</asp:Content>
