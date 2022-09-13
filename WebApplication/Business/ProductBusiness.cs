using System.Data;
using WebApplication.Data;
using WebApplication.Entity;

namespace WebApplication.Business
{
    /// <summary>
    /// Product Business 
    /// </summary>
    public class ProductBusiness
    {
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="contextBase">context base</param>
        /// <param name="input">description search</param>
        /// <returns></returns>
        public DataTable Get(ContextBase contextBase, string input)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateProduct().Search(input));
            }
        }

        public static void Save(Product product)
        {
            using (AccessData accessData = new AccessData())
            {
                accessData.DoSql(Factory.CreateProduct().Save(product));
            }
        }
    }
}
