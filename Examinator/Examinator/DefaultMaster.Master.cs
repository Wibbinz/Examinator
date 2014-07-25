using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Examinator
{
    public partial class DefaultMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                loggedIn();
            }
        }

        protected void loggedIn()
        {
            string userName = (string)Session["User"];            
            GetPreferences(userName);
            lblUser.Text = "Greetings, " + userName;
            pnlLogin.Visible = false;
            pnlLogout.Visible = true;
            tbLogin.Text = "";
            tbPassword.Text = "";
            if ((bool)Session["Admin"])
                linkEditor.Visible = true;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", tbLogin.Text);
            dal.AddParam("@UserPass", tbPassword.Text);
            ds = dal.ExecuteProcedure("spVerifyUsers");
            int accessCheck = Convert.ToInt16(ds.Tables[0].Rows[0]["UserLvl"]);
            if (accessCheck == -1)
            {
                lblMessage.Text = "Invalid Login. Please try again.";
                lblMessage.Visible = true;
            }
            else
            {
                if (accessCheck == 2)
                {
                    Session["Admin"] = true;
                }
                else
                {
                    Session["Admin"] = false;
                }
                Session["User"] = tbLogin.Text;
                loggedIn();
                Response.Redirect("Home.aspx");
            }
        }

        protected void linkLogout_Click(object sender, EventArgs e)
        {
            Session["User"] = null;
            Session["Email"] = null;
            Session["ShowLeader"] = null;
            Session["ShowUnapproved"] = null;
            Session["Admin"] = null;
            lblMessage.Text = "";
            lblUser.Text = "";
            lblPasswordResult.Text = "";
            pnlLogout.Visible = false;
            pnlLogin.Visible = true;
            Response.Redirect("Home.aspx");
        }

        protected void btnNewUser_Click(object sender, EventArgs e)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", tbUser.Text);
            dal.AddParam("@UserPass", tbPW.Text);
            dal.AddParam("@UserEmail", tbEmail.Text);
            ds = dal.ExecuteProcedure("spAddUsers");
            if (ds.Tables[0].Rows[0][0].ToString() == "UserID Exists")
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
                lblUser.Text = "Greetings, " + tbUser.Text;
                pnlLogin.Visible = false;                
                pnlLogout.Visible = true;    
            }
            tbUser.Text = "";
            tbPW.Text = "";
            tbEmail.Text = "";
        }

        protected void GetPreferences(string user)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", user);
            ds = dal.ExecuteProcedure("spGetPreferences");
            Session["Email"] = ds.Tables[0].Rows[0]["UserEmail"];
            if ((ds.Tables[0].Rows[0]["PrefShowInLeader"] != null) && !DBNull.Value.Equals(ds.Tables[0].Rows[0]["PrefShowInLeader"]))
            {
                Session["ShowLeader"] = Convert.ToBoolean(ds.Tables[0].Rows[0]["PrefShowInLeader"]);
            }
            else
            {
                Session["ShowLeader"] = false;
            }
            if ((ds.Tables[0].Rows[0]["PrefShowUnapproved"] != null) && !DBNull.Value.Equals(ds.Tables[0].Rows[0]["PrefShowUnapproved"]))
            {
                Session["ShowUnapproved"] = Convert.ToBoolean(ds.Tables[0].Rows[0]["PrefShowUnapproved"]);
            }
            else
            {
                Session["ShowUnapproved"] = false;
            }
        }

        protected void btnPrefs_Click(object sender, EventArgs e)
        {
            string email = Session["Email"].ToString();
            string user = tbChangeuserName.Text;
            string pass = tbChangePassword.Text;
            bool showLeader = rbtnScores.Checked;
            bool showUnapproved = rbtnQuestions.Checked;
            
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserEmail", email);
            dal.AddParam("@UserName", user);
            dal.AddParam("@UserPass", pass);
            dal.AddParam("@PrefShowInLeader", showLeader);
            dal.AddParam("@PrefShowUnapproved", showUnapproved);
            ds = dal.ExecuteProcedure("spUpdatePreferences");
            Session["User"] = tbChangeuserName.Text;
            Session["ShowLeader"] = rbtnScores.Checked;
            Session["ShowUnapproved"] = rbtnQuestions.Checked;
            Response.Redirect("Home.aspx");

        }

        protected void linkEditor_Click(object sender, EventArgs e)
        {
            Response.Redirect("Editor.aspx");
        }
    }
}