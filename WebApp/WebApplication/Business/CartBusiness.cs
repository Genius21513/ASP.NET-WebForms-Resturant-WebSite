using System;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Business
{
    /// <summary>
    /// Cart Business 
    /// </summary>
    public class CartBusiness
    {
        /// <summary>
        /// Pay
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="cart">cart</param>
        /// <returns>order id</returns>
        public Guid Pay(ContextBase contextBase, Cart cart)
        {
            Guid orderId = Guid.Empty; ;

            if (cart != null)
            {
                using (AccessData accessData =  new AccessData(contextBase))
                {
                    try
                    {
                        Pay pay = new Pay(cart);
                        accessData.DoSql(Factory.CreateCart().Pay(pay));
                        orderId = pay.Ordem.Id;
                    }
                    catch
                    {
                        accessData.SetAbort();
                    }

                    accessData.SetComplete();                    
                }
            }
            else
            {
                orderId = Guid.Empty;
            }

            return orderId;
        } 
    }
}