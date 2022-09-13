using AjaxPro;
using System;
using System.Data;
using WebApplication.Components;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Settings : BasePage
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Settings));
            var user = Session["User"];

            if (user != null)
            {
                using (AccessData accessData = new AccessData(contextBase))
                {
                    DataTable setting = accessData.GetDT(Factory.CreateSetting().Get(user.ToString()));
                }
            }
            else
            {
                Response.Redirect("default.aspx", true);
            }
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public object GetData()
        {
            Setting setting;

            var user = Session["User"];

            if (user != null)
            {
                using (AccessData accessData = new AccessData(contextBase))
                {
                    DataTable dtSetting = accessData.GetDT(Factory.CreateSetting().Get(user.ToString()));

                    setting = new Setting(dtSetting);
                }
            }
            else
            {
                throw new ArgumentException("");
            }

            return setting;
        }
        #endregion
    }
}