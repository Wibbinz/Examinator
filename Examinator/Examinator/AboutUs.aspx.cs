using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Examinator
{
    public partial class AboutUs : System.Web.UI.Page
    {
        //To ensure a new user is not subject to the registration message
        //every time the visit the home page, the New session is reset to null.
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["New"] = null;
        }
    }
}