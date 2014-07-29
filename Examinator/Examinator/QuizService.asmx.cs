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
    /// These webmethods are quiz related: getting quiz questions, answers, etc. from the database, recording
    /// scores to the database and updating times in the database.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class QuizService : System.Web.Services.WebService
    {

        /// <summary>
        /// The jquery in 'TakeTheTest' calls on the javascript function 'getQuiz' in Exam.js, which in turn
        /// calls this webmethod. 
        /// The parameters are passed through the 'spGetQuiz' procedure in the database and the resulting
        /// dataset is serialized so it can be returned and read in the Exam.js method 'getQuiz.'
        /// </summary>
        /// <param name="category"></param>
        /// <param name="mode"></param>
        /// <param name="difficulty"></param>
        /// <param name="showUnapproved">NOTE: This might be a little confusing as the variable names have opposite meanings.
        /// If the boolean showUnapproved is false, it means @ApprovedOnly must be 'yes.' </param>
        /// <returns></returns>
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


        /// <summary>
        /// Called from 'sendResults' in Exam.js, this writes the scores to the database.
        /// </summary>
        /// <param name="user"></param>
        /// <param name="category"></param>
        /// <param name="score"></param>
        /// <param name="totalTime"></param>
        /// <param name="scoreBit"></param>
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


        /// <summary>
        /// Called from 'setNewTimes' in Exam.js - this writes new times to the databse.
        /// </summary>
        /// <param name="questionID"></param>
        /// <param name="newTime"></param>
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