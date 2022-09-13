using System.Data;
using WebApplication.Data;

namespace WebApplication.Business
{
    /// <summary>
    /// Ordens Business
    /// </summary>
    public class OrdensBusiness
    {
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <returns>DataTable</returns>
        public DataTable Get(ContextBase contextBase)
        {            
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateOrdens().Get());
            }            
        }

        /// <summary>
        /// List Product
        /// </summary>
        /// <param name="orderId">orderId</param>
        /// <returns>html list product by order</returns>
        public static string ListProduct(string orderId = "")
        {
            string html = string.Empty;

            DataTable listProductbyOrder = new DataTable();
           // DataTable dtSubtotal = new DataTable();

            using (AccessData accessData = new AccessData(new ContextBase()))
            {
                listProductbyOrder = accessData.GetDT(Factory.CreateOrdens().ListProductByOrder(orderId));
             //   dtSubtotal = accessData.GetDT(Factory.CreateOrdens().ListProductByOrder(orderId));
            }

            decimal totalFinal = 0;

            if (listProductbyOrder != null && listProductbyOrder.Rows.Count > 0)
            {
                string id, description, total, quant, price;
                
                foreach (DataRow dr in listProductbyOrder.Rows)
                {                    
                    id = dr["Id"].ToString();
                    description = dr["Description"].ToString();
                    total = dr["total"].ToString();
                    price = dr["price"].ToString();
                    quant = dr["quant"].ToString();
                    totalFinal += decimal.Parse(total);
                    html += $@"<table style=""min-width: 100%; padding-top: 10px;"">
                                <tr>
                                    <td style=""width: 32px;""><a class=""imgcoll  collapsed"" align=""middle"" width=""20"" height=""20"" data-toggle=""collapse""   data-target=""#divproduto-{id}""></a></td>
                                    <td>
                                        <table data-toggle=""collapse"" data-target=""#divproduto-{id}""  style=""min-width: 100%;"">
                                            <tr>
                                                <td rowspan=""2"" style=""width: 60px;"">
                                                    <img src=""Content/Image/product.png"" align=""middle"" width=""50"" height=""50"" /></td>
                                                <td style=""padding-left: 10px;"">
                                                    <div class=""form-group"">
                                                        <div>
                                                            <label style="" padding-bottom: 0px; margin-bottom: 0px;"">{description}</label>
                                                        </div>
                                                        <div>
                                                            <label style="" padding-bottom: 0px; margin-bottom: 0px;"">${price} X {quant}</label>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td rowspan=""2"">
                                                    <label>${total}</label>
                                                </td>
                                                
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>";
                   
                }
            }

            html += $@"<div style='display:none'>
                                <input id='_Subtotal' type='number' value='{totalFinal}' />
                                <input id='_Tax' type='number' value='0' />
                                <input id='_Discount' type='number' value='0' />
                                <input id='_Applied' type='number' value='0' />
                                <input id='_Total' type='number' value='{totalFinal}' />
                                <input id='_Refunded' type='number' value='0' />
                                <input id='_CashonDelivery' type='number' value='0' />
                                <input id='_Change' type='number' value='0' />
                       </div>";
            return html;
        }
    }
}