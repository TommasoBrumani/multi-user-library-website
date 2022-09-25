using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using System.Data.SqlClient;

public partial class librarian_AddBook : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        //Open database connection
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        //SQL string to add book to the table
        string sqlStr2 = "INSERT INTO Books (BookId, ISBN, Title, Author, Publisher, Image, NumOfPages, Genre, PublishingDate, Synopsis) VALUES (@theBook, @theISBN, @theTitle, @theAuthor, @thePublisher, @theImage, @thePages, @theGenre, @thePublishingDate, @theSynopsis)";

        SqlCommand sqlCmd2 = new SqlCommand(sqlStr2, con);

        //Creates new uid for book
        Guid uid = Guid.NewGuid();

        //Fills in string parameters
        sqlCmd2.Parameters.AddWithValue("@theBook", uid);
        sqlCmd2.Parameters.AddWithValue("@theTitle", bookTitleTextBox.Text);

        if (ISBNTextBox.Text.Length <= 0) 
        {
            sqlCmd2.Parameters.AddWithValue("@theISBN", "Unknown");
        }
        else
        {
            sqlCmd2.Parameters.AddWithValue("@theISBN", ISBNTextBox.Text);
        }

        if (authorTextBox.Text.Length <= 0)
        {
            sqlCmd2.Parameters.AddWithValue("@theAuthor", "Unknown"); ;
        }
        else
        {
            sqlCmd2.Parameters.AddWithValue("@theAuthor", authorTextBox.Text);
        }

        if (publisherTextBox.Text.Length <= 0)
        {
            sqlCmd2.Parameters.AddWithValue("@thePublisher", "Unknown");
        }
        else
        {
            sqlCmd2.Parameters.AddWithValue("@thePublisher", publisherTextBox.Text);
        }

        if (genreTextBox.Text.Length <= 0)
        {
            sqlCmd2.Parameters.AddWithValue("@theGenre", "Unknown");
        }
        else
        {
            sqlCmd2.Parameters.AddWithValue("@theGenre", genreTextBox.Text);
        }

        if (synopsisTextBox.Text.Length <= 0)
        {
            sqlCmd2.Parameters.AddWithValue("@theSynopsis", "No synopsis available.");
        }
        else
        {
            sqlCmd2.Parameters.AddWithValue("@theSynopsis", synopsisTextBox.Text);
        }

        //Convert the number of pages to integer
        int pages;
        string pagesStr = pagesTextBox.Text;
        try
        {
            pages = Convert.ToInt32(pagesStr);
        }
        catch (FormatException ex)
        {
            pages = 0;
        }
        sqlCmd2.Parameters.AddWithValue("@thePages", pages);

        //Gets the date as a string 
        string dateStr = dateTextBox.Text;

        if (dateStr == String.Empty || String.IsNullOrEmpty(dateStr) || String.IsNullOrWhiteSpace(dateStr))
        {
            //If the date is left empty, automatically selects the current date
            DateTime theDate = DateTime.Now;
            sqlCmd2.Parameters.AddWithValue("@thePublishingDate", theDate);
        }
        else
        {
            //Splits the date on '-' or '/' 
            string[] splitDateStr = dateStr.Split(new char[] { '-', '/' });

            //Creates a DateTime object with the result
            DateTime theDate = new DateTime(Convert.ToInt32(splitDateStr[2]), Convert.ToInt32(splitDateStr[1]), Convert.ToInt32(splitDateStr[0]));
            sqlCmd2.Parameters.AddWithValue("@thePublishingDate", theDate);
        }

        //Sets default image paths
        string imagePath = "~/images/books/NoImage.png";

        //Checks if the user has uploaded an image
        if (ImageFileUpload.HasFile)
        {
            //Check for valid extension
            string extension = System.IO.Path.GetExtension(ImageFileUpload.PostedFile.FileName);

            if (extension == ".png" || extension == ".gif" || extension == ".jpg" || extension == ".bmp")
            {
                //Removes any weird characters from the image name
                string title = bookTitleTextBox.Text.Replace(".", "");
                title = title.Replace("_", "");
                title = title.Replace("-", "");
                title = title.Replace(",", "");
                title = title.Replace(";", "");
                title = title.Replace(":", "");
                title = title.Replace("(", "");
                title = title.Replace(")", "");
                title = title.Replace("'", "");
                title = title.Replace("!", "");
                title = title.Replace("?", "");
                title = title.Replace(" ", "");


                //Saves the file
                ImageFileUpload.SaveAs(Server.MapPath("~/images/books/" + title + "-" + uid + extension));

                //Saves the file path on the database
                imagePath = "~/images/books/" + title + "-" + uid + extension;
            }
        }

        sqlCmd2.Parameters.AddWithValue("@theImage", imagePath);

        //Executes the query
        sqlCmd2.ExecuteNonQuery();

        //Close database connection
        con.Close();

        //Display result
        resultLabel.ForeColor = System.Drawing.Color.Black;
        resultLabel.Text = "Book created";
    }
    
}