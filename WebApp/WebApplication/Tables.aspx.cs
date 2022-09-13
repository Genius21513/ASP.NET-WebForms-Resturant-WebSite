using AjaxPro;
using System;
using System.Data;
using WebApplication.Business;
using WebApplication.Components;
using WebApplication.Entity;

namespace WebApplication
{
    public partial class Tables : BasePage
    {
        TablesBusiness tablesBusiness;

        public Tables()
        {
            tablesBusiness = new TablesBusiness();
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(Tables));

            
            base.Page_Load(sender, e);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void Save(Entity.Table table)
        {
            tablesBusiness.Add(new Data.ContextBase(), table);
        }

        [AjaxMethod(HttpSessionStateRequirement.ReadWrite)]
        public void SetTable(int tableId)
        {
            Cart.GetCart(Session).SetTable(tableId);
        }

        protected string Body()
        {
            string html = string.Empty;
            string viewOrder = "View Order";
            string setTable = "Set Table";
            string currentTable = "Current Table";
            string status;
            var dtTables = tablesBusiness.Get(contextBase, string.Empty);
            int tableId = Cart.GetCart(Session).TableId;
            string color;
            string label;
            if (dtTables != null && dtTables.Rows.Count > 0)
            {
                foreach (DataRow item in dtTables.Rows)
                {
                    color = "white";
                    if ((bool)item["Active"])
                    {
                        status = viewOrder;
                        color = "cadetblue";
                    }
                    else if (item["Id"].Equals(tableId))
                    {
                        status = currentTable;
                        color = "cadetblue";
                    }
                    else
                    {
                        status = setTable;
                    }
                    label = color == "white" ? "cadetblue" : "white";
                    html += $@"<td>
                                <table style=""margin-left: 5px; margin-right: 5px; margin-bottom: 10px;"">
                                    <tr>
                            <td>
                                <div style=""background-color: {color}; width: 1rem; height: 10rem; margin-top: 5px; padding-bottom: 10px; border-radius: 1em;"">
                                </div>
                            </td>
                            <td style=""padding-left: 5px; align-items: center;"">
                                <div style=""background-color: {color}; width: 10rem; margin-left: 10px; height: 1rem; border-radius: 1em;""></div>
                                <div style=""background-color: {color}; text-align: center; width: 16rem; height: 10rem; margin-top: 5px; border-radius: 1em;"">                                                                                                                                                        
                                    <div>
                                    <h3 style=""color: {label};"">Table {item["Id"]}</h3> 
                                    <p style=""color: {label};"">                                    
                                        Seats: {item["Seats"]}
                                    </p>                                                                                                                    
                                    </div>
                                </div>
                                <div style=""background-color: {color}; width: 10rem; margin-left: 10px; height: 1rem; margin-top: 5px; border-radius: 1em;"">
                                </div>
                            </td>
                            <td>
                                <div style=""background-color: {color}; width: 1rem; height: 10rem; margin-top: 5px; margin-left: 5px; padding-bottom: 10px; border-radius: 1em;"">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan=""3"">
                                <br />
                                <a onclick=""setTable({item["Id"]})"" style=""padding: 0px; margin-top: 10px; z-index: 10;"">
                                    <div style=""display: grid; place-items: center; background-color: azure; border-radius: 1em; border: 1px solid #cfcfcf;"">
                                        <div style=""display: grid; place-items: center; padding-top: 4px; padding-bottom: 4px; width: 70px; border-radius: 1em;"">
                                            <table>
                                                <tr>
                                                    <td>                                                    
                                                        <img id=""btnBarcode"" class=""btnicon"" src=""Content/Image/confirmacao.png"" style=""height: 1rem;"" />
                                                    </td>
                                                    <td style=""padding-left: 2px;"">
                                                        <label style=""color: black; font-size: 1rem; padding-top: 5px;"">{status}</label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </a>
                            </td>
                        </tr>
                    </table></td>";
                }
            }

            return html;
        }
    }
}