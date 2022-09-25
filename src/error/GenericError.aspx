<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GenericError.aspx.cs" Inherits="error_GenericError" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <h3>
       Oh no! <br />
      An error occured. <br /><br />
      
      Please return to the <asp:HyperLink ID="HyperLink1" NavigateUrl="~/Default.aspx" runat="server">home page</asp:HyperLink> and try again. 
   </h3>
    <div>
        <asp:Image runat="server" ImageUrl="~/images/others/error.jpg" CssClass="center" />
        </div>
</asp:Content> 

  