using System;
using WebApplication.Entity;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class CartSQL
    {       
        public string Pay(Pay apy)
        {
            string sql = $@"INSERT INTO [Ordem] (Id, Total, CustomerId) VALUES ('{apy.Ordem.Id}', {apy.Ordem.Total},{apy.Ordem.CustomerId})";

            foreach (var item in apy.OrdemItens)
            {
                sql += $@"
                            INSERT INTO [OrdemItem] (Id,OrdemId, Price, Quant, ProductId) VALUES ('{item.Id}','{item.OrderId}',{item.Price},{item.Quant},{item.ProductId})";
            }

            sql += $@"
                            INSERT INTO [Transaction] (Id, OrdemId,[In], [Out]) VALUES ('{apy.Transaction.Id}','{apy.Transaction.OrderId}',{apy.Transaction.In},{apy.Transaction.Out})";

            return sql;
        }        
    }
}