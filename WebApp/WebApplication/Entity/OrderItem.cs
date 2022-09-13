using System;
using System.Data;

namespace WebApplication.Entity
{
    /// <summary>
    /// Order Item
    /// </summary>
    public class OrderItem
    {
        /// <summary>
        /// Id
        /// </summary>
        public Guid Id { get; set; }

        /// <summary>
        /// OrderId
        /// </summary>
        public Guid OrderId { get;set; }
        
        /// <summary>
        /// Quant
        /// </summary>
        public int Quant { get; set; }

        /// <summary>
        /// Price
        /// </summary>
        public decimal Price { get; set; }

        /// <summary>
        /// Total
        /// </summary>
        public decimal Total { get; set; }

        /// <summary>
        /// ProductId
        /// </summary>
        public int ProductId { get; internal set; }

        public OrderItem()
        {

        }

        public OrderItem(DataTable dtOrderItem)
        {
            
        }
    }
}