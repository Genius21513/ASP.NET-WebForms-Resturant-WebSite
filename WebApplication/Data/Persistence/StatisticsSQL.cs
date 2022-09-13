using System;
using System.Security.Policy;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class StatisticsSQl
    {       
        public string Get()
        {
            string sql = $@"SELECT 
                                T.Id, 
                                ISNULL(OrdemId, '{Guid.Empty}') as OrdemId, 
                                [In], 
                                [Out], 
                                M.Description MethodId, 
                                ISNULL(Reference, '-') AS Reference, 
                                At 
                                FROM [Transaction] T WITH (NOLOCK)
                                JOIN MethodPay M WITH (NOLOCK) ON M.Id = MethodId ORDER BY At DESC";
            return sql;
        }

        public string GetDash()
        {
            string sql = @"SELECT 	
                          	SUM(CASE WHEN MethodId = 2 THEN [IN] ELSE 0 END) AS OpenCash,
                          	SUM(CASE WHEN MethodId = 1 THEN [IN] - [OUT] ELSE 0 END) AS CashSale,	
                          	SUM(CASE WHEN MethodId = 1 THEN [IN] ELSE 0 END) AS TotalSale,	
                          	SUM([IN] - [OUT]) DrawerAmount 
                          FROM [Transaction] WITH (NOLOCK)";

            return sql;
        }

        public string Manual(decimal _in, decimal _out, string reference)
        {
            string sql = $@"INSERT INTO [Transaction] 
                            (Id, OrdemId,[In], [Out], Reference, MethodId) 
                            VALUES 
                            ('{Guid.NewGuid()}',NULL,{_in},{_out}, '{(string.IsNullOrWhiteSpace(reference) ? "-" : reference)}',3)";
            return sql;
        }

        public string OpenCashDrawerAmount(decimal amount)
        {
            string sql = $@"INSERT INTO [Transaction] 
                            (Id, OrdemId,[In], [Out], Reference, MethodId) 
                            VALUES 
                            ('{Guid.NewGuid()}',NULL,{amount},0, '-',2)";
            return sql;
        }
    }
}