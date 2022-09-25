using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;


public partial class librarian_CreateUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        //If for some reason the user's username is already associated with some roles, it is removed from them
        try
        {
            string[] roles = { "User", "Librarian", "SuperLibrarian" };
            Roles.RemoveUserFromRoles(CreateUserWizard1.UserName, roles);
        }
        catch (System.Configuration.Provider.ProviderException Ex)
        {
        }

        //Adds the new user to the user role
        Roles.AddUserToRole(CreateUserWizard1.UserName, "User");

        //Opens database connection
        string dbstring = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        SqlConnection con = new SqlConnection(dbstring);

        con.Open();

        //SQL string to add user details for the created user (CanBorrow is automatically set to True as a default value, so it doesn't need to be set here)
        string sqlStr1 = "INSERT INTO UserDetails (UserId, FirstName, LastName) VALUES (@userId, @firstName, @lastName)";

        SqlCommand sqlCmd1 = new SqlCommand(sqlStr1, con);

        //Extracts the user's id
        string id = Membership.GetUser((sender as CreateUserWizard).UserName).ProviderUserKey.ToString();
        sqlCmd1.Parameters.AddWithValue("@userId", id);

        //Extracts first and last name
        TextBox FirstNameTb = (TextBox)this.CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("FirstName");
        sqlCmd1.Parameters.AddWithValue("@firstName", FirstNameTb.Text);
        TextBox LastNameTb = (TextBox)this.CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("LastName");
        sqlCmd1.Parameters.AddWithValue("@lastName", LastNameTb.Text);

        //Executes command
        sqlCmd1.ExecuteNonQuery();

        //Close database connection
        con.Close();
    }

}