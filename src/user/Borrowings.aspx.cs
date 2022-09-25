using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration; 

public partial class user_Borrowings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Checks the user's role
        if (Roles.IsUserInRole(this.User.Identity.Name, "User"))
        {
            //If they are a normal user, display their borrowings 
            BorrowerDropDownList.SelectedValue = this.User.Identity.Name;
            //Hide the span that allows to switch between different users' pages
            LibrarianView.Style.Add("display","none");   
        }
        else if (Roles.IsUserInRole(this.User.Identity.Name, "Librarian") || Roles.IsUserInRole(this.User.Identity.Name, "SuperLibrarian"))
        {
            //If a user's username has been saved in session variables from user list page, visualize that user's borrowings
            if (Session.Count > 0 && Session["username"].ToString() != null)
            {
                BorrowerDropDownList.SelectedValue = Session["username"].ToString();
                Session.Remove("username");
            }
            //Display the span that allows to switch between different users' pages
            LibrarianView.Style.Add("display", "block"); 
        }
    }

    protected void searchButton_Click(object sender, EventArgs e)
    {
        String selectCommand = null;

        if (bookTextBox.Text.Length > 0)
        {
            //If search bar is not empty, display the user's borrowed books whose titles contain the string in search bar
            string search = bookTextBox.Text;
            selectCommand =
                "SELECT [Title], [Author], [PublishingDate], [Image], [Status] " +
                "FROM [Books] " +
                "WHERE ([Title] LIKE '%" + search + "%') AND ([BookId] IN (" +
                    "SELECT [BookId] " +
                    "FROM [Borrowings] " +
                    "WHERE ([UserId] IN (" +
                        "SELECT [UserId] " +
                        "FROM [aspnet_Users] " +
                        "WHERE([Username] = @username)" + 
                    "))" +
                "))";
        }
        else
        {
            //If search bar is empty, display all of the user's borrowed books
            selectCommand =
                "SELECT [Title], [Author], [PublishingDate], [Image], [Status] " + 
                "FROM [Books] " + 
                "WHERE ([BookId] IN (" + 
                    "SELECT [BookId] " + 
                    "FROM [Borrowings] " +  
                    "WHERE ([UserId] IN (" + 
                        "SELECT [UserId] " + 
                        "FROM [aspnet_Users] " + 
                        "WHERE([Username] = @username)" + 
                    "))" + 
                "))";
        }

        //Executes the command and binds results to the list view
        listDataSource.SelectCommand = selectCommand;

        ListView1.DataBind();
    }
}