using System;
using System.Collections.Generic;
using System.Linq;

namespace WebApplication.Entity
{
    public class Pay
    {
        public Order Ordem { get; set; }

        public List<OrderItem> OrdemItens { get; set; }

        public Transaction Transaction { get; set; }

        public Pay(Cart cart)
        {
            Ordem = new Order();

            OrdemItens = new List<OrderItem>(cart.CartItems.Count);

            foreach (var item in cart.CartItems)
            {
                OrdemItens.Add(new OrderItem()
                {
                    Id = Guid.NewGuid(),
                    OrderId = Ordem.Id,
                    Price = item.Product.Price,
                    Quant = item.Quantity,
                    ProductId = item.Product.Id
                });
            }

            Ordem.Total = cart.CartItems.Sum(x => x.Total);
            Ordem.CustomerId = cart.CustomerId;

            Transaction = new Transaction()
            {
                Id =  Guid.NewGuid(),
                OrderId = Ordem.Id,
                In = cart.Amount,
                Out = cart.Amount - Ordem.Total,
            };
        }
    }
}
