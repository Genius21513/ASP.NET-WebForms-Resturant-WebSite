using System;
using WebApplication.Entity;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class ProductSQL
    {              
        public string Search(string input)
        {
            string where = $"AND Description LIKE '%{input}'";

            string sql = @"SELECT [Id]
                                 ,[Description]
                                 ,[Price]
                                 ,[UrlImg]
                                 ,[CategoryId]
                             FROM [dbo].[Product] WITH (NOLOCK) WHERE 1 = 1";

            if (!string.IsNullOrWhiteSpace(input))
            {
                sql += where;

            }

            return sql;
        }         

        public string GetById(int id)
        {
            string sql = $"SELECT * FROM [dbo].[Customer] WITH (NOLOCK) WHERE Id = {id}";

            return sql;
        }

        public string Delete(int id)
        {
            string sql = $"DELETE FROM [dbo].[Customer] WHERE Id = {id}";

            return sql;
        }

        public string Save(Product product)
        {
            return $@"INSERT INTO [dbo].[Product]
                           ([Description]
                           ,[Price]
                           ,[UrlImg]
                           ,[CategoryId])
                     VALUES
                           ('{product.Description}'
                           ,{product.Price}
                           ,'{product.UrlImg}'
                           ,{product.CategoryId})";
        }
    }
}