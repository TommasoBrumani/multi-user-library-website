<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="librarian_CreateUser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <!-- Button to go to back to user list page -->
    <asp:Button ID="Button1" runat="server" Text="Go back" PostBackUrl="~/librarian/UserList.aspx" Width="100px" Height="30px" />

    <span class="headingspan">Add a new user:</span> 
    <br/><br/> 
    <p style="text-align:center"> Please fill the following fields to add a new user:</p>
    <br/><br/> 

    <!-- ASP.net's create user wizard, with a couple of extra fields -->
    <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" LoginCreatedUser="False" OnCreatedUser="CreateUserWizard1_CreatedUser" Width="100%">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" >
                <ContentTemplate>
                    <!-- Template for the user creation table -->
                    <table style="width:100%">

                        <!-- Filtered, required text box for the user's user name -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">UserName:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="UserName" runat="server" placeholder="John_Doe"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="UserName is required." ToolTip="UserName is required." ValidationGroup="CreateUserWizard1">*UserName is required!</asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="UserNameFilter" TargetControlID="UserName" FilterType="Numbers, UppercaseLetters, LowercaseLetters, Custom"  ValidChars="_-' " runat="server">
                                </asp:FilteredTextBoxExtender>
                            </td>
                        </tr>

                        <!-- Filtered, required text box for the user's first name (extra field) -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="FirstNameLabel" runat="server">First name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="FirstName" runat="server" placeholder="John"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstName" ErrorMessage="First Name is required." ToolTip="First Name is required." ValidationGroup="CreateUserWizard1">*First Name is required!</asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="FirstNameFilter" TargetControlID="FirstName" FilterType="UppercaseLetters, LowercaseLetters, Custom"  ValidChars="-' " runat="server">
                                </asp:FilteredTextBoxExtender>
                             </td>
                        </tr>

                        <!-- Filtered, required text box for the user's last name (extra field) -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="LastNameLabel" runat="server">Last name:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="LastName" runat="server" placeholder="Doe"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="LastNameRequired" runat="server" ControlToValidate="LastName" ErrorMessage="Last Name is required." ToolTip="Last Name is required." ValidationGroup="CreateUserWizard1">*Last Name is required!</asp:RequiredFieldValidator>
                                <asp:FilteredTextBoxExtender ID="LastNameFilter" TargetControlID="LastName" FilterType="UppercaseLetters, LowercaseLetters, Custom"  ValidChars="-' " runat="server">
                                </asp:FilteredTextBoxExtender>
                             </td>
                        </tr>

                        <!-- Required text box for the user's e-mail -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">E-mail:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Email" runat="server" placeholder="john.doe@gmail.com"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ErrorMessage="E-mail is required." ToolTip="E-mail is required." ValidationGroup="CreateUserWizard1">*E-mail is required!</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <!-- Required text box for the user's password -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="********"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="CreateUserWizard1">*Password is required!</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <!-- Required text box for the user's confirmation password -->
                        <tr>
                            <td class="addright">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" placeholder="********"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" ErrorMessage="Confirm Password is required." ToolTip="Confirm Password is required." ValidationGroup="CreateUserWizard1">*Confirmation password is required!</asp:RequiredFieldValidator>
                            </td>
                        </tr>

                        <!-- Comparator for the 2 passwords -->
                        <tr>
                            <td colspan="2">
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="The Password and Confirmation Password must match." ValidationGroup="CreateUserWizard1"></asp:CompareValidator>
                            </td>
                        </tr>

                        <!-- Label to display error messages -->
                        <tr>
                            <td colspan="2" style="color:Red;">
                                <asp:Literal ID="ErrorMessage" runat="server" EnableViewState="False"></asp:Literal>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CreateUserWizardStep>

            <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                <ContentTemplate>
                    <!-- Template for the completed user creation -->
                    <table>
                        <tr>
                            <td colspan="2">Completed</td>
                        </tr>
                        <tr>
                            <td>The account has been successfully created.</td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:CompleteWizardStep>

        </WizardSteps>
    </asp:CreateUserWizard>
    
</asp:Content>

