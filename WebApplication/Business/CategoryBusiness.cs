using System.Data;
using WebApplication.Data;

namespace WebApplication.Business
{
    /// <summary>
    /// User Business
    /// </summary>
    public class CategoryBusiness
    {
        public DataTable List(ContextBase contextBase)
        {
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateCategoy().List());
            }
        }        
    }
}
