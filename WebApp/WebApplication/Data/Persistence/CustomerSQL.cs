using System;
using WebApplication.Entity;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class CustomerSQL
    {       
        public string GetUser()
        {
            string sql = "";

            return sql;
        }

        public string Search(string input)
        {
            string where = $"AND FirstName LIKE '%{input}'";

            string sql = "SELECT Id, FirstName,Email, PhoneNumber FROM [dbo].[Customer] WITH (NOLOCK) WHERE 1 = 1";

            if (!string.IsNullOrWhiteSpace(input))
            {
                sql += where;

            }

            return sql;
        }

        public string Add(Customer customer)
        {
            string sql = $@"INSERT INTO [dbo].[Customer]
                                     ([FirstName]
                                     ,[LastName]
                                     ,[Email]
                                     ,[PhoneNumber]
                                     ,[Address1]
                                     ,[Address2]
                                     ,[CountryId]
                                     ,[StateId]
                                     ,[CityId]
                                     ,[PostalCode])
                               VALUES
                                     ('{customer.FirstName}'
                                     ,'{customer.LastName}'
                                     ,'{customer.Email}'
                                     ,'{customer.PhoneNumber}'
                                     ,'{customer.Address1}'
                                     ,'{customer.Address2}'
                                     ,{customer.Country}
                                     ,{customer.State}
                                     ,{customer.City}
                                     ,'{customer.PostalCode}')";

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

        internal string GetName(int customerId)
        {
            string sql = $"SELECT FirstName FROM [dbo].[Customer] WITH (NOLOCK) WHERE Id = {customerId}";

            return sql;

        }

        internal string Update(Customer customer)
        {
            string sql = $@"UPDATE [dbo].[Customer]
                           SET [FirstName] = '{customer.FirstName}'
                              ,[LastName] = '{customer.LastName}'
                              ,[Email] = '{customer.Email}'
                              ,[PhoneNumber] = '{customer.PhoneNumber}'
                              ,[Address1] = '{customer.Address1}'
                              ,[Address2] = '{customer.Address2}'
                              ,[CountryId] = {customer.Country}
                              ,[StateId] = {customer.State}
                              ,[CityId] = {customer.City}
                              ,[PostalCode] = '{customer.PostalCode}'
                         WHERE Id = {customer.Id}
                        ";
            return sql;
        }
    }
}