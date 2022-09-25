using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration; 

public partial class Catalogue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //If another page (Default) has saved a book title in session variables, put it inside search bar, delete it from session and then press search button
        if (Session.Count > 0 && Session["title"].ToString() != null)
        {
            bookTextBox.Text = Session["title"].ToString();
            Session.Remove("title");
            searchButton_Click(searchButton, EventArgs.Empty);
        }
        
    }

    protected void searchButton_Click(object sender, EventArgs e)
    {
        String selectCommand = null;

        if (bookTextBox.Text.Length > 0)
        {
            //If the search bar is not empty, search a book whose title contains the contents of the search bar
            string search = bookTextBox.Text;
            selectCommand = "SELECT [BookId], [Title], [Author], [Publisher], [PublishingDate], [NumOfPages], [Genre], [Image], [Status] " +
                                    "FROM [Books] " +
                                    "WHERE ([Title] LIKE '%" + search + "%') " +
                                    "ORDER BY [Title]";
        }
        else
        {
            //If the search bar is empty, populate list view with all the books in the database
            selectCommand =
                "SELECT [BookId], [Title], [Author], [Publisher], [PublishingDate], [NumOfPages], [Genre], [Image], [Status] " +
                "FROM [Books] " +
                "ORDER BY [Title]";
        }

        //Actually executes the select commands and binds the results to the list view
        listDataSource.SelectCommand = selectCommand;
        ListView1.DataBind();
    }

    protected void selected(object sender, EventArgs e)
    {
        //When a user presses the details button, save the book id in session variables
        string str = ListView1.SelectedDataKey.Value.ToString();
        Session["bookId"] = str;

        //Redirect to book details page
        Response.Redirect("~/BookDetails.aspx");
    }
}