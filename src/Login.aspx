<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Just a quick login page, handled graciously by ASP.net -->
    <div id="loginpage">
        <asp:Login ID="Login1" runat="server" TextLayout="TextOnTop"  Width="100%" LoginButtonStyle-CssClass="loginbutton" ToolTip="If you don't have an account, ask one of the librarians" DestinationPageUrl="~/Default.aspx"></asp:Login>
    </div>

</asp:Content>

