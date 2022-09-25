<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddBook.aspx.cs" Inherits="librarian_AddBook" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
   <span class="headingspan">Add a new book to the database:</span><br /><br />
      
   <table style="width:100%"> 
     <!-- Filtered, required text box for the book's title -->
     <tr>
       <td class="addright">
         <asp:Label ID="bookTitleLabel" runat="server" Width="100px" Text="Book title:"></asp:Label> 
       </td>
       <td> 
         <asp:TextBox ID="bookTitleTextBox" runat="server" Width="114px" placeholder="Title" MaxLength="45"></asp:TextBox>
         <asp:RequiredFieldValidator ID="TitleRequired" runat="server" ControlToValidate="bookTitleTextBox" ErrorMessage="Book title is required." ToolTip="Book title is required.">*Book title is required!</asp:RequiredFieldValidator>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" TargetControlID="bookTitleTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars="._-,;:()'!? " runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
     </tr>
     
       <!-- Filtered text box for the book's ISBN code -->
     <tr>
       <td class="addright">
         <asp:Label ID="ISBNLabel" runat="server" Width="124px" Text="Book ISBN:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="ISBNTextBox" runat="server" Width="114px" placeholder="999-9-99-999999-9" MaxLength="20"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" TargetControlID="ISBNTextBox" FilterType="Numbers" runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
     </tr>
    
       <!-- Filtered text box for the book's author -->
     <tr>
       <td class="addright">
         <asp:Label ID="authorLabel" runat="server" Width="124px" Text="Author(s):"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="authorTextBox" runat="server" Width="114px" placeholder="Author" MaxLength="45"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender3" TargetControlID="authorTextBox" FilterType="UppercaseLetters, LowercaseLetters, Custom"  ValidChars=".-, " runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
     </tr>
    
       <!-- Filtered text box for the book's publisher -->
    <tr>
       <td class="addright">
         <asp:Label ID="publisherLabel" runat="server" Width="124px" Text="Publisher:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="publisherTextBox" runat="server" Width="114px" placeholder="Publisher" MaxLength="45"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="publisherTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars=".-, " runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
    </tr>
    
       <!-- Filtered text box for the book's genre-->
    <tr>
       <td class="addright">
         <asp:Label ID="genreLabel" runat="server" Width="124px" Text="Genre:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="genreTextBox" runat="server" Width="114px" placeholder="Genre" MaxLength="45"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" TargetControlID="genreTextBox" FilterType="UppercaseLetters, LowercaseLetters, Custom" ValidChars=".-, " runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
    </tr>

       <!-- Filtered text box for the book's number of pages -->
    <tr>
       <td class="addright">
         <asp:Label ID="pagesLabel" runat="server" Width="124px" Text="Number of pages:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="pagesTextBox" runat="server" Width="114px" placeholder="Number of pages" MaxLength="5"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" TargetControlID="pagesTextBox" FilterType="Numbers" runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
    </tr>

       <!-- Text box for the book's publishing date, filled through a calendar selection menu -->
    <tr>
       <td class="addright">
         <asp:Label ID="dateLabel" runat="server" Width="124px" Text="Date of publishing:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="dateTextBox" runat="server" Width="114px" placeholder="dd/MM-yyyy"></asp:TextBox>
         <asp:CalendarExtender TargetControlID="dateTextBox" ID="CalendarExtender1" runat="server" 
            FirstDayOfWeek="Monday" Format="dd/MM-yyyy">
        </asp:CalendarExtender>
       </td>
    </tr>

       <!-- Filtered multi-line text box for the book's synopsis -->
     <tr>
      <td class="addright">
         <asp:Label ID="synopsisLabel" runat="server" Width="124px" Text="Book synopsis:"></asp:Label> 
       </td>
       <td>
         <asp:TextBox ID="synopsisTextBox" runat="server" Width="116px" placeholder="Book synopsis..." TextMode="MultiLine" Rows="5" Columns="20" style="resize:none;"></asp:TextBox>
         <asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" TargetControlID="synopsisTextBox" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars="._-,;:()'!? " runat="server">
         </asp:FilteredTextBoxExtender>
       </td>
     </tr>
    
       <!-- Upload button for the book's image -->
     <tr>
       <td class="addright">
         <asp:Label ID="ImageLabel" runat="server" Width="110px" Text="Cover of the book:"></asp:Label>
       </td>
       <td>
         <asp:FileUpload ID="ImageFileUpload" runat="server" />
       </td>
     </tr>

       <!-- Button to complete the book's creation -->
     <tr>
       <td colspan="1" class="addright">
         <br/>
         <asp:Button ID="CreateButton" runat="server" Text="Add this book" onclick="CreateButton_Click" />    
       </td>
     </tr>
   </table>
   <br /><br />
    
    <!-- Label to display the result of the operation -->
   <asp:Label ID="resultLabel" runat="server" Text=""></asp:Label>

</asp:Content>  
