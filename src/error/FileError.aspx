<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FileError.aspx.cs" Inherits="error_FileError" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <h3>
      The page you are looking for is currently (or perhaps permanently) not available.<br /><br />
      Please return to the <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Default.aspx" runat="server">home page</asp:HyperLink> and try again. 
   </h3> 

            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/others/error.jpg" CssClass="center" />

</asp:Content>   
 
