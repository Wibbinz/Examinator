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
        protected void Page_Load(object sender, EventArgs e)
        {           
            if (Session["User"]!= null)
            {
                User currentUser = (User)Session["User"];
                loggedIn(currentUser);
            }
        }

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

        protected void linkLogout_Click(object sender, EventArgs e)
        {
            Session["User"] = null;
            Session["PrefUnapproved"] = null;
            Session["PrefShowLeader"] = null;
            lblMessage.Text = "";
            lblUser.Text = "";
            lblPasswordResult.Text = "";
            pnlLogout.Visible = false;
            pnlLogin.Visible = true;
            Response.Redirect("Home.aspx");
        }

        protected void btnNewUser_Click(object sender, EventArgs e)
        {
            User newUser = new User();
            
           
            if (newUser.addNewUser(tbUser.Text, tbPW.Text, tbEmail.Text) == "UserID Exists")
            {
                lblMessage.Text = "Username Exists. Please choose another username.";
                lblMessage.Visible = true;
            }
            else
            {
                PasswordResetService newRegsSvc = new PasswordResetService();
                string result = newRegsSvc.newUserRegs(tbEmail.Text, tbUser.Text, tbPW.Text);
                lblMessage.Text = result;
                lblMessage.Style.Add("text-shadow", "2px 2px 2px #15E626");
                lblMessage.Visible = true;
                newUser = new User(tbUser.Text, tbPW.Text, false, tbEmail.Text, false, false);
                Session["User"] = newUser;
                loggedIn(newUser);
            }
        }

       

        protected void btnPrefs_Click(object sender, EventArgs e)
        {
            User currentUser = (User)Session["User"];
            currentUser = new User(tbChangeuserName.Text, tbChangePassword.Text, currentUser.UserifAdmin, currentUser.UserEmail, cbScores.Checked, cbUnapproved.Checked);
            currentUser.SetPreferences(currentUser);
            Session["User"] = currentUser;
            lblMessage.Text = "Success! Your preferences have been recorded.";
            lblMessage.Style.Add("text-shadow", "2px 2px 2px #15E626");
            lblMessage.Visible = true;
            loggedIn(currentUser);
        }

        protected void linkEditor_Click(object sender, EventArgs e)
        {
            Response.Redirect("Editor.aspx");
        }       
    }
}