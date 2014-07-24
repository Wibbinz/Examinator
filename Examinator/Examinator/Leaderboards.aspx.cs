using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Examinator
{
    public partial class Leaderboards : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            populateLeader();
            if (Session["User"] != null)
            {
                populatePersonal();
            }
        }

        protected void populateLeader()
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetTopScores");
            gvLeaderBoards.DataSource = ds;
            gvLeaderBoards.DataBind();
        }

        protected void populatePersonal()
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@UserName", Session["User"].ToString());
            ds = dal.ExecuteProcedure("spGetScoresByID");
            gvPersonal.DataSource = ds;
            gvPersonal.DataBind();
        }
    }
}