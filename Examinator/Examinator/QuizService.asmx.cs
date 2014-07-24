using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Data;

namespace Examinator
{
    /// <summary>
    /// Summary description for QuizService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class QuizService : System.Web.Services.WebService
    {

        [WebMethod]
        public string getTest(string category, string mode, string difficulty, string showUnapproved)
        {
            DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");
           
            dal.AddParam("@CatName", category);
            dal.AddParam("@Difficulty", difficulty);
            if (mode == "exam"|| showUnapproved=="no")
            {
                dal.AddParam("@ApprovedOnly", "yes");
            }
            else
            {
                dal.AddParam("@ApprovedOnly", "no");
            }
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetQuiz");

            DataTable dt = ds.Tables[0];

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            return serializer.Serialize(rows);
        }

        [WebMethod]
        public void recordScores(string user, string category, int score, int totalTime, bool scoreBit)
        {
            DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");
            dal.AddParam("@UserName", user);
            dal.AddParam("@CatName", category);
            dal.AddParam("@Score", score);
            dal.AddParam("@TotalTime", totalTime);
            dal.AddParam("@ScoreBit", scoreBit);
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spWriteScores");
        }

        [WebMethod]
        public void updateTimes(int questionID, int newTime)
        {
            DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");
            dal.AddParam("@QuestionID", questionID);
            dal.AddParam("@QuestionNewTime", newTime);
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spUpdateDefaultTimes");
        }
    }
}