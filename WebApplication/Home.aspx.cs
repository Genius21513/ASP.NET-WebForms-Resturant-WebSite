using AjaxPro;
using System;
using WebApplication.Business;
using WebApplication.Components;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Home : BasePage
    {
        protected int TableId => Cart.GetCart(Session).TableId;

        protected string LabelTable
        {
            get
            {
                return (TableId == 0 ? "Select Table" : "Table " + TableId);
            }
        }
        ProductBusiness productBusiness;
        CustomerBusiness customerBusiness;
        UserBusiness userBusiness;

        public Home()
        {
            productBusiness = new ProductBusiness();
            customerBusiness = new CustomerBusiness();
            userBusiness = new UserBusiness();
        }

        protected override void Page_Load(object sender, EventArgs e)
        {            
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Home));

            base.Page_Load(sender, e);
            if (!Page.IsPostBack)
            {                
                System.Data.DataTable listaProdutos = productBusiness.Get(contextBase, string.Empty);
                if (listaProdutos != null && listaProdutos.Rows.Count > 0)
                {
                    grdDados.DataSource = listaProdutos;
                    grdDados.DataBind();
                }

                customerName.InnerText = customerBusiness.GetName(contextBase, Cart.GetCart(Session).CustomerId);
            }

            contextBase.User = Session["User"].ToString();

            category.Visible = userBusiness.DisplayCategoryCards(contextBase);
            labelSelectCate.Visible = category.Visible;
        }

        #region AJAX
        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void AddProduct(Product product, object file)
        {
            ProductBusiness.Save(product);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void SetTable(int tableId)
        {
            Cart.GetCart(Session).SetTable(tableId);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart Start()
        {
            return Cart.GetCart(Session);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart AddHoldOrder()
        {
            Cart cart = Cart.GetCart(Session);
            cart.AddHoldOrder();

            return cart;
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart Pay(string amount)
        {
            Cart cart = Cart.GetCart(Session);
            Guid order = cart.Pay(decimal.Parse(amount));
            if (Guid.Empty != order)
            {
                cart.Reset(order.ToString());
            }

            return cart;
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart AddCart(int productId)
        {
            Cart cart = Cart.GetCart(Session);

            cart.AddProduct(productId);

            return cart;
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart Reset()
        {
            Cart cart = Cart.GetCart(Session);

            cart.Reset();

            return cart;
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart Delete(int productId)
        {
            Cart cart = Cart.GetCart(Session);

            cart.RemoveProduct(productId);

            return cart;
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public Cart Update(int productId, string quant, string price)
        {
            Cart cart = Cart.GetCart(Session);

            cart.EditProduct(productId, int.Parse(quant), decimal.Parse(price));

            return cart;
        }
        #endregion

        public string FormateProuct(string id, string description, string price, string urlImg)
        {
            if (string.IsNullOrWhiteSpace(urlImg))
            {
                urlImg = "product.png";
            }

            return $@"<div class='product-item' onclick='AddCart({id})'>
                        <img width=""100"" height=""100"" src=""upload/product/{urlImg}"" align=""middle""/>
                        <div>
                            <p style=""text-align: right;"">
                            {description}</br>
                            ${price}</br>                            
                            </p>
                        </div>
                     </div>";
        }
    }
}