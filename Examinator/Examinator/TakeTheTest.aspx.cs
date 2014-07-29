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
        //To ensure a new user is not subject to the registration message
        //every time the visit the home page, the New session is reset to null.
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["New"] = null;
        }

        /// <summary>
        /// Populating sessions with the current user's preferences to be accessed by the
        /// javascript methods that determine which categories and questions should be displayed as well
        /// as recording the appropriate bit in the database that determines whether a user's scores should
        /// be displayed publicly or not.
        /// 
        /// The CatInfo method from the Class Question is invoked to retrieve the Category, Description and Methods available
        /// depending on whether the user wishes unapproved questions to be displayed or not.
        /// </summary>
        /// <returns></returns>
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