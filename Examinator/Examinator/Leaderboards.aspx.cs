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
    public partial class Leaderboards : System.Web.UI.Page
    {
        /// <summary>
        /// To ensure a new user is not subject to the registration message
        /// every time the visit the home page, the New session is reset to null.
        /// 
        /// The populateLeader method is called to display all scores.
        /// 
        /// The populatePersonal method is called if a user is logged in to display personal scores.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["New"] = null;
            populateLeader();
            if (Session["User"] != null)
            {
                populatePersonal();
            }
        }

        /// <summary>
        /// The 'spGetTopScores' procedure from the database is invoked to populate the Leaderboard Gridview.
        /// </summary>
        protected void populateLeader()
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetTopScores");
            gvLeaderBoards.DataSource = ds;
            gvLeaderBoards.DataBind();
        }


        /// <summary>
        /// The username of the user currently logged in is sent to the 'spGetScoresByID' procedure of the
        /// database to generate the personalized scoreboard.
        /// 
        /// A label notifying the user that unless their settings allow, they will not be able to see their
        /// personal scores on the public leaderboard is displayed if that is the case.
        /// </summary>
        protected void populatePersonal()
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            User currentUser = (User)Session["User"];
            dal.AddParam("@UserName", currentUser.UserName);
            ds = dal.ExecuteProcedure("spGetScoresByID");
            gvPersonal.DataSource = ds;
            gvPersonal.DataBind();
            if (!currentUser.PrefLeader)
            {
                lblDisplay.Visible = true;
            }
        }
    }
}