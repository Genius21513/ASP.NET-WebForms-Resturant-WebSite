using System.Data;
using WebApplication.Data;

namespace WebApplication.Business
{
    /// <summary>
    /// Statistics Business
    /// </summary>
    public class StatisticsBusiness
    {
        /// <summary>
        /// Get
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <returns>DataTable with statistics</returns>
        public DataTable Get(ContextBase contextBase)
        {            
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateStatistics().Get());
            }            
        }

        /// <summary>
        /// Get dahs
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <returns>DataTable with dash</returns>
        public DataTable GetDash(ContextBase contextBase)
        {            
            using (AccessData accessData = new AccessData(contextBase))
            {
                return accessData.GetDT(Factory.CreateStatistics().GetDash());
            }            
        }

        /// <summary>
        /// Manual
        /// </summary>
        /// <param name="contextBase">context base</param>
        /// <param name="_in">in</param>
        /// <param name="_out">out</param>
        /// <param name="reference">reference</param>
        public static void Manual(ContextBase contextBase, decimal _in, decimal _out, string reference)
        {            
            using (AccessData accessData = new AccessData(contextBase))
            {
                accessData.DoSql(Factory.CreateStatistics().Manual(_in, _out, reference));
            }            
        }

        /// <summary>
        /// Open Cash Drawer Amount
        /// </summary>
        /// <param name="contextBase">context</param>
        /// <param name="amount">amount</param>
        /// <returns></returns>
        public static bool OpenCashDrawerAmount(ContextBase contextBase, decimal amount)
        {
            try
            {
                using (AccessData accessData = new AccessData(contextBase))
                {
                    accessData.DoSql(Factory.CreateStatistics().OpenCashDrawerAmount(amount));
                    return true;
                }
            }
            catch
            {
                return false;
            }            
        }
    }
}
