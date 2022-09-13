using System;
using WebApplication.Entity;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Tables SQL
    /// </summary>
    public class TablesSQL
    {            
        public string Search(string input)
        {
            string where = $"AND Description LIKE '%{input}'";

            string sql = "SELECT * FROM [dbo].[Table] WITH (NOLOCK) WHERE 1 = 1";

            if (!string.IsNullOrWhiteSpace(input))
            {
                sql += where;

            }

            return sql;
        }

        public string Add(Table table)
        {
            string sql = $@"INSERT INTO [dbo].[Table]
                                       ([Id]
                                       ,[Description]
                                       ,[Active]
                                       ,[Seats])
                                 VALUES
                                       ({table.Id}
                                       ,'Table {table.Id}'
                                       ,0
                                       ,{table.Seats})                            
                            ";

            return sql;
        }

        public string GetById(int tableId)
        {
            string sql = $"SELECT * FROM [dbo].[Table] WITH (NOLOCK) WHERE Id = {tableId}";

            return sql;
        }

        public string Delete(int tableId)
        {
            string sql = $"DELETE FROM [dbo].[Table] WHERE Id = {tableId}";

            return sql;
        }

        internal string GetName(int tableId)
        {
            string sql = $"SELECT Description FROM [dbo].[Table] WITH (NOLOCK) WHERE Id = {tableId}";

            return sql;

        }

        internal string Update(Table table)
        {
            string sql = $@"UPDATE [dbo].[Table]
                           SET [Description] = '{table.Description}'
                              ,[Seats] = '{table.Seats}'
                              ,[Active] = {(table.Active ? 1 : 0)}
                         WHERE Id = {table.Id}
                        ";
            return sql;
        }

        internal string AddHoldOrder(int tableId, int customerId, string json)
        {
            string sql = $@"UPDATE [dbo].[Table]
                            SET [CustomerId] = {customerId}
                               ,[HoldOrder] = '{json}'
                               ,[Active] = 1                                           
                            WHERE Id = {tableId}
                        ";
            return sql;
        }
    }
}