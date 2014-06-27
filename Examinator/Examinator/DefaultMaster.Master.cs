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
                GetPreferences();
                lblUser.Text = "Greetings, " + tbLogin.Text;
                pnlLogin.Visible = false;
                pnlLogout.Visible = true;
                tbLogin.Text = "";
                tbPassword.Text = "";
            }
        }

        protected void linkLogout_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblUser.Text = "";
            lblPasswordResult.Text = "";
            pnlLogout.Visible = false;
            pnlLogin.Visible = true;
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

        protected void GetPreferences()
        {
        }

    }
}