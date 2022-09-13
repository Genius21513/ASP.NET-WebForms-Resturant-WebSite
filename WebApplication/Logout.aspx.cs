using System;
using WebApplication.Components;

namespace WebApplication
{
    public partial class Logout : BasePage
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);  

            Session.Abandon();
            Response.Redirect("default.aspx", true);
        }
    }
}