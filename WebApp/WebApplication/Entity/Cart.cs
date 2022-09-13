using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.SessionState;
using WebApplication.Business;

namespace WebApplication.Entity
{
    /// <summary>
    /// Cart class
    /// </summary>
    public class Cart
    {
        /// <summary>
        /// Id
        /// </summary>
        public Guid Id { get; set; }

        /// <summary>
        /// Open Cash Drawer Amount
        /// </summary>
        public bool OpenCashDrawerAmount { get; set; } = false;

        /// <summary>
        /// User Id
        /// </summary>
        public int UserId { get; set; }

        /// <summary>
        /// Customer Id
        /// </summary>
        public int CustomerId { get; set; } = 1;

        /// <summary>
        /// Table Id
        /// </summary>
        public int TableId { get; set; }

        /// <summary>
        /// Sub Total
        /// </summary>
        public decimal SubTotal
        {
            get 
            { 
                decimal total = 0;

                CartItems.ForEach(x =>
                {
                    total += x.Total; 
                });

                if (Tax > 0)
                {

                }

                return total;
            }
        }
        
        /// <summary>
        /// Sub Total Format
        /// </summary>
        public string SubTotalString => SubTotal.ToString("#,###,##0.00");
        
        /// <summary>
        /// Tax
        /// </summary>
        public decimal Tax { get; set; }
        
        /// <summary>
        /// Tax Format
        /// </summary>
        public string TaxString => Tax.ToString(Const.FormatNumber);

        /// <summary>
        /// Discount
        /// </summary>
        public decimal Discount { get; set; }

        /// <summary>
        /// Discount Format
        /// </summary>
        public string DiscountString => Discount.ToString(Const.FormatNumber);

        /// <summary>
        /// Applied Coupons
        /// </summary>
        public string AppliedCoupons { get; set; } = Const.NA;

        /// <summary>
        /// Proceed to Pay
        /// </summary>
        public decimal ProceedtoPay => SubTotal + Tax - Discount;

        /// <summary>
        /// Proceed to Pay String
        /// </summary>
        public string ProceedtoPayString => ProceedtoPay.ToString(Const.FormatNumber);

        /// <summary>
        /// Proceed to Pay Quant
        /// </summary>
        public string ProceedtoPayQuant => CartItems.Sum(x => x.Quantity).ToString();
        
        /// <summary>
        /// Order
        /// </summary>
        public string Order { get; set; }

        /// <summary>
        /// Holder Order
        /// </summary>
        public Dictionary<int, List<CartItems>> HoldOrder { get; set; }

        /// <summary>
        /// Cart items
        /// </summary>
        public List<CartItems> CartItems { get; set; }

        /// <summary>
        /// Products cache
        /// </summary>
        public DataTable Products { get; set; }

        /// <summary>
        /// Amount
        /// </summary>
        public decimal Amount { get; set; }

        /// <summary>
        /// Cart itens html
        /// </summary>
        public string CartItensHtml
        {
            get
            {
                string html =  string.Empty;
                
                CartItems.ForEach(x =>
                {
                    html += HtmlItemCar(x);
                });

                return html;
            }
        }

        /// <summary>
        /// Construtor
        /// </summary>
        public Cart()
        {
            Id = Guid.NewGuid();
            CartItems = new List<CartItems>();
        }

        /// <summary>
        /// Add hol order
        /// </summary>
        public void AddHoldOrder()
        {
            if (HoldOrder.ContainsKey(CustomerId))
            {
                HoldOrder[CustomerId] = CartItems;
            }
            else
            {
                HoldOrder.Add(CustomerId, CartItems);
            }

            if (TableId > 0)
            {
                TablesBusiness.AddHoldOrder(this);
            }

            CartItems = new List<CartItems>();
        }

        /// <summary>
        /// Pay
        /// </summary>
        /// <param name="amount">amount</param>
        /// <returns>Order id</returns>
        public Guid Pay(decimal amount)
        {
            Amount = amount;
            Guid orderId;

            CartBusiness cartBusiness = new CartBusiness();

            orderId = cartBusiness.Pay(new Data.ContextBase(), this);
           
            return orderId;
        }

        /// <summary>
        /// Static get cart
        /// </summary>
        /// <param name="httpSessionState"></param>
        /// <returns></returns>
        public static Cart GetCart(HttpSessionState httpSessionState)
        {
            return (Cart)httpSessionState[httpSessionState[Const.SessionCartName].ToString()];
        }

        /// <summary>
        /// Construtor new cart
        /// </summary>
        /// <param name="session"></param>
        /// <param name="dtProducts"></param>
        public Cart(HttpSessionState session, DataTable dtProducts)
        {
            Id = Guid.NewGuid();
            CartItems = new List<CartItems>();
            HoldOrder = new Dictionary<int, List<CartItems>>();
            Products = dtProducts;
            session.Add(Id.ToString(), this);
            session.Add(Const.SessionCartName, Id.ToString());
        }

