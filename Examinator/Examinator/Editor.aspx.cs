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
            Question newQuestion = new Question();   
            string[]ddSource = newQuestion.GetDropDownSource();
            if (ddSource[0] != "Error!")
            {
                ddCategories.DataSource = ddSource;
                ddCategories.DataBind();
            }
            else
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void PopulateGridview(string catName)
        {
            try
            {
                DAL.DAL dal = new DAL.DAL("Data Source = localhost; Initial Catalog = dbExaminator; Integrated Security = True");
                DataSet ds = new DataSet();
                dal.AddParam("@CatName", catName);
                ds = dal.ExecuteProcedure("spGetAll");
                gvEditor.DataSource = ds;
                gvEditor.DataBind();
            }
            catch
            {
            }
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
            //UpdateQuestion(categoryID, questionID, cbQuestionApproval.Checked, cbQuestionBit.Checked, tbQuestionTxt.Text);
            TextBox tbCatName = (TextBox)row.FindControl("tbCatName");
            TextBox tbCatDesc = (TextBox)row.FindControl("tbCatDesc");
            //UpdateCategory(categoryID, tbCatName.Text, tbCatDesc.Text);
            TextBox tbAnswerCorrect = (TextBox)row.FindControl("tbAnswerCorrect");
            TextBox tbAnswer1 = (TextBox)row.FindControl("tbAnswer1");
            TextBox tbAnswer2 = (TextBox)row.FindControl("tbAnswer2");
            TextBox tbAnswer3 = (TextBox)row.FindControl("tbAnswer3");
            TextBox tbAnswer4 = (TextBox)row.FindControl("tbAnswer4");
            TextBox tbAnswer5 = (TextBox)row.FindControl("tbAnswer5");
            //UpdateAnswer(questionID, tbAnswerCorrect.Text, tbAnswer1.Text, tbAnswer2.Text, tbAnswer3.Text, tbAnswer4.Text, tbAnswer5.Text);
            TextBox tbExplnText = (TextBox)row.FindControl("tbExplnText");
            //UpdateExplanation(questionID, tbExplnText.Text);

            Question newQuestion = new Question(categoryID, questionID, cbQuestionApproval.Checked, cbQuestionBit.Checked, tbQuestionTxt.Text, tbCatName.Text, tbCatDesc.Text, tbAnswerCorrect.Text, tbAnswer1.Text, tbAnswer2.Text, tbAnswer3.Text, tbAnswer4.Text, tbAnswer5.Text, tbExplnText.Text);
            newQuestion.UpdateAll(newQuestion);

            gvEditor.EditIndex = -1;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

       
    }
}