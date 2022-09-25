using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

public partial class superlibrarian_LibrarianList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 
         
    }
    protected void selected(object sender, EventArgs e)
    {
        //Extracts the user name of the selected librarian
        string userName = GridView1.SelectedDataKey.Value.ToString();
        
        //Removes the librarian from the librarian role and add them to the user role
        Roles.RemoveUserFromRole(userName, "Librarian");
        Roles.AddUserToRole(userName, "User");
        

        //Reloads the page
        Response.Redirect("~/superlibrarian/LibrarianList.aspx");
    }
}