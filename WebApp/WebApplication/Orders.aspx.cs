using AjaxPro;
using System;
using WebApplication.Business;
using WebApplication.Components;

namespace WebApplication
{
    public partial class Orders : BasePage
    {
        protected string OrderCode { get; set; }
        protected string OrderId { get; set; }
        protected string CustomerEmail { get; set; }

        OrdensBusiness ordensBusiness;

        public Orders()
        {
            ordensBusiness = new OrdensBusiness();
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Orders));

            if (!Page.IsPostBack)
            {
                var dtOrders = ordensBusiness.Get(contextBase);

                if (dtOrders != null && dtOrders.Rows.Count > 0)
                {
                    grdDados.DataSource = dtOrders;
                    grdDados.DataBind();

                    OrderCode = "Order#" + dtOrders.Rows[0]["OrdemId"].ToString();
                    CustomerEmail = dtOrders.Rows[0]["Email"].ToString();
                    OrderId = dtOrders.Rows[0]["Id"].ToString();
                }
            }

            base.Page_Load(sender, e);
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string Start(string ordemID)
        {
            return OrdensBusiness.ListProduct(ordemID);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string Select(string ordemID)
        {
            return OrdensBusiness.ListProduct(ordemID);
        }
        #endregion

        protected string FormateLine(string orderId, string id, string date, string email, string total, string countItens)
        {
            //todo colocar arrow
            return $@"<div onclick=""select(this, '{orderId}')"" class='customer-item'>                                               
                        <span>
                                <h3>Order #{id}</h3> </br>
                                <span>{date}</span></br>
                                <span>{email}</span>
                        </span>
                        <div style=""text-align: right;"">
                            <h3>${total}</h3></br>
                            <span>{countItens} item(s)</span>
                        </div>
                      </div>";
        }
    }
}
