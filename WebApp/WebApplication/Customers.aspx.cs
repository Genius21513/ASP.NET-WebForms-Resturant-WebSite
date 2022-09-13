using AjaxPro;
using System;
using WebApplication.Business;
using WebApplication.Components;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Customers : BasePage
    {
        CustomerBusiness customerBusiness;

        public Customers()
        {
            customerBusiness = new CustomerBusiness();

        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Customers));

            if (!Page.IsPostBack)
            {
                var dtCustomers = customerBusiness.Get(contextBase, string.Empty);

                if (dtCustomers != null && dtCustomers.Rows.Count > 0)
                {
                    grdDados.DataSource = dtCustomers;
                    grdDados.DataBind();
                }
            }

            base.Page_Load(sender, e);
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void Save(Customer customer)
        {
            customerBusiness.Add(contextBase, customer);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Customer Get(int id)
        {
            return customerBusiness.GetById(contextBase, id);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string Delete(int id)
        {
            customerBusiness.Delete(contextBase, id);

            return "OK";
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void SetCustomer(int id)
        {
            Cart.GetCart(Session).SetCustomer(id);
        }
        #endregion

        protected string FormateLine(string id, string firstName, string email, string phoneNumber)
        {
            int customerId = Cart.GetCart(Session).CustomerId;
            string customerSelect;
            if ((customerId > 0 && customerId.ToString() == id))
            {
                customerSelect = "Current Customer";
            }
            else
            {
                customerSelect = "Set Customer";
            }

            return $@"<div class='customer-item'>                       
                        <img width=""60"" height=""60"" src=""Content/Image/user.png"" align=""middle""/>                          
                        <span>
                                <h3>{firstName}</h3>
                                {email}</br>
                                {phoneNumber}</br>                                                                                                         
                        </span>
                      <div>
                            <input value ='Edit' onclick='Edit({id})' type='button'/>
                            <input value ='Delete' onclick='Delete({id})' type='button'/>
                            <input class='customer' value ='{customerSelect}' onclick='SetCustomer(this, {id})' type='button'/>
                      </div>
                      </div>";
        }
    }
}