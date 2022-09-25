<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="LibrarianList.aspx.cs" Inherits="superlibrarian_LibrarianList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <span class="headingspan">Librarians list:</span>
    
    <!-- Button to go to users' promotion to librarians page -->
    <asp:Button ID="Button1" runat="server" Text="Add librarian" PostBackUrl="~/superlibrarian/CreateLibrarian.aspx" CssClass="addbutton" />
    <br /><br />
      <div class="over">

    <!-- Grid view used to diplay the library's librarians -->
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="UserName"
        BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" AllowSorting="True" OnSelectedIndexChanged="selected" CssClass="userstable">
        
        <EmptyDataTemplate>
            <!-- When there are no librarians in the system -->
            There are no Librarians in the system.
        </EmptyDataTemplate>

        <Columns> 
            <asp:BoundField DataField="UserName" HeaderText="Username" SortExpression="UserName" ReadOnly="True" />
            <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
            <asp:BoundField DataField="Email" HeaderText="E-mail" SortExpression="Email" ReadOnly="True"/>

            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />

            <asp:TemplateField>
                <ItemTemplate>
                    <!-- Button used to demote a librarian into a user -->
                    <asp:Button ID="DemoteButton" Text="Demote to normal User" runat="server"  CommandName="select" CssClass="addbuttonsimple" />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>  
        
        <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
        <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
        <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
        <RowStyle BackColor="White" ForeColor="#003399" />
        <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
        <SortedAscendingCellStyle BackColor="#EDF6F6" />
        <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
        <SortedDescendingCellStyle BackColor="#D6DFDF" />
        <SortedDescendingHeaderStyle BackColor="#002876" />
    </asp:GridView>
    
    <!-- Data source for the grid view, with commands for updating some attributes and deleting the librarians -->
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="
        SELECT [Us1].[UserName], [Mem].[Email], [UsDet].[FirstName], [UsDet].[LastName]
        FROM [aspnet_Users] AS [Us1] 
        JOIN [aspnet_Membership] AS [Mem] ON [Us1].[UserId]=[Mem].[UserId]
        LEFT JOIN [UserDetails] AS [UsDet] ON [Us1].[UserId]=[UsDet].[UserId]
        WHERE ([Us1].[UserName] IN (
            SELECT [Us2].[UserName]
            FROM [aspnet_Users] AS [Us2]
            JOIN [aspnet_UsersInRoles] AS [UsR] ON [Us2].[UserId]=[UsR].[UserId]
            JOIN [aspnet_Roles] AS [Rol] ON [UsR].[RoleId]=[Rol].[RoleId]
            WHERE ([Rol].[RoleName] = @role)
        ))"
        DeleteCommand="DELETE FROM [aspnet_Users] WHERE [UserName] = @UserName"
        UpdateCommand="UPDATE [UserDetails] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [UserId] IN (SELECT [UserId] FROM [aspnet_Users] WHERE ([UserName] = @UserName))"
        >
        <SelectParameters>
            <asp:Parameter Name="role" Type="String" DefaultValue="Librarian"/>
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserName" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
            <div />

</asp:Content>
 