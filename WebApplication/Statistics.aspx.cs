using AjaxPro;
using System;
using System.Data;
using System.Drawing;
using System.Web.UI;
using WebApplication.Business;
using WebApplication.Components;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Statistics : BasePage
    {
        StatisticsBusiness statisticsBusiness;

        public Statistics()
        {
            statisticsBusiness = new StatisticsBusiness();
        }

        //Open Cash Drawer Amount
        protected decimal OpenCash { get; set; }

        //Today's Cash Sale
        protected decimal CashSale { get; set; }

        //Today's Total Sale
        protected decimal TotalSale { get; set; }

        //Expected Drawer Amount
        protected decimal DrawerAmount { get; set; }

        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Statistics));

            if (!Page.IsPostBack)
            {
                var dtStatistics = statisticsBusiness.Get(contextBase);

                var dtStatisticsDash = statisticsBusiness.GetDash(contextBase);

                if (dtStatistics != null && dtStatistics.Rows.Count > 0)
                {
                    grdDados.DataSource = dtStatistics;
                    grdDados.DataBind();
                }

                if (dtStatisticsDash != null && dtStatisticsDash.Rows.Count > 0)
                {
                    DataRow dr = dtStatisticsDash.Rows[0];
                    OpenCash = decimal.TryParse(dr["OpenCash"].ToString(), out decimal openCash) ? openCash : 0;
                    CashSale = decimal.TryParse(dr["CashSale"].ToString(), out decimal cashSale) ? cashSale : 0;
                    TotalSale = decimal.TryParse(dr["TotalSale"].ToString(), out decimal totalSale) ? totalSale : 0;
                    DrawerAmount = decimal.TryParse(dr["DrawerAmount"].ToString(), out decimal drawerAmount) ? drawerAmount : 0;
                }
            }

            base.Page_Load(sender, e);
        }

        protected string Out(string value)
        {
            value = String.IsNullOrWhiteSpace(value) ? "0.00" : value;
            return $@"<label style=""color: red;"">- ${value}</label>";
        }

        protected string In(string value)
        {
            value = String.IsNullOrWhiteSpace(value) ? "0.00" : value;
            return $@"<label style=""color: green;"">+ ${value}</label>";
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string Manual(string amount, string transactionType, string reference)
        {
            if (transactionType == "1")
            {
                StatisticsBusiness.Manual(new Data.ContextBase(), decimal.Parse(amount), 0, reference);
            }
            else
            {
                StatisticsBusiness.Manual(new Data.ContextBase(), 0, decimal.Parse(amount), reference);
            }

            return "Ok";
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public string OpenCashDrawerAmount(string amount)
        {
            Cart cart = Cart.GetCart(Session);

            if (!cart.OpenCashDrawerAmount)
            {
                cart.OpenCashDrawerAmount = StatisticsBusiness.OpenCashDrawerAmount(new Data.ContextBase(), decimal.Parse(amount));
            }

            return "Ok";
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public bool IsOpenCashDrawerAmount()
        {
            return !Cart.GetCart(Session).OpenCashDrawerAmount;
        }
        #endregion
    }
}
