using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 

    }
    
    protected void searchButton_Click(object sender, EventArgs e)
    {
        //Saves search bar text in a session variable to access it from another page
        string str = bookTextBox.Text;
        Session["title"] = str;

        //Redirects to catalogue page
        Response.Redirect("~/Catalogue.aspx");
    }
}