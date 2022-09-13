using System;

namespace WebApplication.Data.Persistence
{
    /// <summary>
    /// Web session
    /// </summary>
    public class OrdensSQl
    {       
        public string Get()
        {
            string sql = @"select 
	ROW_NUMBER() OVER(ORDER BY max(t.At) ASC) as OrdemId,
    i.OrdemId as Id,
	sum(i.quant) as quant,
	c.Email, 
	max(o.total) as total, 
	max(t.At) as At 
from OrdemItem i with (nolock)
join Ordem o with (nolock)on o.id = i.OrdemId
join Customer c with (nolock) on c.id = o.customerID
join [Transaction] t with (nolock) on  t.OrdemId = o.id
group by i.OrdemId, c.Email";

            return sql;
        }

        public string ListProductByOrder(string orderId)
        {            
            string sql = $@"select p.Id,(i.price * i.quant) as total,
	Description, i.price, i.quant
from OrdemItem i with (nolock) join Product p with (nolock) on i.ProductId = p.id
where OrdemId = '{orderId}'";

            return sql;
        }
    }
}