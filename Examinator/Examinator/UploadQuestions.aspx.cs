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
using Examinator_Classes;

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

                    Question writeQuestion = new Question();

                    string temp = writeQuestion.writeSchema(filePath, fileInfo.Name);
                    if (temp != "OK")
                    {
                        setLabel(temp, "red");
                    }

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
                            int catID = writeQuestion.insertCategory(dtCSV.Rows[i][0].ToString(), dtCSV.Rows[i][1].ToString());
                            if (catID != -1)
                            {
                                User currentUser = (User)Session["User"];
                                int questionID = writeQuestion.insertQuestion(catID, currentUser.UserName, dtCSV.Rows[i][2].ToString());

                                if (questionID != -1)
                                {
                                    temp = writeQuestion.insertAnswer(questionID, dtCSV.Rows[i][3].ToString(), dtCSV.Rows[i][4].ToString(), dtCSV.Rows[i][5].ToString(), dtCSV.Rows[i][6].ToString(), dtCSV.Rows[i][7].ToString(), dtCSV.Rows[i][8].ToString());
                                    if (temp == "OK")
                                    {
                                        temp = writeQuestion.insertExplanation(questionID, dtCSV.Rows[i][9].ToString());
                                        if (temp !="OK")
                                            setLabel(temp, "#F72862");
                                    }
                                    else
                                        setLabel(temp, "#F72862");
                                }
                                else
                                    setLabel("An Error has Occurred.", "#F72862");
                            }
                            else
                                setLabel("An Error has Occurred.", "#F72862");
                        }
                        setLabel(string.Format("({0}) record(s) have been loaded to the database.", dtCSV.Rows.Count), "#15E626");
                    }
                    else
                        setLabel("File is empty.", "#F72862");
                }
                else                 
                    setLabel("Unable to recognize file.", "#F72862");
            }
        }
 

        protected void setLabel(string message, string color)
        {
            Label l = (Label)Master.FindControl("lblMessage");
            l.Text = message;
            l.Style.Add("text-shadow", "2px 2px 2px " + color + ";");
            l.Visible = true;
        }

    }
}