<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BookDetails.aspx.cs" Inherits="BookDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <!-- Button for going back to catalogue -->
    <asp:Button ID="Button1" runat="server" Text="Go back" PostBackUrl="~/Catalogue.aspx" CssClass="backbutton" />
    <h1 style="color:black">Book details</h1>
    <!-- Invisible text field used to store the book's id -->
    <asp:TextBox ID="ParameterTextBox" runat="server" Visible="False" ReadOnly="True" Text=""></asp:TextBox>

    <br /> <br />
    <div style="overflow-y:scroll;height:69vh">

        <!-- List view used to show the book's details (displays only a single element) -->
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="Title" DataSourceID="DetailSource" OnItemDataBound="ItemDataBound">
     
            <EmptyDataTemplate>
                <!-- If for some reason the book id is wrong or empty -->
                <p style="text-align:center">There are no books corresponding to the selected criteria.</p>
                <br />
                <img class="center" src="images/others/errorbook.jpg" />
            </EmptyDataTemplate>
     
            <ItemTemplate>
                <!-- The book's details -->
                <table id="bookdetail" class="resulttable">
                    <tr>
                        <td class="booktitledetail">
                            <asp:Label ID="titleLabel" runat="server" Text='<%# Eval("Title") %>' />

                        </td>
                        <td class="invisiblecell"></td>
                    </tr>
                    <tr>
                        <td>
                            <table class="bookinfos">
                                <tr>
                                    <td  class="infoalignright">
                                        <p class="cellcontent">ISBN:</p>
                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="ISBNLabel" runat="server" Text='<%# Eval("ISBN") %>' />

                                    </td>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Book ID:</p>

                                    </td>
                                    <td class="infoalignleft bold" colspan="2">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("BookId") %>' />

                                    </td>
                                </tr>
                                <tr>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Author:</p>
                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="authorLabel" runat="server" Text='<%# Eval("Author") %>' />

                                    </td>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Date of publishing:</p>

                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="dateLabel" runat="server" Text='<%# Eval("PublishingDate", "{0:d}") %>' />

                                    </td>
                                    <td class="centerbutton">
                                </tr>
                                <tr>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Editor:</p>
                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="editorLabel1" runat="server" Text='<%# Eval("Publisher") %>' />

                                    </td>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Number of pages: </p>

                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="pagesLabel1" runat="server" Text='<%# Eval("NumOfPages") %>' />


                                    </td>
                                </tr>
                                <tr>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Genre:</p>
                                    </td>
                                    <td class="infoalignleft bold">
                                        <asp:Label ID="GenreLabel" runat="server" Text='<%# Eval("Genre") %>' />

                                    </td>
                                </tr>
                                <tr>
                                    <td class="infoalignright">
                                        <p class="cellcontent">Synopsis:</p>

                                    </td>
                                    <td colspan="4">
                                        <asp:Label ID="Synopsis" runat="server" Text='<%# Eval("Synopsis") %>' />
                                    </td>

                                </tr>
                            </table>
                        </td>
                        <td>
                            <asp:Image ID="image" runat="server" ImageUrl='<%# Eval("Image").ToString() == "" ? "~/images/books/NoImage.png" : Eval("Image") %>' AlternateText="Book Image" Height="200" Width="200" />
                        </td>
                    </tr>
                    <asp:LoginView ID="StatusLoginView" runat="server">

                        <LoggedInTemplate>
                            <tr>

                                <td class="infoalignright">
                                    <p class="cellcontent">Status:</p>
                                </td>
                                <td class="infoalignleft"><span class="boldtext">
                                    <asp:Label ID="statusLabel1" runat="server" Text='<%# Eval("Status") %>' />

                                </span></td>
                            </tr>
                        </LoggedInTemplate>


                    </asp:LoginView>
                </table>  

                <!-- Shows additional options for logged in users -->
                <asp:LoginView ID="ActionsLoginView" runat="server">
                             
                <RoleGroups>

                    <asp:RoleGroup Roles="User">
                        <ContentTemplate>
                            <!-- Allows users to reserve the book -->
                            <asp:Button ID="ReserveButton" runat="server" Text="Reserve this book" OnClick="reserveButton_Click" CssClass="reserve" />
                        </ContentTemplate>
                    </asp:RoleGroup>

                    <asp:RoleGroup Roles="Librarian, SuperLibrarian">
                        <ContentTemplate>
                            <!-- Allows librarians to delete the book, or handle borrowings and reservations -->
                            <div id="bookmanagement">
                            <span class="boldtext">
                                Manage book:
                            </span>
                            <br /><br />

                            <asp:Button ID="DeleteButton" runat="server" Text="Delete Book" OnClick="deleteButton_Click" style="float:right;margin:0px 50px"/>
                            
                            <!-- Only displays if book is borrowed, allows to see the borrower and declare the book's return -->
                            <span id="BorrowedView" runat="server">
                                This book is currently borrowed by:
                                <asp:Label ID="BorrowerLabel" runat="server"></asp:Label>
                                <br />
                                <asp:Button ID="ReturnButton" runat="server" Text="Signal return of the book" OnClick="returnButton_Click" />
                            </span>
                            
                            <!-- Only displays if book is available, allows to select a user to borrow the book -->
                            <span id="AvailableView" runat="server">
                                <asp:Button ID="BorrowButton" runat="server" Text="Signal borrowing of the book" OnClick="borrowButton_Click" />
                                by: 
                                <asp:DropDownList ID="BorrowerDropDownList" runat="server" 
                                    DataSourceID="BorrowerSource" DataTextField="UserName" DataValueField="UserName"></asp:DropDownList>
                                <asp:ListSearchExtender ID="ListSearchExtender1" runat="server" TargetControlID="BorrowerDropDownList"></asp:ListSearchExtender>
                            </span>

                            <!-- Displays the reservations made for this book -->
                            <p style="margin-left:2%">Reservations:</p>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ReservationSource" 
                                BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowSorting="True"
                                DataKeyNames="UserName" CssClass="userstable">
                                <EmptyDataTemplate>This book has no reservations.</EmptyDataTemplate>
                                <Columns> 
                                    <asp:BoundField DataField="UserId" HeaderText="UserID" SortExpression="UserId"  Visible="False" />
                                    <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" />
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="CanBorrow" HeaderText="Can Borrow" SortExpression="CanBorrow" />
                                    <asp:BoundField DataField="Date" HeaderText="Date of Reservation" SortExpression="Date" />
                                    <asp:CommandField ShowDeleteButton="True"/>
                                </Columns>   
                                
                            </asp:GridView>
                                </div>
                        </ContentTemplate>
                    </asp:RoleGroup>
            
                    </RoleGroups>

                </asp:LoginView>

            </ItemTemplate>
     

        </asp:ListView>
        <p style="text-align:center">
            <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>
        </p>
    </div>

    <!-- Data source for the book's details shown in the list view -->
    <asp:SqlDataSource ID="DetailSource" runat="server"
         ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
         SelectCommand="
            SELECT TOP 1 [BookId], [Title], [ISBN], [Author], [Publisher], [PublishingDate], [NumOfPages], [Genre], [Image], [Status], [Synopsis] 
            FROM [Books]
            WHERE [BookId] = @bookId
        ">
        <selectparameters>
              <asp:controlparameter Name="bookId" ControlID="ParameterTextBox" PropertyName="Text"/>
          </selectparameters>
    </asp:SqlDataSource>

    <!-- Data source for the drop down list used to select which user will borrow a book -->
    <asp:SqlDataSource ID="BorrowerSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="
            SELECT [Us1].[UserName]
            FROM [aspnet_Users] AS [Us1] 
            JOIN [UserDetails] AS [UsDet] ON [Us1].[UserId] = [UsDet].[UserId]
            WHERE ([UsDet].[CanBorrow] = @canBorrow) AND ([Us1].[UserName] IN (
                SELECT [Us2].[UserName]
                FROM [aspnet_Users] AS [Us2]
                JOIN [aspnet_UsersInRoles] AS [UsR] ON [Us2].[UserId]=[UsR].[UserId]
                JOIN [aspnet_Roles] AS [Rol] ON [UsR].[RoleId]=[Rol].[RoleId]
                WHERE ([Rol].[RoleName] = @role)
                ))
        ">
        <SelectParameters>
            <asp:Parameter Name="role" Type="String" DefaultValue="User"/>
            <asp:Parameter Name="canBorrow" Type="Boolean" DefaultValue="True"/>
        </SelectParameters>
    </asp:SqlDataSource>

    <!-- Data source for the book's reservations table -->
    <asp:SqlDataSource ID="ReservationSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="
            SELECT [Us].[UserId], [Us].[UserName], [UsDet].[FirstName], [UsDet].[LastName], [UsDet].[CanBorrow], [Res].[Date]
            FROM [aspnet_Users] AS [Us] 
            JOIN [Reservations] AS [Res] ON [Us].[UserId]=[Res].[UserId]
            LEFT JOIN [UserDetails] AS [UsDet] ON [Us].[UserId]=[UsDet].[UserId]
            WHERE ([Res].[BookId] = @bookId)
            ORDER BY [Res].[Date]
        "
        DeleteCommand=" 
            DELETE FROM [Reservations] 
            WHERE [BookId] = @bookId AND [UserId] IN (
                SELECT [UserId]
                FROM [aspnet_Users]
                WHERE [UserName] = @userName
            )
        ">
        <SelectParameters>
             <asp:ControlParameter Name="bookId" Type="String" ControlID="ParameterTextBox" PropertyName="Text" />
         </SelectParameters>
        <DeleteParameters>
            <asp:ControlParameter Name="bookId" Type="String" ControlID="ParameterTextBox" PropertyName="Text" />
            <asp:Parameter Name="UserName" Type="String" />
        </DeleteParameters>
    </asp:SqlDataSource>

    <br /><br />

</asp:Content> 
 