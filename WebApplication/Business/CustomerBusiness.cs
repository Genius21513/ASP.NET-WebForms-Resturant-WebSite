using System.Data;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Business
{
    /// <summary>
    /// Customer Business
    /// </summary>
    public class CustomerBusiness
    {
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="contextBase">Context</param>
        /// <param name="input">input</param>
        /// <returns>DataTable Customer</returns>
        public DataTable Get(ContextBase contextBase, string input)
        {            
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateCustomer().Search(input));                
            }            
        }        
        
        /// <summary>
        /// Add
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="customer">customer</param>
        public void Add(ContextBase contextBase, Customer customer)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                if (customer.Id > 0)
                {
                    accessData.DoSql(Factory.CreateCustomer().Update(customer));
                }
                else
                {
                    accessData.DoSql(Factory.CreateCustomer().Add(customer));
                }

                accessData.SetComplete();
            }
        }

        /// <summary>
        /// Delete
        /// </summary>
        /// <param name="contextBase">Context</param>
        /// <param name="customerId">customer id</param>
        public void Delete(ContextBase contextBase, int customerId)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                accessData.DoSql(Factory.CreateCustomer().Delete(customerId));

                accessData.SetComplete();
            }
        }

        /// <summary>
        /// Ger by Customer Id
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="customerId">customer Id</param>
        /// <returns>Customer</returns>
        public Customer GetById(ContextBase contextBase, int customerId)
        {
            DataTable dt;

            using (AccessData accessData = new AccessData(contextBase))
            {
                dt = accessData.GetDT(Factory.CreateCustomer().GetById(customerId));                
            }

            return new Customer(dt);
        }

        /// <summary>
        /// Get name by Id
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="customerId">customer Id</param>
        /// <returns>Name</returns>
        public string GetName(ContextBase contextBase, int customerId)
        {
            string name = string.Empty;

            using (AccessData accessData = new AccessData(contextBase))
            {
                var result = accessData.GetDT(Factory.CreateCustomer().GetById(customerId));

                if (result != null && result.Rows.Count > 0)
                {
                    name = result.Rows[0]["FirstName"].ToString();
                }
                else
                {
                    name = Const.NA;
                }
            }

            return name;
        }
    }
}
