using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.IO;
using System.Text;

namespace Examinator
{
    public partial class UploadQuestions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fuQuestions.HasFile)
            {
                FileInfo fileInfo = new FileInfo(fuQuestions.PostedFile.FileName);

                if (fileInfo.Name.Contains(".csv"))
                {
                    string fileName = fileInfo.Name.Replace(".csv", "").ToString();
                    string csvFilePath = Server.MapPath("UploadedCSVFiles") + "\\" + fileInfo.Name;

                    //Save the CSV file in the Server inside 'UploadedCSVFiles' 

                    fuQuestions.SaveAs(csvFilePath);

                    //Fetch the location of CSV file 

                    string filePath = Server.MapPath("UploadedCSVFiles") + "\\";
                    string strSql = "SELECT * FROM [" + fileInfo.Name + "]";
                    string strCSVConnString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";" + "Extended Properties='text;HDR=YES;'";

                    writeSchema(filePath, fileInfo.Name);

                    // load the data from CSV to DataTable 

                    OleDbDataAdapter adapter = new OleDbDataAdapter(strSql, strCSVConnString);
                    DataTable dtCSV = new DataTable();
                    DataTable dtSchema = new DataTable();

                    adapter.FillSchema(dtCSV, SchemaType.Mapped);
                    adapter.Fill(dtCSV);

                    if (dtCSV.Rows.Count > 0)
                    {
                        if (dtCSV.Rows[0][0].ToString() == "UploadCatName")
                        {
                            dtCSV.Rows[0].Delete();
                            dtCSV.AcceptChanges();
                        }
                        GridView1.DataSource = dtCSV;
                        GridView1.DataBind();

                        for (int i = 0; i < dtCSV.Rows.Count; i++)
                        {
                            int catID = insertCategory(dtCSV.Rows[i][0].ToString(), dtCSV.Rows[i][1].ToString());

                            if (catID != -1)
                            {

                                int questionID = insertQuestion(catID, dtCSV.Rows[i][2].ToString());

                                if (questionID != -1)
                                {
                                    insertAnswer(questionID, dtCSV.Rows[i][3].ToString(), dtCSV.Rows[i][4].ToString(), dtCSV.Rows[i][5].ToString(), dtCSV.Rows[i][6].ToString(), dtCSV.Rows[i][7].ToString(), dtCSV.Rows[i][8].ToString());

                                    insertExplanation(questionID, dtCSV.Rows[i][9].ToString());
                                }
                                else
                                {
                                    lblStatus.Visible = true;
                                    lblStatus.Text = "An Error has Occurred.";
                                }
                            }
                            else
                            {
                                lblStatus.Visible = true;
                                lblStatus.Text = "An Error has Occurred.";
                            }
                        }
                        lblStatus.Visible = true;
                        lblStatus.Text = string.Format("({0}) record(s) have been loaded to the database.", dtCSV.Rows.Count);
                    }
                    else
                    {
                        lblStatus.Visible = true;
                        lblStatus.Text = "File is empty.";
                    }
                }
                else
                {
                    lblStatus.Visible = true;
                    lblStatus.Text = "Unable to recognize file.";
                }
            }
        }
        protected void writeSchema(string filePath,string fileName)
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
            }
            catch (Exception e)
            {
                lblStatus.Visible = true;
                lblStatus.Text = e.ToString();
            }
        }
        protected int insertCategory(string catName, string catDesc)
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
            catch (Exception e)
            {
                lblStatus.Visible = true;
                lblStatus.Text = e.ToString();
            }
            return -1;
        }
        protected int insertQuestion(int catID, string questionText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@QuestionCatID", catID);
                //dal.AddParam("@QuestionUploader", 1002);
                dal.AddParam("@QuestionText", questionText);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadQuestions");

                return Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            }
            catch (Exception e)
            {
                lblStatus.Visible = true;
                lblStatus.Text = e.ToString();
            }
            return -1;
        }
        protected void insertAnswer(int questionID, string answerCorrect, string answer1, string answer2, string answer3, string answer4, string answer5)
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
            }
            catch (Exception e)
            {
                lblStatus.Visible = true;
                lblStatus.Text = e.ToString();
            }        
        }
        protected void insertExplanation(int questionID, string explanationText)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source=localhost;Initial Catalog=dbExaminator;Integrated Security=True");

                dal.AddParam("@ExplanationQuestionID", questionID);
                dal.AddParam("@ExplanationText", explanationText);

                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spUploadExplanations");
            }
            catch (Exception e)
            {
                lblStatus.Visible = true;
                lblStatus.Text = e.ToString();
            }            
        }
    }
}