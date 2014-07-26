using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Examinator
{
    public partial class Editor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropdown();
                PopulateGridview("Unapproved");
            }
        }

        protected void PopulateDropdown()
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            ds = dal.ExecuteProcedure("spGetCategory2");
            int len = ds.Tables[0].Rows.Count + 1;
            string[] dropdownSource = new string[len];
            dropdownSource[0] = "Unapproved Questions";
            for (int i = 1; i < len; i++)
            {
                dropdownSource[i] = ds.Tables[0].Rows[i-1]["CatName"].ToString();
            }            
            ddCategories.DataSource = dropdownSource;
            ddCategories.DataBind();
        }

        protected void PopulateGridview(string catName)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@CatName", catName);
            ds = dal.ExecuteProcedure("spGetAll");
            gvEditor.DataSource = ds;
            gvEditor.DataBind();
        }

        protected void ddCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            string category = ddCategories.SelectedItem.Text;
            gvEditor.PageIndex = 0;
            PopulateGridview(category);
        }

        protected void gvEditor_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            PopulateGridview(ddCategories.SelectedItem.Text);
            gvEditor.PageIndex = e.NewPageIndex;
            gvEditor.DataBind();
        }

        protected void gvEditor_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEditor.EditIndex = e.NewEditIndex;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

        protected void gvEditor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEditor.EditIndex = -1;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

        protected void gvEditor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = (GridViewRow)gvEditor.Rows[e.RowIndex];
            int questionID = (int)gvEditor.DataKeys[e.RowIndex]["QuestionID"];
            int categoryID = (int)gvEditor.DataKeys[e.RowIndex]["CategoryID"];

            CheckBox cbQuestionApproval = (CheckBox)row.FindControl("cbQuestionApproval");
            CheckBox cbQuestionBit = (CheckBox)row.FindControl("cbQuestionBit");
            TextBox tbQuestionTxt = (TextBox)row.FindControl("tbQuestionTxt");            
            UpdateQuestion(categoryID, questionID, cbQuestionApproval.Checked, cbQuestionBit.Checked, tbQuestionTxt.Text);

            TextBox tbCatName = (TextBox)row.FindControl("tbCatName");
            TextBox tbCatDesc = (TextBox)row.FindControl("tbCatDesc");
            UpdateCategory(categoryID, tbCatName.Text, tbCatDesc.Text);

            TextBox tbAnswerCorrect = (TextBox)row.FindControl("tbAnswerCorrect");
            TextBox tbAnswer1 = (TextBox)row.FindControl("tbAnswer1");
            TextBox tbAnswer2 = (TextBox)row.FindControl("tbAnswer2");
            TextBox tbAnswer3 = (TextBox)row.FindControl("tbAnswer3");
            TextBox tbAnswer4 = (TextBox)row.FindControl("tbAnswer4");
            TextBox tbAnswer5 = (TextBox)row.FindControl("tbAnswer5");
            UpdateAnswer(questionID, tbAnswerCorrect.Text, tbAnswer1.Text, tbAnswer2.Text, tbAnswer3.Text, tbAnswer4.Text, tbAnswer5.Text);

            TextBox tbExplnText = (TextBox)row.FindControl("tbExplnText");
            UpdateExplanation(questionID, tbExplnText.Text);
            gvEditor.EditIndex = -1;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

        protected void UpdateQuestion(int categoryID, int questionID, bool questionApproval, bool questionActive, string questionText)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            dal.AddParam("@QuestionID", questionID);
            dal.AddParam("@QuestionCatID", categoryID);
            dal.AddParam("@QuestionText", questionText);
            dal.AddParam("@QuestionApprovalBit", questionApproval);
            dal.AddParam("@QuestionBit", questionActive);
            dal.ExecuteProcedure("spUpdateQuestions");

        }

        protected void UpdateCategory(int categoryID, string catName, string catDesc)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            dal.AddParam("@CatID", categoryID);
            dal.AddParam("@CatName", catName);
            dal.AddParam("@CatDesc", catDesc);
            dal.ExecuteProcedure("spUpdateCat");
        }

        protected void UpdateAnswer(int questionID, string answerCorrect, string answer1, string answer2, string answer3, string answer4, string answer5)
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

        protected void UpdateExplanation(int questionID, string explnText)
        {
            DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
            DataSet ds = new DataSet();
            dal.AddParam("@ExplanationQuestionID", questionID);
            dal.AddParam("@ExplanationText", explnText);
            dal.ExecuteProcedure("spUpdateExplanations");
        }      
    }
}