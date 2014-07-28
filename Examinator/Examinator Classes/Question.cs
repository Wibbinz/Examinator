using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Text;

namespace Examinator_Classes
{
    public class Question
    {
        public int _categoryID;
        public int _questionID;
        public bool _approved;
        public bool _active;
        public string _questionText;
        public string _catName;
        public string _catDesc;
        public string _correctAnswer;
        public string _answer1;
        public string _answer2;
        public string _answer3;
        public string _answer4;
        public string _answer5;
        public string _explanationText;

        public int CategoryID { get { return _categoryID; } set { _categoryID = value; } }
        public int QuestionID { get { return _questionID; } set { _questionID = value; } }
        public bool Approved { get { return _approved; } set { _approved = value; } }
        public bool Active { get { return _active; } set { _active = value; } }
        public string QuestionText { get { return _questionText; } set { _questionText = value; } }
        public string CategoryName { get { return _catName; } set { _catName = value; } }
        public string CategoryDesc { get { return _catDesc; } set { _catDesc = value; } }
        public string CorrectAnswer { get { return _correctAnswer; } set { _correctAnswer = value; } }
        public string Answer1 { get { return _answer1; } set { _answer1 = value; } }
        public string Answer2 { get { return _answer2; } set { _answer2 = value; } }
        public string Answer3 { get { return _answer3; } set { _answer3 = value; } }
        public string Answer4 { get { return _answer4; } set { _answer4 = value; } }
        public string Answer5 { get { return _answer5; } set { _answer5 = value; } }
        public string ExplanationText { get { return _explanationText; } set { _explanationText = value; } }

        public Question() : this(-1, -1, false, false, "default", "default", "default", "default", "default", "default", "default", "default", "default", "default") { }

        public Question(int catID, int qID, bool app, bool act, string qtext, string catName, string catDesc, string cAnswer, string ans1, string ans2, string ans3, string ans4, string ans5, string expln)
        {
            _categoryID = catID; _questionID = qID; _approved = app; _active = act;
            _questionText = qtext; _catName = catName; _catDesc = catDesc; _correctAnswer = cAnswer; _answer1 = ans1; _answer2 = ans2;
            _answer3 = ans3; _answer4 = ans4; _answer5 = ans5; _explanationText = expln;
        }


        public string CatInfo(bool showUnapproved)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");
                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spGetCategory2");
                int length = ds.Tables[0].Rows.Count;
                string[] category = new string[length];
                string[] description = new string[length];
                string[] modes = new string[length];
                int temp = 0; bool result;

                for (int i = 0; i < length; i++)
                {
                    if (showUnapproved || Int32.TryParse(ds.Tables[0].Rows[i]["QuestionsApproved"].ToString(), out temp))
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
            catch (Exception e)
            {
                return "Error: " + e.ToString();
            }
        }


        public string[] GetDropDownSource()
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spGetCategory2");
                int len = ds.Tables[0].Rows.Count + 1;
                string[] dropdownSource = new string[len];
                dropdownSource[0] = "Unapproved Questions";
                for (int i = 1; i < len; i++)
                {
                    dropdownSource[i] = ds.Tables[0].Rows[i - 1]["CatName"].ToString();
                }

