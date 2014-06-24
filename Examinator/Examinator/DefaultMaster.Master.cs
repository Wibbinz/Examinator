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
                lblError.Text = "Invalid Login. Please try again.";
                lblError.Visible = true;
            }
            else
            {
                lblUser.Text = "Greetings, " + tbLogin.Text;
                pnlLogin.Visible = false;
                pnlLogout.Visible = true;
                tbLogin.Text = "";
                tbPassword.Text = "";
            }
        }

        protected void linkLogout_Click(object sender, EventArgs e)
        {
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
            if (ds.Tables[0].Rows[0][0].ToString() == "UserName Exists")
            {
                lblError.Text = "Username Exists. Please choose another username.";
                lblError.Visible = true;
            }
            else
            {
                lblThankYou.Visible = true;
                pnlLogin.Visible = false;                
                pnlLogout.Visible = true;
            }
        }

    }
}