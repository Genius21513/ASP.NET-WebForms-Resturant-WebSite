using AjaxPro;
using System;
using WebApplication.Business;
using WebApplication.Components;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Users : BasePage
    {
        UserBusiness userBusiness;

        public Users()
        {
            userBusiness = new UserBusiness();

        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Users));

            if (!Page.IsPostBack)
            {
                var dtUsers = userBusiness.List(contextBase);

                if (dtUsers != null && dtUsers.Rows.Count > 0)
                {
                    grdDados.DataSource = dtUsers;
                    grdDados.DataBind();
                }
            }

            base.Page_Load(sender, e);
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void Save(Entity.User user)
        {
            userBusiness.Add(contextBase, user);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public User Get(int id)
        {
            return userBusiness.GetById(contextBase, id);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string Delete(int id)
        {
            //userBusiness.Delete(contextBase, id);

            return "OK";
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void SetCustomer(int id)
        {
            Cart.GetCart(Session).SetCustomer(id);
        }
        #endregion

        protected string FormateLine(string id, string firstName, string email)
        {
            //<input class='customer' value ='0' onclick='SetCustomer(this, {id})' type='button'/>
            return $@"<div class='customer-item'>                       
                        <img width=""60"" height=""60"" src=""Content/Image/user.png"" align=""middle""/>                          
                        <span>
                                <h3>{firstName}</h3>
                                {email}</br>                                
                        </span>
                      <div>
                            <input value ='Edit' onclick='Edit({id})' type='button'/>                                                        
                      </div>
                      </div>";
        }
    }
}