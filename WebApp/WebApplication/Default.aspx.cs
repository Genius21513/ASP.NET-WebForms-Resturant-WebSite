using System;
using WebApplication.Business;
using WebApplication.Components;

namespace WebApplication
{
    public partial class _Default : BasePage
    {
        private UserBusiness userBusiness;

        public _Default()
        {
            userBusiness = new UserBusiness();
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            this.cmdLogin.ServerClick += new System.EventHandler (this.cmdLogin_ServerClick);
        }

        private bool ValidateUser(string userName, string passWord)
        {                                    
            if ((null == userName) || (0 == userName.Length) || (userName.Length > 15))
            {
                System.Diagnostics.Trace.WriteLine("[ValidateUser] Input validation of userName failed.");
                return false;
            }
            
            if ((null == passWord) || (0 == passWord.Length) || (passWord.Length > 25))
            {
                System.Diagnostics.Trace.WriteLine("[ValidateUser] Input validation of passWord failed.");
                return false;
            }             
                                   
            return userBusiness.AuthenticateUser(new Data.ContextBase(), userName, passWord);
        }

        private void cmdLogin_ServerClick(object sender, System.EventArgs e)
        {
            if (ValidateUser(txtUserName.Value, txtUserPass.Value))
            {
                Session.Add("User", txtUserName.Value);                                
                Response.Redirect("Home.aspx", true);
            }
            else
            {
                Response.Redirect("default.aspx", true);
            }
        }        
    }
}