                return dropdownSource;
            }
            catch (Exception e)
            {
                string[] temp = new string[1];
                temp[0] = "Error!";
                return temp;
            }
        }

        public void UpdateAll(Question updateQuestion)
        {
            UpdateQuestion(updateQuestion.CategoryID, updateQuestion.QuestionID, updateQuestion.Approved, updateQuestion.Active, updateQuestion.QuestionText);
            UpdateCategory(updateQuestion.CategoryID, updateQuestion.CategoryName, updateQuestion.CategoryDesc);
            UpdateAnswer(updateQuestion.QuestionID, updateQuestion.CorrectAnswer, updateQuestion.Answer1, updateQuestion.Answer2, updateQuestion.Answer3, updateQuestion.Answer4, updateQuestion.Answer5);
            UpdateExplanation(updateQuestion.QuestionID, updateQuestion.ExplanationText);
        }


        protected void UpdateQuestion(int categoryID, int questionID, bool questionApproval, bool questionActive, string questionText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                dal.AddParam("@QuestionID", questionID);
                dal.AddParam("@QuestionCatID", categoryID);
                dal.AddParam("@QuestionText", questionText);
                dal.AddParam("@QuestionApprovalBit", questionApproval);
                dal.AddParam("@QuestionBit", questionActive);
                dal.ExecuteProcedure("spUpdateQuestions");
            }
            catch
            {                
            }
        }

        protected void UpdateCategory(int categoryID, string catName, string catDesc)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                dal.AddParam("@CatID", categoryID);
                dal.AddParam("@CatName", catName);
                dal.AddParam("@CatDesc", catDesc);
                dal.ExecuteProcedure("spUpdateCat");
            }
            catch
            {
            }
        }

        protected void UpdateAnswer(int questionID, string answerCorrect, string answer1, string answer2, string answer3, string answer4, string answer5)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                DataSet ds = new DataSet();
                dal.AddParam("@AnswerQuestionID", questionID);
                dal.AddParam("@AnswerCorrect", answerCorrect);
                dal.AddParam("@Answer1", answer1);
                dal.AddParam("@Answer2", answer2);
                dal.AddParam("@Answer3", answer3);
                dal.AddParam("@Answer4", answer4);
                dal.AddParam("@Answer5", answer5);
                dal.ExecuteProcedure("spUpdateAnswers");
            }
            catch
            {
            }
        }

        protected void UpdateExplanation(int questionID, string explnText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                DataSet ds = new DataSet();
                dal.AddParam("@ExplanationQuestionID", questionID);
                dal.AddParam("@ExplanationText", explnText);
                dal.ExecuteProcedure("spUpdateExplanations");
            }
            catch
            {
            }
        }

        public string writeSchema(string filePath, string fileName)
        {
            try
            {
                using (FileStream filestr = new FileStream(filePath + "\\schema.ini",
                        FileMode.Create, FileAccess.Write))
                {
                    using (StreamWriter writer = new StreamWriter(filestr))
                    {
                        writer.WriteLine("[" + fileName + "]");
                        writer.WriteLine("ColNameHeader=False");
                        writer.WriteLine("MaxScanRows=0");
                        writer.WriteLine("Format=CSVDelimited");
                        writer.WriteLine("DateTimeFormat=yyyy-mm-dd");
                        writer.WriteLine("Col1=UploadCatName Text Width 25");
                        writer.WriteLine("Col2=UploadCatDesc Text Width 65");
                        writer.WriteLine("Col3=UploadQuestionTxt Text Width 256");
                        writer.WriteLine("Col4=UploadAnswerCorrect Text Width 256");
                        writer.WriteLine("Col5=UploadAnswer1 Text Width 256");
                        writer.WriteLine("Col6=UploadAnswer2 Text Width 256");
                        writer.WriteLine("Col7=UploadAnswer3 Text Width 256");
                        writer.WriteLine("Col8=UploadAnswer4 Text Width 256");
                        writer.WriteLine("Col9=UploadAnswer5 Text Width 256");
                        writer.WriteLine("Col10=UploadExplnText Text Width 500");
                        writer.Close();
                        writer.Dispose();
                    }
                    filestr.Close();
                    filestr.Dispose();
                }
                return "OK";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public int insertCategory(string catName, string catDesc)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@CatName", catName);
                dal.AddParam("@CatDesc", catDesc);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadCat");

                return Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            }
            catch
            {
                return -1;
            }
        }

        public int insertQuestion(int catID, string user, string questionText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@QuestionCatID", catID);
                dal.AddParam("@QuestionUploader", user);
                dal.AddParam("@QuestionText", questionText);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadQuestions");

                return Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            }
            catch
            {
                return -1;
            }            
        }

        public string insertAnswer(int questionID, string answerCorrect, string answer1, string answer2, string answer3, string answer4, string answer5)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@AnswerQuestionID", questionID);
                dal.AddParam("@AnswerCorrect", answerCorrect);
                dal.AddParam("@Answer1", answer1);
                dal.AddParam("@Answer2", answer2);
                dal.AddParam("@Answer3", answer3);
                dal.AddParam("@Answer4", answer4);
                dal.AddParam("@Answer5", answer5);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadAnswers");
                return "OK";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }

        public string insertExplanation(int questionID, string explanationText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@ExplanationQuestionID", questionID);
                dal.AddParam("@ExplanationText", explanationText);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadExplanations");
                return "OK";
            }
            catch (Exception e)
            {
                return e.ToString();
            }
        }



    }
}
