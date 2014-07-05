using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Examinator
{
    public partial class TakeTheTest : System.Web.UI.Page
    {        
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public string GetArrayStream()
        {
            string[] category = {"potato","watermelon","panda","buckit","doctor", "data","spock","seven"};

            string returnStr = "";
            for (int index = 0; index < category.Length; index++)
                returnStr += category[index] + (index == category.Length - 1 ? "" : "|");
            return returnStr;
        }
            
    }
}