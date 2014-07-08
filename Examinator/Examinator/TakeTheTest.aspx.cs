using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace Examinator
{
    public partial class TakeTheTest : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public string GetArrayStream()
        {

            string approvedOnly = "no";

            DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

            dal.AddParam("@ApprovedOnly", approvedOnly);
            
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetCategory");

            int length = ds.Tables[0].Rows.Count;

            string[] category = new string[length];

            for (int i = 0; i < length; i++)
            {
                category[i] = ds.Tables[0].Rows[i]["CatName"].ToString();
            }
            
            
            //string[] category = {"potato","watermelon","panda","buckit","doctor", "data","spock","seven"};

            string returnStr = "";
            for (int index = 0; index < category.Length; index++)
                returnStr += category[index] + (index == category.Length - 1 ? "" : "|");
            return returnStr;
        }
            
    }
}