<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Background image -->
    <div class="homepage" id="background">

        <h1>Welcome to the best library!</h1> <br />

        <div class="bluetranslucid">

           <p class="hometxt">Looking for a book? Find it here! 
               <br />
               Browse our books: 
               <br /> 
           </p> 

            <!-- The search bar (filtered to avoid weird characters) -->
            <asp:TextBox ID="bookTextBox" runat="server" placeholder="Search title"  CssClass="searchbar"></asp:TextBox> 
            <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="bookTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars="._-,;:()'!? " runat="server">
            </asp:FilteredTextBoxExtender>
            <br />
            <asp:Button ID="searchButton" runat="server" Text="Search" OnClick="searchButton_Click" CssClass="searchbutton" />

        </div>

    </div>

</asp:Content> 
 