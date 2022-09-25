using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class librarian_UserList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        //When the librarian clicks a button on a row, extract the corresponding user's username
        string userName = Convert.ToString(e.CommandArgument);

        if (e.CommandName == "viewBorrowings")
        {
            //If they have clicked the view borrowings button, save the username in session variables and redirect to borrowings page
            Session["username"] = userName;
            Response.Redirect("~/user/Borrowings.aspx");
        }
        else if (e.CommandName == "viewReservations")
        {
            //If they have clicked the view reservations button, save the username in session variables and redirect to reservations page
            Session["username"] = userName;
            Response.Redirect("~/user/Reservations.aspx");
        }
    }
}