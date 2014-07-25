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
            PopulateGridview(category);
        }
    }
}