        /// <summary>
        /// Html item car
        /// </summary>
        /// <param name="cartItems"></param>
        /// <returns></returns>
        public string HtmlItemCar(CartItems cartItems)
        {
            string urlImg = string.IsNullOrWhiteSpace(cartItems.Product.UrlImg) ? "product.png" : cartItems.Product.UrlImg;

            return $@"<tr class='cart-itens-product' id='cart-product-{cartItems.Product.Id}'>
                        <td> 
                        <table style=""min-width: 100%; padding-top: 10px;"">
                            <tr>
                                <td style=""width: 32px;""><a class=""imgcoll  collapsed"" align=""middle"" width=""20"" height=""20"" data-toggle=""collapse""   data-target=""#divproduto-{cartItems.Product.Id}""></a></td>
                                <td>
                                    <table data-toggle=""collapse"" data-target=""#divproduto-{cartItems.Product.Id}""  style=""min-width: 100%;"">
                                        <tr>
                                            <td rowspan=""2"" style=""width: 60px;"">
                                                <img src=""upload/product/{urlImg}"" align=""middle"" width=""50"" height=""50"" /></td>
                                            <td style=""padding-left: 10px;"">
                                                <div class=""form-group"">
                                                    <div>
                                                        <label style="" padding-bottom: 0px; margin-bottom: 0px;"">{cartItems.Product.Description}</label>
                                                    </div>
                                                    <div>
                                                        <label style="" padding-bottom: 0px; margin-bottom: 0px;"">${cartItems.Product.Price} X {cartItems.Quantity}</label>
                                                    </div>
                                                </div>
                                            </td>
                                            <td rowspan=""2"">
                                                <label>${cartItems.Quantity * cartItems.Product.Price} (ex. tax)</label>
                                            </td>
                                            <td rowspan=""2"" style=""width: 22px;"">
  
                                                <a onclick='Delete({cartItems.Product.Id})'>
                                                <span role=""img"" aria-label=""delete"" class=""anticon anticon-delete""><svg viewBox=""64 64 896 896"" focusable=""false"" data-icon=""delete"" width=""1em"" height=""1em"" fill=""currentColor"" aria-hidden=""true""><path d=""M360 184h-8c4.4 0 8-3.6 8-8v8h304v-8c0 4.4 3.6 8 8 8h-8v72h72v-80c0-35.3-28.7-64-64-64H352c-35.3 0-64 28.7-64 64v80h72v-72zm504 72H160c-17.7 0-32 14.3-32 32v32c0 4.4 3.6 8 8 8h60.4l24.7 523c1.6 34.1 29.8 61 63.9 61h454c34.2 0 62.3-26.8 63.9-61l24.7-523H888c4.4 0 8-3.6 8-8v-32c0-17.7-14.3-32-32-32zM731.3 840H292.7l-24.2-512h487l-24.2 512z""></path></svg></span>
                                                 </a>
                                               
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
 
                        <div id=""divproduto-{cartItems.Product.Id}"" class=""collapse"" style=""margin-left: 20px;"">
                            <table>
                                <tr>
                                    <td>
                                        <div class=""form-group"">
                                            <div>Quantity</div>
                                            <div><input value='-'  style=""background-color:#027491; border: none; color: white;  ""  onclick=""document.getElementById('quantity-{cartItems.Product.Id}').stepDown()"" type='button'/>&nbsp;<input type='number' id='quantity-{cartItems.Product.Id}'  min=""""1"""" value='{cartItems.Quantity}' />&nbsp;<input  style=""background-color:#027491; border: none; color: white; "" onclick=""document.getElementById('quantity-{cartItems.Product.Id}').stepUp()"" value='+' type='button'/>&nbsp;&nbsp;</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class=""form-group"">
                                            <div>Price Per Unit</div>
                                            <div><input type='number' id='price-{cartItems.Product.Id}'  min=""""-1"""" value='{cartItems.Product.Price}'/>&nbsp;&nbsp;<input type='button' style=""background-color:#027491; border: none;color: white;  "" onclick='Update({cartItems.Product.Id})' value='Update'/></div>
                                        </div>
                                    </td>
                                    <td></td>
                                </tr>
                            </table>                             
                        </div>     
						</td> </tr>";
        }

        /// <summary>
        /// Add product
        /// </summary>
        /// <param name="productId">Id</param>
        /// <returns>cart</returns>
        public CartItems AddProduct(int productId)
        {            
            CartItems cartItems;
            if (CartItems.Count(x=>x.Product.Id == productId) > 0)
            {
                cartItems = this.CartItems.FirstOrDefault(x => x.Product.Id == productId);

                cartItems.Quantity += 1;
            }
            else
            {
                cartItems = new CartItems()
                {
                    Product = new Product(Products.Select($"Id = {productId}")[0]),
                    Quantity = 1
                };

                this.CartItems.Add(cartItems);
            }

            return cartItems;
        }

        /// <summary>
        /// Edit product
        /// </summary>
        /// <param name="productId">product id</param>
        /// <param name="quant">quantity</param>
        /// <param name="perUnit">price</param>
        public void EditProduct(int productId, int quant, decimal perUnit)
        {
           var cartItems =  CartItems.Where(x => x.Product.Id == productId);

            foreach (var item in cartItems)
            {
                item.Quantity = quant;
                item.Product.Price = perUnit;
            }
        }

        /// <summary>
        /// Remove product
        /// </summary>
        /// <param name="productId"></param>
        public void RemoveProduct(int productId)
        {            
            CartItems.RemoveAll(x => x.Product.Id == productId);
        }

        /// <summary>
        /// Reset
        /// </summary>
        /// <param name="order">order</param>
        public void Reset(string order = "")
        {
            Order = order;
            CartItems = new List<CartItems>();
        }

        /// <summary>
        /// Set Costomer
        /// </summary>
        /// <param name="customerId"></param>
        public void SetCustomer(int customerId)
        {
            CustomerId = customerId;            
        }

        /// <summary>
        /// Set Costomer
        /// </summary>
        /// <param name="tableId">table id</param>
        public void SetTable(int tableId)
        {
            TableId = tableId;
        }
    }
}