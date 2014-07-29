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

        /// <summary>
        /// The GetDropDownSource method is invoked from the Question class
        /// to populate the dropdown. If any errors are encountered, the user is redirected home.
        /// </summary>
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

        /// <summary>
        /// The database procedure 'GetAll' is invoked to populate the gridview with all questions in a specified
        /// category.
        /// </summary>
        /// <param name="catName"></param>
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


        /// <summary>
        /// The PopulateGridview method is invoked to populate the gridview based on the category
        /// selected from the dropdown menu.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ddCategories_SelectedIndexChanged(object sender, EventArgs e)
        {
            string category = ddCategories.SelectedItem.Text;
            gvEditor.PageIndex = 0;
            PopulateGridview(category);
        }

        //New page index is set to display the correct page on the gridview.
        protected void gvEditor_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            PopulateGridview(ddCategories.SelectedItem.Text);
            gvEditor.PageIndex = e.NewPageIndex;
            gvEditor.DataBind();
        }

        //Edit index is updated with the row number when the Edit button in the gridview is clicked.
        protected void gvEditor_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEditor.EditIndex = e.NewEditIndex;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

        //Edit index is set to -1 when the edit action is cancelled.
        protected void gvEditor_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEditor.EditIndex = -1;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

        /// <summary>
        /// After the administrator has made necessary changes and clicks the Update button,
        /// the values are stored in the newQuestion variable of class 'Question' and the UpdateAll
        /// method in the Question Class is invoked to send the information to the database.
        /// 
        /// Then the edit index is set back to -1 and the gridview is repopulated.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvEditor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {            
            GridViewRow row = (GridViewRow)gvEditor.Rows[e.RowIndex];
            int questionID = (int)gvEditor.DataKeys[e.RowIndex]["QuestionID"];
            int categoryID = (int)gvEditor.DataKeys[e.RowIndex]["CategoryID"];
            CheckBox cbQuestionApproval = (CheckBox)row.FindControl("cbQuestionApproval");
            CheckBox cbQuestionBit = (CheckBox)row.FindControl("cbQuestionBit");
            TextBox tbQuestionTxt = (TextBox)row.FindControl("tbQuestionTxt");            
            TextBox tbCatName = (TextBox)row.FindControl("tbCatName");
            TextBox tbCatDesc = (TextBox)row.FindControl("tbCatDesc");
            TextBox tbAnswerCorrect = (TextBox)row.FindControl("tbAnswerCorrect");
            TextBox tbAnswer1 = (TextBox)row.FindControl("tbAnswer1");
            TextBox tbAnswer2 = (TextBox)row.FindControl("tbAnswer2");
            TextBox tbAnswer3 = (TextBox)row.FindControl("tbAnswer3");
            TextBox tbAnswer4 = (TextBox)row.FindControl("tbAnswer4");
            TextBox tbAnswer5 = (TextBox)row.FindControl("tbAnswer5");
            TextBox tbExplnText = (TextBox)row.FindControl("tbExplnText");

            Question newQuestion = new Question(categoryID, questionID, cbQuestionApproval.Checked, cbQuestionBit.Checked, tbQuestionTxt.Text, tbCatName.Text, tbCatDesc.Text, tbAnswerCorrect.Text, tbAnswer1.Text, tbAnswer2.Text, tbAnswer3.Text, tbAnswer4.Text, tbAnswer5.Text, tbExplnText.Text);
            newQuestion.UpdateAll(newQuestion);

            gvEditor.EditIndex = -1;
            PopulateGridview(ddCategories.SelectedItem.Text);
        }

       
    }
}