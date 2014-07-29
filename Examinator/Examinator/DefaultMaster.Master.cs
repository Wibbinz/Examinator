using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Examinator_Classes;

namespace Examinator
{
    public partial class DefaultMaster : System.Web.UI.MasterPage
    {
        /// <summary>
        /// On Page Load, the Session 'New' set in new user registration determines
        /// whether the message label should display. 
        /// 
        /// If the User session is not empty, the loggedIn method is invoked to display
        /// the appropriate links and message.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Session["New"] != null)
            {
                string result = (string)Session["New"];
                lblMessage.Text = result;
                lblMessage.Style.Add("text-shadow", "2px 2px 2px #15E626");
                lblMessage.Visible = true;
            }
            if (Session["User"]!= null)
            {
                User currentUser = (User)Session["User"];
                loggedIn(currentUser);
            }
        }

        /// <summary>
        /// Resetting Login textboxes and populating welcome label.
        /// Also determines of user is an administrator and makes the link to the editor page
        /// available if so.
        /// </summary>
        /// <param name="currentUser">Parameter of class 'User,' of which the Username and UserifAdmin fields are used</param>
                
        protected void loggedIn(User currentUser)
        {
            lblUser.Text = "Greetings, " + currentUser.UserName;
            pnlLogin.Visible = false;
            pnlLogout.Visible = true;
            tbLogin.Text = "";
            tbPassword.Text = "";            
            if (currentUser.UserifAdmin)            
                linkEditor.Visible = true;
            else
                linkEditor.Visible = false;
        }

        /// <summary>
        /// This method fires when the Login button is clicked. It calls the 'VerifyUser' method
        /// from class User to determine whether the username and password match in the database.
        /// VerifyUser returns a value of -1 if they do not match and -2 if the user is an administrator.
        /// 
        /// The method then calls 'GetPreferences' on the user and stores the result the Session 'User.'
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            User currentUser = new User();
            int accessCheck = currentUser.VerifyUser(tbLogin.Text, tbPassword.Text);            
            if (accessCheck == -1)
            {
                lblMessage.Text = "Invalid Login. Please try again.";
                lblMessage.Visible = true;
            }
            else
            {                
                if (accessCheck == 2)
                {
                    currentUser = currentUser.GetPreferences(tbLogin.Text, tbPassword.Text, true);
                }
                else
                {
                    currentUser = currentUser.GetPreferences(tbLogin.Text, tbPassword.Text, false);
                }
                Session["User"] = currentUser;
                Response.Redirect("Home.aspx");
            }
        }

        /// <summary>
        /// This method fires when the logout button is clicked.
        /// It resets the Sessions to null and the labels to empty strings, then redirects home.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void linkLogout_Click(object sender, EventArgs e)
        {
            Session["User"] = null;
            Session["PrefUnapproved"] = null;
            Session["PrefShowLeader"] = null;
            Session["New"] = null;
            lblMessage.Text = "";
            lblUser.Text = "";
            lblPasswordResult.Text = "";
            pnlLogout.Visible = false;
            pnlLogin.Visible = true;
            Response.Redirect("Home.aspx");
        }


        /// <summary>
        /// This method fires when the new user link is clicked.
        /// It calls method'addNewUser' from the User class on the newUser.
        /// If the database returns a value of 'UserID Exists' of 'User Email Exists' the appropriate
        /// response is displayed via the lable 'lblMessage.'
        /// 
        /// Otherwise, the webservice PasswordResetService is invoked and the email, username and password
        /// are sent to the database via method 'newUserRegs.'
        /// 
        /// A session holding the new user and a session with the resulting message from the webservice are initialized
        /// and the user is redirected to the home page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnNewUser_Click(object sender, EventArgs e)
        {
            User newUser = new User();
            
            string message = newUser.addNewUser(tbUser.Text, tbPW.Text, tbEmail.Text);
           
            if (message == "UserID Exists")
            {
                lblMessage.Text = "Username Exists. Please choose another username.";
                lblMessage.Visible = true;
            }
            else if (message == "User Email Exists")
            {
                lblMessage.Text = "User Email Exists Exists. Please choose another email.";
                lblMessage.Visible = true;
            }
            else
            {
                PasswordResetService newRegsSvc = new PasswordResetService();
                string result = newRegsSvc.newUserRegs(tbEmail.Text, tbUser.Text, tbPW.Text);
                newUser = new User(tbUser.Text, tbPW.Text, false, tbEmail.Text, false, false);
                Session["User"] = newUser;
                Session["New"] = result;
                Response.Redirect("Home.aspx");
            }
        }
       
        /// <summary>
        /// This method fires when the Preferences link is clicked. 
        /// A user with the new username, password and display settings is sent through the SetPreferences
        /// method in the class User, and the message is stored in the string 'message.'
        /// 
        /// Since the username must be unique in the database, a boolean is also sent so that the username
        /// parameter will not be added when the database procedure is accessed.
        /// 
        /// If the username already exists, a message is returned from the database via the SetPreferences method.
        /// Otherwise, the success message is displayed in the label message and the user is 'logged in' with the 
        /// new preference settings.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnPrefs_Click(object sender, EventArgs e)
        {
            User currentUser = (User)Session["User"];
            bool same = false;
            if (currentUser.UserName == tbChangeuserName.Text)
            {
                same = true;
            }
            currentUser = new User(tbChangeuserName.Text, tbChangePassword.Text, currentUser.UserifAdmin, currentUser.UserEmail, cbScores.Checked, cbUnapproved.Checked);            
            string message = currentUser.SetPreferences(currentUser, same);
            if (message == "UserID Exists")
            {
                lblMessage.Text = "Username Exists. Please choose another username.";
                lblMessage.Visible = true;
            }
            else
            {
                Session["User"] = currentUser;
                lblMessage.Text = "Success! Your preferences have been saved.";
                lblMessage.Style.Add("text-shadow", "2px 2px 2px #15E626");
                lblMessage.Visible = true;
                loggedIn(currentUser);
            }
        }


        /// <summary>
        /// The editor link is available only to administrators. When clicked it redirects to the Editor page.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void linkEditor_Click(object sender, EventArgs e)
        {
            Response.Redirect("Editor.aspx");
        }       
    }
}