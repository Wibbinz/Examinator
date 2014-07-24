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

        public string GetCategories()
        {
            DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetCategory2");
            int length = ds.Tables[0].Rows.Count;
            bool showUnapproved = (bool)Session["ShowUnapproved"];
            string[] category = new string[length];
            string[] description = new string[length];
            string[] modes = new string[length];
            int temp = 0; bool result;

            for (int i = 0; i < length; i++)
            {
                if (showUnapproved||Int32.TryParse(ds.Tables[0].Rows[i]["QuestionsApproved"].ToString(), out temp))
                {
                    category[i] = ds.Tables[0].Rows[i]["CatName"].ToString();
                    description[i] = ds.Tables[0].Rows[i]["CatDesc"].ToString();
                    result = Int32.TryParse(ds.Tables[0].Rows[i]["QuestionsAvailable"].ToString(), out temp);
                    if (result)
                    {
                        modes[i] = "Modes Available: Freestyle";
                        result = Int32.TryParse(ds.Tables[0].Rows[i]["QuestionsApproved"].ToString(), out temp);
                        if (result)
                        {
                            int numberOfQuestions = Convert.ToInt16(ds.Tables[0].Rows[i]["QuestionsApproved"]);
                            if (numberOfQuestions >= 10)
                            {
                                modes[i] = "Modes Available: Exam, Practice, Freestyle";
                            }
                            else
                            {
                                modes[i] = "Modes Available: Practice, Freestyle";
                            }
                        }
                    }
                }                        
            }

            category = category.Where(x => !string.IsNullOrEmpty(x)).ToArray();

            string columnInfo = "";
            for (int index = 0; index < category.Length; index++)
            {
                columnInfo += category[index] + (index == category.Length ? "" : "|");
                columnInfo += description[index] + (index == category.Length ? "" : "|");
                columnInfo += modes[index] + (index == category.Length - 1 ? "" : "|");
            }
            return columnInfo;
        }
        
    }
}