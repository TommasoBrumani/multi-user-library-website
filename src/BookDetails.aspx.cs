using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration; 

public partial class BookDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Stores the book id sent by the catalogue page through session variables into the hidden text box, then empties session
        if (Session.Count > 0 && Session["bookId"].ToString() != null)
        {
            ParameterTextBox.Text = Session["bookId"].ToString();
            Session.Remove("bookId");
        }
    }

    protected void ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        //When the data is being bound to the list view, check if the user is a librarian
        if (this.User.IsInRole("Librarian") || this.User.IsInRole("SuperLibrarian"))
        {
            //If so, get the list view item
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                //Open database connection
                string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(dbstring);

                con.Open();

                //Try to get the user that has borrowed the book
                string fetchNameString =    "SELECT [UserName] " + 
                                            "FROM [aspnet_Users] AS [Us] " +
                                            "JOIN [Borrowings] AS [Bor] ON [Us].[UserId] = [Bor].[UserId] " + 
                                            "WHERE [BookId] = @bookId";

                SqlCommand sqlCmd2 = new SqlCommand(fetchNameString, con);

                sqlCmd2.Parameters.AddWithValue("@bookId", ParameterTextBox.Text);

                //Gets the user's username, if it exists
                object result = sqlCmd2.ExecuteScalar();

                //Gets some of the pages elements to change their visibility and contents
                LoginView loginView = (LoginView)e.Item.FindControl("ActionsLoginView");
                HtmlControl borrowedView = (HtmlControl)loginView.FindControl("BorrowedView");
                HtmlControl availableView = (HtmlControl)loginView.FindControl("AvailableView");
                Label borrowerLabel = (Label)loginView.FindControl("BorrowerLabel");

                //Changes what is displayed depending if a user who has borrowed this book exists
                if (result != null)
                {
                    borrowerLabel.Text = result.ToString();
                    availableView.Style.Add("display", "none");
                    borrowedView.Style.Add("display", "block"); 
                }
                else
                {
                    availableView.Style.Add("display", "block");
                    borrowedView.Style.Add("display", "none");  
                }

                //Close database connection
                con.Close();
            }
        }
    }
     

    protected void reserveButton_Click(object sender, EventArgs e)
    {
        //Open database connection
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        string bookId = ParameterTextBox.Text;
          
        //See if the user has already reserved the bok
        string fetchReservationString = "SELECT [BookId] FROM [Reservations] WHERE [BookId] = @bookId AND [UserId] = @userId";
        SqlCommand sqlCmd2 = new SqlCommand(fetchReservationString, con);

        String userId = Membership.GetUser(this.User.Identity.Name).ProviderUserKey.ToString();
        sqlCmd2.Parameters.AddWithValue("@userId", userId);
        sqlCmd2.Parameters.AddWithValue("@bookId", bookId);

        object result = sqlCmd2.ExecuteScalar();

        if (result == null)
        {
            //If no, add his reservation to the table
            string addReservationString = "INSERT INTO Reservations (UserId, BookId, Date) VALUES (@userId, @bookId, @date)";
            SqlCommand sqlCmd3 = new SqlCommand(addReservationString, con);

            sqlCmd3.Parameters.AddWithValue("@userId", userId);
            sqlCmd3.Parameters.AddWithValue("@bookId", bookId);
            sqlCmd3.Parameters.AddWithValue("@date", DateTime.Now);

            // Execute the SQL command
            sqlCmd3.ExecuteNonQuery();

            //Show the user that the reservation was created
            resultLabel.ForeColor = System.Drawing.Color.Black;
            resultLabel.Text = "Reservation made";
        }
        else
        {
            //If yes display an error
            resultLabel.ForeColor = System.Drawing.Color.Red;
            resultLabel.Text = "You have already made a reservation for this book!";
        }

        //Close database connection
        con.Close();
    }

    protected void deleteButton_Click(object sender, EventArgs e)
    {
        //Open database connection
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        //Delete the book from the books table
        string deleteBookString = "DELETE FROM [Books] WHERE [BookId] = @bookId";
        SqlCommand sqlCmd1 = new SqlCommand(deleteBookString, con);

        sqlCmd1.Parameters.AddWithValue("@bookId", ParameterTextBox.Text);

        // Execute the SQL command
        sqlCmd1.ExecuteNonQuery();

        //Close database coonection
        con.Close();

        //Redirect to catalogue
        Response.Redirect("~/Catalogue.aspx");
    }

    protected void returnButton_Click(object sender, EventArgs e)
    {
        //Open database connection
        string bookId = ParameterTextBox.Text;
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        //Delete the row of this book's borrowing from the table
        string deleteBorrowingString = "DELETE FROM [Borrowings] WHERE [BookId] = @bookId";
        SqlCommand sqlCmd1 = new SqlCommand(deleteBorrowingString, con);

        sqlCmd1.Parameters.AddWithValue("@bookId", bookId);

        //Execute the SQL command
        sqlCmd1.ExecuteNonQuery();

        //Update the book's status to available
        string updateBookString = "UPDATE [Books] SET [Status] = @status WHERE [BookId] = @bookId";
        SqlCommand sqlCmd2 = new SqlCommand(updateBookString, con);

        sqlCmd2.Parameters.AddWithValue("@bookId", bookId);
        sqlCmd2.Parameters.AddWithValue("@status", "Available");

        //Execute the SQL command
        sqlCmd2.ExecuteNonQuery();

        //Close database connection
        con.Close();

        //Store the book's id in session variables, so it will survive page reload
        Session["bookId"] = bookId;

        //Reload page
        Response.Redirect("~/BookDetails.aspx");
    }

    protected void borrowButton_Click(object sender, EventArgs e)
    {
        //Open database connection
        string bookId = ParameterTextBox.Text;
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        //Insert in the borrowings table a row for this book and the selected user
        string addBorrowingString = "INSERT INTO Borrowings (UserId, BookId, BorrowDate, DueDate) VALUES (@userId, @bookId, @borrowDate, @dueDate)";
        SqlCommand sqlCmd1 = new SqlCommand(addBorrowingString, con);

        //Extract the user's id from their username in the drop down list
        ListViewItem selectedItem = ListView1.Items[0];
        LoginView loginView = (LoginView)selectedItem.FindControl("ActionsLoginView");
        DropDownList borrowerDropDownList = (DropDownList)loginView.FindControl("BorrowerDropDownList");
        sqlCmd1.Parameters.AddWithValue("@userId", Membership.GetUser(borrowerDropDownList.SelectedValue).ProviderUserKey.ToString());

        sqlCmd1.Parameters.AddWithValue("@bookId", bookId);

        //Get today's date
        DateTime time = DateTime.Now;
        sqlCmd1.Parameters.AddWithValue("@borrowDate", time);

        //Increment it by one month
        time.AddMonths(1);
        sqlCmd1.Parameters.AddWithValue("@dueDate", time);

        //Execute the SQL command
        sqlCmd1.ExecuteNonQuery();

        //Update the book's status to borrowed
        string updateBookString = "UPDATE [Books] SET [Status] = @status WHERE [BookId] = @bookId";
        SqlCommand sqlCmd2 = new SqlCommand(updateBookString, con);

        sqlCmd2.Parameters.AddWithValue("@bookId", bookId);
        sqlCmd2.Parameters.AddWithValue("@status", "Borrowed");

        //Execute the SQL command
        sqlCmd2.ExecuteNonQuery();

        //Close database connection
        con.Close();

        //Store the book's id in session variables, so it will survive page reload
        Session["bookId"] = bookId;

        //Reload page
        Response.Redirect("~/BookDetails.aspx");
    }
}