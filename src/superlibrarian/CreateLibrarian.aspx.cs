using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

public partial class superlibrarian_CreateLibrarian : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void selected(object sender, EventArgs e)
    {
        //Extracts the user name of the selected user
        string userName = GridView1.SelectedDataKey.Value.ToString();

        //Removes the user from the user role and adds them to the librarian role
        Roles.RemoveUserFromRole(userName, "User");
        Roles.AddUserToRole(userName, "Librarian");
        
        //Redirect to librarians list
        Response.Redirect("~/superlibrarian/LibrarianList.aspx");
    }
}