using System;
using System.Web.UI;
using WebApplication.Business;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Components
{
    /// <summary>
    /// Page
    /// </summary>
    public abstract class BasePage : Page
    {
        /// <summary>
        /// Context base
        /// </summary>
        protected ContextBase contextBase;

        /// <summary>
        /// web session
        /// </summary>
        protected WebSession webSession;

        /// <summary>
        /// Constutor
        /// </summary>
        public BasePage()
        {
            webSession = new WebSession();
            contextBase = new ContextBase();
        }

        /// <summary>
        /// Page load
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected virtual void Page_Load(object sender, EventArgs e)
        {
            if (Session[Const.User] == null)
            {
                Response.Redirect(Const.Redirect, true);
            }
            else
            {
                if (Session[Const.SessionCartName] == null)
                {
                    System.Data.DataTable listaProdutos = new ProductBusiness().Get(contextBase, string.Empty);
                    new Cart(Session, listaProdutos);
                }                
            }
        }         
    }
}
