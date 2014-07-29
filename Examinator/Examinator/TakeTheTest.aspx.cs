using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Examinator_Classes;


namespace Examinator
{
    public partial class TakeTheTest : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["New"] = null;
        }

        public string GetCategories()
        {
            User currentUser = (User)Session["User"];
            Session["UserName"] = currentUser.UserName;
            Session["PrefUnapproved"] = currentUser.PrefUnapproved;
            Session["PrefShowLeader"] = currentUser.PrefLeader;
            Question popQuestion = new Question();
            string columnInfo = popQuestion.CatInfo(currentUser.PrefUnapproved);            
            return columnInfo;
        }
        
    }
}